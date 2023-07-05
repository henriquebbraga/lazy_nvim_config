return {
  "henriquebbraga/my_pounce.nvim",
  keys = {
    { "s", "<cmd>Pounce<cr>", desc = "Pounce" },
  },
  setup = vim.defer_fn(function()
    require("pounce").setup({
      accept_keys = ">JFKDLSAHGNUVRBYTMICEOXWPQZ",
      accept_best_key = "<space>",
      multi_window = true,
      debug = false,
    })
  end, 100),
}
