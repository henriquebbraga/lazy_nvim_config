return {
  "levouh/tint.nvim",
  init = function()
    require("tint").setup({
      tint = -15, -- Darken colors, use a positive value to brighten
      saturation = 0.7, -- Saturation to preserve
      transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
      tint_background_colors = true, -- Tint background portions of highlight groups
      highlight_ignore_patterns = {}, -- Highlight group patterns to ignore, see `string.find`
      window_ignore_function = function()
        return false
      end,
    })
  end,
}
