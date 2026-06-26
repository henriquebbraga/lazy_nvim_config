local hb = {
  command_home = "~/hb_easyterm_commands/",
  main_command_file = "main.sh",
  instances = {},
  channel = {},
}

local function get_hb_instance()
  if hb.instances[vim.api.nvim_get_current_win()] == nil then
    hb.instances[vim.api.nvim_get_current_win()] = {}
  end
  return hb.instances[vim.api.nvim_get_current_win()]
end

local function isHbBuffer()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  if not string.find(buffer_name, "hb_easyterm_commands") then
    return false
  end
  return true
end

local function get_usable_hb_instance()
  if not isHbBuffer() then
    print("not hb buffer")
    error("not hb buffer", 2)
  end
  local hb_instance = get_hb_instance()
  if hb_instance.term_instance == nil then
    print("no term instance")
    error("no term instance", 2)
  end
  return hb_instance
end

function HbEasyTermStart()
  -- window total  width
  local width = vim.api.nvim_win_get_width(0)

  -- open tab and wait
  vim.cmd("tabnew")
  vim.defer_fn(function()
    -- set command window
    local hb_instance = get_hb_instance()
    pcall(vim.cmd, "e " .. hb.command_home .. hb.main_command_file)
    hb_instance.command_window = vim.api.nvim_get_current_win()

    -- open new buf and open a term on it
    vim.cmd("vnew")
    hb_instance.term_instance = vim.fn.termopen("zsh")

    -- wait to get handles
    vim.defer_fn(function()
      hb_instance.term_window = vim.api.nvim_get_current_win()
      hb_instance.term_buff_name = vim.api.nvim_buf_get_name(0)

      -- open neo tree on shell files and wait to resize
      vim.cmd("Neotree dir=~/hb_easyterm_commands position=left")
      vim.defer_fn(function()
        vim.cmd("vertical resize 25")

        -- go back to command window
        vim.api.nvim_set_current_win(hb_instance.command_window)
      end, 10)
    end, 20)
  end, 20)
end

function HbEasyTermSend()
  local success, hb_instance = pcall(get_usable_hb_instance)
  if not success then
    return
  end

  -- select paragraph under cursor and leave visual to set < and > variables
  vim.cmd("norm vip")
  local esc_key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc_key, "n", false)
  vim.defer_fn(function()
    local v_start = vim.fn.getpos("'<")[2]
    local v_end = vim.fn.getpos("'>")[2]
    local lines = table.concat(vim.fn.getline(v_start, v_end), "\n")

    -- send them to the channel
    vim.api.nvim_chan_send(hb_instance.term_instance, lines:gsub("\n", "") .. "\n")
    vim.api.nvim_feedkeys("gvo0", "n", false)
    vim.api.nvim_feedkeys(esc_key, "n", false)
  end, 50)
end

function HbEasyTermSendLine()
  local success, hb_instance = pcall(get_usable_hb_instance)
  if not success then
    return
  end

  vim.cmd("norm V")
  local esc_key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc_key, "n", false)
  vim.defer_fn(function()
    local line_no = vim.fn.getpos("'<")[2]
    local line = table.concat(vim.fn.getline(line_no, line_no), "")
    vim.api.nvim_chan_send(hb_instance.term_instance, line .. "\n")
  end, 50)
end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>tt", ":lua HbEasyTermStart()<Cr>", opts)
keymap("n", "<leader>cc", ":lua HbEasyTermSend()<Cr>", opts)
keymap("n", "<leader>l", ":lua HbEasyTermSendLine()<Cr>", opts)
