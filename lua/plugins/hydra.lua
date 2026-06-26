return {
  -- originally: "anuvyklack/hydra.nvim",
  "debugloop/layers.nvim",
  opts = {
    map = nil,
    mode = {
      help = {
        force_mode_headers = false,
        missing_desc_string = "unknown",
      },
      window = {
        config = {
          relative = "editor",
          width = 24,
          -- height dynamically matches the number of keymaps if left empty
          -- col and row will be dynamically set to the bottom right corner if left empty
          anchor = "SE",
          style = "minimal",
          title = "Overlaid Maps",
          border = "rounded",
        },
        opts = {
          wrap = false,
          winhl = "Normal:LayersHelpWindow",
        },
      },
    },

  }, -- see :help Layers.config
}
