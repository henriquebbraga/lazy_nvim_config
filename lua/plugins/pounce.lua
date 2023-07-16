-- * `PounceMatch`: Characters that match the fuzzy search pattern.
-- * `PounceUnmatched`: Characters that don't match the fuzzy search pattern.
-- * `PounceGap`: Characters inside a match that are not part of the pattern.
-- * `PounceAccept`: "Accept keys" that can be used to jump to the match.
-- * `PounceAcceptBest`: Highlights the accept key for the best match.
vim.cmd("hi PounceAcceptBest guibg=#f23dff guifg=#000000 gui=BOLD")
vim.cmd("hi PounceAccept guibg=#21daff guifg=#000000 gui=BOLD")
vim.cmd("hi PounceMatch guibg=#ffffff guifg=#777777")
vim.cmd("hi PounceGap guibg=#cf915b guifg=#e0bb9b")

return {
  "henriquebbraga/my_pounce.nvim",
  keys = {
    { "s", "<cmd>Pounce<cr>", desc = "Pounce" },
  },
  setup = vim.defer_fn(function()
    require("pounce").setup({
      accept_keys = "!TSRADCLNEIOHUMGJYZ",
      accept_best_key = "<space>",
      multi_window = true,
      debug = false,
    })
  end, 100),
}
