-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
require("config.keymap.diagnostic")

local default_opts = {
  noremap = true,
  silent = true,
}

local function map(mode, lhs, rhs, opts)
  if opts then
    for k, v in pairs(opts) do
      default_opts[k] = v
    end
  end
  vim.keymap.set(mode, lhs, rhs, default_opts)
end
Grap_err, Grapple = pcall(require, "grapple")
if Grap_err then
  print("Grapple not loaded")
end

-- MAPS AREA
-- tab
map("n", "gt", ":tabnext<Cr>", { desc = "Next tab" })
map("n", "<leader>to", ":tabnew %<Cr>", { desc = "Open buffer in new tab" })
map("n", "<leader>tc", ":tabclose<Cr>", { desc = "Close tab" })

-- copy
map("v", "<leader>y", '"*y', { desc = "Copy to clipboard" })
map("x", "<leader>y", '"*y', { desc = "Copy to clipboard" })
map("n", "<leader>y", '"*yy', { desc = "Copy to clipboard" })

--  delete blackhole
map("v", "x", '"_x', { desc = "Delete to blackhole reg" })
map("x", "x", '"_x', { desc = "Delete to blackhole reg" })
map("n", "x", '"_x', { desc = "Delete to blackhole reg" })

-- stop undo
map("i", " ", "<C-g>u ")
map("i", ",", "<C-g>u,")
map("i", ".", "<C-g>u.")
map("i", ";", "<C-g>u;")

-- easy access
map("i", "<C-j>", "<Esc>", { desc = "Alias for Esc" })
map("i", "<C-l>", "<Esc>A", { desc = "Go to end of the line" })
map("n", "<C-p>", "<C-i>", { desc = "Forward in window history" })

-- pounce
map("x", "s", "<cmd>Pounce<cr>", { desc = "Pounce" })
map("v", "s", "<cmd>Pounce<cr>", { desc = "Pounce" })

-- grapple
map("n", "<leader>k", ":GrapplePopup tags<Cr>", { desc = "Grapple picker" })
map("n", "<C-m>", ":lua Grapple.toggle()<Cr>", { desc = "Add Grapple tag" })

-- ERGO MECH KEYBOARD SHORTCUTS
-- window move
map("n", "<BS>e", "<C-w>k", { desc = "Go to window above" })
map("n", "<BS>u", "<C-w>j", { desc = "Go to window below" })
map("n", "<BS>i", "<C-w>l", { desc = "Go to window to the right" })
map("n", "<BS>n", "<C-w>h", { desc = "Go to window to the left" })

map("n", "<Tab>", ":tabNext<Cr>", { desc = "Next tab" })

map("n", "<BS><BS>", ":GrapplePopup tags<Cr>", { desc = "Grapple picker" })
map("n", "<BS>g", ":lua Grapple.toggle()<Cr>", { desc = "Add Grapple tag" })
map("n", "<BS>o", ":Telescope buffers<Cr>", { desc = "Open buffer" })
map("n", "<BS>m", ":lua print('nothing here yet')", { desc = "nothing" })
map("n", "<BS>h", ":lua print('nothing here yet')", { desc = "nothing" })

map("n", "<leader><BS>", ":lua print('pick something!!!!')<Cr>", { desc = "nothing" })
map("n", "<BS><leader>", ":lua print('pick something on this side!!!!')<Cr>", { desc = "nothing" })

map("n", "<BS>a", ":lua HBChangeInsideAnything()<Cr>", { desc = "change inside anything" })
map("n", "<BS>r", ":lua HBChangeTillAnything()<Cr>", { desc = "change till anything" })
