return {
  "mvllow/modes.nvim",
  config = function()
    require("modes").setup({
      colors = {
        insert = "#004691",
        visual = "#5e008c",
      },

      line_opacity = 0.9,
      set_cursor = false,
      set_number = false,
    })
  end,
}
