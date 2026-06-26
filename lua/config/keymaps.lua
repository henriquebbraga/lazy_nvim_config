require("config.keymap.diagnostic")

local default_opts = {
  noremap = true,
  silent = true,
}

local function map(mode, lhs, rhs, opts)
  local new_opts = {}
  for k, v in pairs(default_opts) do
    new_opts[k] = v
  end
  if opts then
    for k, v in pairs(opts) do
      new_opts[k] = v
    end
  end
  vim.keymap.set(mode, lhs, rhs, new_opts)
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
map("i", " ", "<C-g>u ", { desc = "Add undo step" })
map("i", ",", "<C-g>u,", { desc = "Add undo step" })
map("i", ".", "<C-g>u.", { desc = "Add undo step" })
map("i", ";", "<C-g>u;", { desc = "Add undo step" })

-- easy access
map("i", "<C-j>", "<Esc>", { desc = "Alias for Esc" })
map("i", "<C-l>", "<Esc>A", { desc = "Go to end of the line" })
map("n", "<C-p>", "<C-i>", { desc = "Forward in window history" })
map("i", "<C-a>", "<C-O>A", { desc = "Easy go to end of line" })
map("n", "-", ":Oil<Cr>", { desc = "Search word under cursor." })
map("n", "gl", function()
  vim.defer_fn(function()
    SpaceToEnterLayer:activate()
    vim.api.nvim_feedkeys("i", "n", false)
  end, 10)
  vim.ui.input({
    prompt = "line number",
  }, function(input)
    if input ~= nil then
      vim.api.nvim_feedkeys(input .. "gg", "n", false)
    end
  end)
end, { desc = "Search word under cursor." })


map("v", "p", "P", { desc = "paste without changing registers" })
map("x", "p", "P", { desc = "paste without changing registers" })

-- ergo keyboard helpers arstneiolcdhum
map("", "m", "w", { desc = "word shortcut" })
map("", "l", "b", { desc = "back shortcut" })
map("", "h", "ve", { desc = "quick shortcut" })

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

-- window management
map("n", "<leader>rr", ":vs<Cr>", { desc = "New vertical split" })
map("n", "<leader>rd", ":q<Cr>", { desc = "Close current window" })
map("n", "<leader>ro", "<C-W>o", { desc = "Close all other windows" })
map("n", "<leader>rs", ":lua vim.lsp.buf.format()<Cr>:w<Cr>", { desc = "Save window/buffer" })

map("n", "<Tab>", ":tabnext<Cr>", { desc = "Next tab" })
map("n", "<S-Tab>", ":tabprevious<Cr>", { desc = "Previous tab" })

map("n", "<BS><BS>", ":Grapple open_tags<Cr>", { desc = "Grapple picker" })
map("n", "<BS>m", ":Grapple toggle<Cr>", { desc = "add to Grapple" })
map("n", "<BS>h", ":lua print('nothing here yet')", { desc = "nothing" })

map("n", "<leader><BS>", ":lua print('pick something!!!!')<Cr>", { desc = "nothing" })
map("n", "<BS><leader>", ":lua print('pick something on this side!!!!')<Cr>", { desc = "nothing" })

-- custom java stuff
map("n", "<leader>T", ":lua JavaUnitTestHelper()<Cr>", { desc = "open test or original file" })
map("n", "<leader>R", ":lua JavaRunUnitTests()<Cr>", { desc = "run unit test" })

-- AI

-- highlighting
map("v", "<leader>r", ":<C-u>HSHighlight 3<Cr>", { desc = "Highlight" })
map("v", "<leader>h", ":<C-u>HSRmHighlight<Cr>", { desc = "Remove highlight" })

-- terminal
map("t", "<esc><esc>", "<C-\\><C-n>")

-- Lazygit gitlazy
map("n", "<leader>gl", function()
  vim.cmd("TermExec name=lazygit cmd='lazygit && exit' direction=float")
  QuickEscKey:activate()
end, { desc = "Lazygit" })

-- Code actions
map("n", "<leader>cr", ":lua vim.lsp.buf.rename()<Cr>", { desc = "Lsp rename" })
map("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<Cr>", { desc = "Lsp code action" })
map("n", "<S-K>", ":lua vim.lsp.buf.hover()<Cr>", { desc = "Lsp hover" })
map("i", "<C-K>", ":lua vim.lsp.buf.signature_help()<Cr>", { desc = "Lsp hover" })
