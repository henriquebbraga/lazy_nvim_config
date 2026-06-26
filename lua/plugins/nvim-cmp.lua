return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()

    return {
      auto_brackets = {}, -- configure any filetype to auto add brackets
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
      preselect = cmp.PreselectMode.None,
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Insert }),
        -- ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        -- { name = "supermaven" },
        { name = "nvim_lsp" },
        { name = "path" },

      }, {
        { name = "buffer" },
      }),
      -- formatting = {
      --   format = function(entry, item)
      --     local icons = LazyVim.config.icons.kinds
      --     if icons[item.kind] then
      --       item.kind = icons[item.kind] .. item.kind
      --     end
      --
      --     local widths = {
      --       abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
      --       menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
      --     }
      --
      --     for key, width in pairs(widths) do
      --       if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
      --         item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
      --       end
      --     end
      --
      --     return item
      --   end,
      -- },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      sorting = defaults.sorting,
      performance = {
        max_view_entries = 10
      }
    }
  end,
  -- main = "lazyvim.util.cmp",
}
