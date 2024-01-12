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

map("n", "<leader>dn", function()
  vim.diagnostic.goto_next()
  vim.defer_fn(function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).relative ~= "" then
        vim.api.nvim_win_close(win, true)
      end
    end
  end, 10)
end, { desc = "Go to next diagnostic" })
map("n", "<leader>dp", function()
  vim.diagnostic.goto_prev()
  vim.defer_fn(function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).relative ~= "" then
        vim.api.nvim_win_close(win, true)
      end
    end
  end, 10)
end, { desc = "Go to previous diagnostic" })

ShowDiag = true
map("n", "<leader>dt", function()
  if ShowDiag then
    vim.diagnostic.config({ virtual_lines = false })
    ShowDiag = false
  else
    vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
    ShowDiag = true
  end
end, { desc = "toggle diagnostics" })

map("n", "<leader>do", function()
  vim.diagnostic.open_float()
end, { desc = "open diag float" })

map("i", ".", "<Esc>i.")
