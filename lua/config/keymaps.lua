-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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

-- MAPS AREA

-- tab
map("n", "gt", ":tabNext<Cr>", { desc = "Next tab" })

-- copy
map("v", "<leader>y", '"*y', { desc = "Copy to clipboard" })
map("x", "<leader>y", '"*y', { desc = "Copy to clipboard" })
map("n", "<leader>y", '"*yy', { desc = "Copy to clipboard" })

-- easy access
map("i", "<C-j>", "<Esc>", { desc = "Alias for Esc" })
map("i", "<C-l>", "<Esc>A", { desc = "Go to end of the line" })

-- pounce
map("x", "s", "<cmd>Pounce<cr>", { desc = "Pounce" })
map("v", "s", "<cmd>Pounce<cr>", { desc = "Pounce" })

-- ERGO MECH KEYBOARD SHORTCUTS
-- window move
map("n", "<leader>re", "<C-w>k", { desc = "Go to window above" })
map("n", "<leader>ru", "<C-w>j", { desc = "Go to window below" })
map("n", "<leader>ri", "<C-w>l", { desc = "Go to window to the right" })
map("n", "<leader>rn", "<C-w>h", { desc = "Go to window to the left" })
