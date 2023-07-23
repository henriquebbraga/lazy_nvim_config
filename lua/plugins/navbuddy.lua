return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  opts = function()
    local actions = require("nvim-navbuddy.actions")
    return {
      window = {
        size = {
          height = "30%",
          width = "80%",
        },
        position = {
          row = "80%",
          col = "50%",
        },
      },
      lsp = {
        auto_attach = true,
      },
      use_default_mappings = false,
      mappings = {
        ["j"] = actions.next_sibling(), -- down
        ["k"] = actions.previous_sibling(), -- up
        ["h"] = actions.parent(), -- Move to left panel
        ["l"] = actions.children(), -- Move to right panel

        ["n"] = actions.parent(), -- Move to left panel
        ["e"] = actions.previous_sibling(), -- up
        ["i"] = actions.children(), -- Move to right panel
        ["u"] = actions.next_sibling(), -- down

        ["0"] = actions.root(),

        ["o"] = actions.select(),
        ["<enter>"] = actions.select(),

        ["<esc>"] = actions.close(), -- Close and cursor to original location
        ["q"] = actions.close(),
      },
    }
  end,
}
