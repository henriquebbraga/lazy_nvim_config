return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<leader>o"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
      ["<leader>r"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
    },

    -- Set to false to disable all of the above keymaps
    use_default_keymaps = false,
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    }
  },
}
