vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.bigfile_size = 1024 * 1024 * 1 -- 1M
vim.g.mapleader = ' '
vim.g.maplocalleaderleader = '\\'

local opt = vim.opt

opt.clipboard = ""
opt.relativenumber = false
opt.shiftwidth = 2
opt.tabstop = 2
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true  -- Use spaces instead of tabs

opt.number = true
opt.showmode = false   -- Dont show mode since we have a statusline
opt.sidescrolloff = 8  -- Columns of context
opt.signcolumn = "yes"
opt.ignorecase = true  -- Ignore case
opt.smartcase = true   -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.termguicolors = true
opt.splitright = true
opt.scrolloff = 15
opt.conceallevel = 1
vim.cmd("set nowrap")

local signs = { Error = "󰅚", Warn = "󰀪", Hint = "󰌶", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
