local hb = {
  command_home = "~/hb_easyterm_commands/",
  main_command_file = "main.sh",
}

function HbEasyTermStart()
  -- window total  width
  local width = vim.api.nvim_win_get_width(0)

  vim.cmd("tabnew")
  pcall(vim.cmd, "e " .. hb.command_home .. hb.main_command_file)
  hb.command_window = vim.api.nvim_get_current_win()

  vim.cmd("vsplit")
  vim.cmd("term")
  hb.term_window = vim.api.nvim_get_current_win()
  hb.term_buff_name = vim.api.nvim_buf_get_name(0)

  vim.cmd("Neotree dir=~/hb_easyterm_commands")
  vim.defer_fn(function()
    vim.cmd("vertical resize 30")

    vim.api.nvim_set_current_win(hb.term_window)

    vim.defer_fn(function()
      vim.cmd("vertical resize +" .. ((width / 2) * 0.4))

      -- opening and closing it makes the window follow the input line ¯\_(ツ)_/¯
      local open_and_close = vim.api.nvim_replace_termcodes("i", true, false, true)
      vim.api.nvim_feedkeys(open_and_close, "t", false)
      local leave_term_mode = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true)
      vim.api.nvim_feedkeys(leave_term_mode, "t", false)
      vim.defer_fn(function()
        vim.api.nvim_set_current_win(hb.command_window)
      end, 10)
    end, 20)
  end, 20)
end

-- local function getRegister(char)
--   return vim.api.nvim_exec([[echo getreg(']] .. char .. [[')]], true):gsub("[\n\r]", "^J")
-- end
--
-- local function setRegister(char, content)
--   return vim.api.nvim_exec([[call setreg(']] .. char .. [[', ']] .. content .. [[')]], true)
-- end

function HbEasyTermSend()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  if not string.find(buffer_name, "hb_easyterm_commands") then
    return
  end
  vim.cmd("norm vipy")
  vim.api.nvim_set_current_win(hb.term_window)
  vim.cmd("norm pi")
  local leave_term_mode = vim.api.nvim_replace_termcodes("<Cr><C-\\><C-n>", true, false, true)
  vim.api.nvim_feedkeys(leave_term_mode, "t", false)
  vim.defer_fn(function()
    vim.api.nvim_set_current_win(hb.command_window)
  end, 50)
end

function HbEasyTermSendLine()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  if not string.find(buffer_name, "hb_easyterm_commands") then
    return
  end

  vim.cmd("norm yy")
  vim.api.nvim_set_current_win(hb.term_window)
  vim.defer_fn(function()
    vim.cmd("norm i")
    local cleanline_code = vim.api.nvim_replace_termcodes("<C-u>", true, false, true)
    vim.api.nvim_feedkeys(cleanline_code, "t", false)
    vim.defer_fn(function()
      local leave_term_mode1 = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true)
      vim.api.nvim_feedkeys(leave_term_mode1, "t", false)
      vim.defer_fn(function()
        vim.cmd("norm pi")
        local leave_term_mode = vim.api.nvim_replace_termcodes("<Cr><C-\\><C-n>", true, false, true)
        vim.api.nvim_feedkeys(leave_term_mode, "t", false)
        vim.defer_fn(function()
          vim.api.nvim_set_current_win(hb.command_window)
        end, 50)
      end, 50)
    end, 50)
  end, 50)
end

function HbEasyTermSendAndStay()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  if not string.find(buffer_name, "hb_easyterm_commands") then
    return
  end

  hb.last_cursor_position = vim.api.nvim_win_get_cursor(0)
  vim.cmd("norm yy")
  vim.api.nvim_set_current_win(hb.term_window)
  vim.cmd("norm i")
  local cleanline_code = vim.api.nvim_replace_termcodes("<C-u>", true, false, true)
  vim.api.nvim_feedkeys(cleanline_code, "t", false)
  local leave_term_mode = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true)
  vim.api.nvim_feedkeys(leave_term_mode, "t", false)
  vim.defer_fn(function()
    vim.cmd("norm pi")
    vim.defer_fn(function()
      local tab_char = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
      vim.api.nvim_feedkeys(tab_char, "t", false)
    end, 50)
  end, 50)
end

function HbEasyReturnWithNewCommand()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  if buffer_name ~= hb.term_buff_name then
    print("not on hb term")
    return
  end

  vim.cmd("norm i")
  local cleanline_code = vim.api.nvim_replace_termcodes("<C-u>", true, false, true)
  vim.api.nvim_feedkeys(cleanline_code, "t", false)
  vim.defer_fn(function()
    local base_cursor_pos = vim.api.nvim_win_get_cursor(0)
    local paste_line_back = vim.api.nvim_replace_termcodes("<C-y>@", true, false, true)
    vim.api.nvim_feedkeys(paste_line_back, "t", false)
    vim.defer_fn(function()
      local leave_term_mode = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true)
      vim.api.nvim_feedkeys(leave_term_mode, "t", false)
      vim.defer_fn(function()
        vim.api.nvim_win_set_cursor(0, base_cursor_pos)
        vim.defer_fn(function()
          vim.cmd("norm vt@yi")
          local backsp = vim.api.nvim_replace_termcodes("<BS>", true, false, true)
          vim.api.nvim_feedkeys(backsp, "t", false)
          vim.api.nvim_feedkeys(leave_term_mode, "t", false)
          vim.defer_fn(function()
            vim.api.nvim_set_current_win(hb.command_window)
            vim.cmd("norm Vp")
          end, 50)
        end, 50)
      end, 150)
    end, 50)
  end, 50)
end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>wt", ":lua HbEasyTermStart()<Cr>", opts)
keymap("n", "<leader>c", ":lua HbEasyTermSend()<Cr>", opts)
keymap("n", "<leader>l", ":lua HbEasyTermSendLine()<Cr>", opts)

keymap("n", "<leader>sn", ":lua HbEasyTermSendAndStay()<Cr>", opts)
keymap("t", "<leader>gn", "<C-\\><C-n>:lua HbEasyReturnWithNewCommand()<Cr>", opts)
