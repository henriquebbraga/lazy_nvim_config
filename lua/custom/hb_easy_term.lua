local hb = {
  command_home = "~/hb_easyterm_commands/",
  main_command_file = "main.txt",
}

function HbEasyTermStart()
  -- window total  width
  local width = vim.api.nvim_win_get_width(0)

  vim.cmd("tabnew")
  vim.cmd("e " .. hb.command_home .. hb.main_command_file)
  hb.command_window = vim.api.nvim_get_current_win()

  vim.cmd("vsplit")
  vim.cmd("vertical resize " .. (width * 0.75))
  vim.cmd("term")
  hb.term_window = vim.api.nvim_get_current_win()

  local open_and_close = vim.api.nvim_replace_termcodes("i", true, false, true)
  vim.api.nvim_feedkeys(open_and_close, "t", false)
  vim.api.nvim_set_current_win(hb.command_window)
end

local function getRegister(char)
  return vim.api.nvim_exec([[echo getreg(']] .. char .. [[')]], true):gsub("[\n\r]", "^J")
end

local function setRegister(char, content)
  return vim.api.nvim_exec([[call setreg(']] .. char .. [[', ']] .. content .. [[')]], true)
end

function HbEasyTermSend()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  if not string.find(buffer_name, "hb_easyterm_commands") then
    return
  end
  local currentReg = getRegister('"')

  vim.cmd("norm vipy")
  vim.api.nvim_set_current_win(hb.term_window)
  vim.cmd("norm pi")
  local returnKeycode = vim.api.nvim_replace_termcodes("<Cr><Esc><C-w>h", true, false, true)
  vim.api.nvim_feedkeys(returnKeycode, "t", false)

  setRegister('"', currentReg)
end

function HbEasyTermSendLine()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  if not string.find(buffer_name, "hb_easyterm_commands") then
    return
  end
  local currentReg = getRegister('"')

  vim.cmd("norm yy")
  vim.api.nvim_set_current_win(hb.term_window)
  vim.cmd("norm pi")
  local returnKeycode = vim.api.nvim_replace_termcodes("<Cr><Esc><C-w>h", true, false, true)
  vim.api.nvim_feedkeys(returnKeycode, "t", false)

  setRegister('"', currentReg)
end

function HbEasyTermSendAndStay()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  if not string.find(buffer_name, "hb_easyterm_commands") then
    return
  end

  vim.cmd("norm yy")
  vim.api.nvim_set_current_win(hb.term_window)
  vim.cmd("norm pi")
end

function HbEasyTermTab()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  if not string.find(buffer_name, "hb_easyterm_commands") then
    return
  end

  vim.cmd("norm yy")
  local command = getRegister('"')
  vim.api.nvim_set_current_win(hb.term_window)
  vim.cmd("norm i")
  local cleanline_code = vim.api.nvim_replace_termcodes("<C-u>", true, false, true)
  vim.api.nvim_feedkeys(cleanline_code, "t", false)
  vim.api.nvim_feedkeys(command, "t", false)
  local tab_keycode = vim.api.nvim_replace_termcodes("<BS><BS><Tab><Esc><C-w>h", true, false, true)
  vim.api.nvim_feedkeys(tab_keycode, "t", false)
end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>wt", ":lua HbEasyTermStart()<Cr>", opts)
keymap("n", "<leader>c", ":lua HbEasyTermSend()<Cr>", opts)
keymap("n", "<leader>l", ":lua HbEasyTermSendLine()<Cr>", opts)
keymap("n", "<leader>t", ":lua HbEasySendAndStay()<Cr>", opts)
keymap("n", "<leader>t", ":lua HbEasyReturnWithNewCommand()<Cr>", opts)
