return {
  "chentoast/marks.nvim",
  setup = vim.defer_fn(function()
    require("marks").setup({
      default_mappings = false,
      mappings = {
        set_next = "<BS>h",
        delete_line = "<BS>m",
      },
    })
  end, 100),
}
