return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false,
  branch = "v3.x",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>ee", "<cmd>Neotree position=float reveal toggle<cr>" }
  },
  opts = {
    buffers = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false
      },
    },
    window = {
      mappings = {
        ["o"] = { "open", nowait = true },
        ["s"] = "none",
        ["<BS>"] = "none",
      },
    },
    filesystem = {
      hijack_netrw_behavior = "disabled",
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    default_component_configs = {
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
      },
      git_status = {
        symbols = {
          -- Change type
          added = "✚ ", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = " ", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "✖ ", -- this can only be used in the git_status source
          renamed = " ", -- this can only be used in the git_status source
          -- Status type
          untracked = "",
          ignored = " ",
          unstaged = "U",
          staged = " ",
          conflict = " ",
        },
      },
    },
  },
}
