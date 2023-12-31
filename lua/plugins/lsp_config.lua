return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "gd", ":Telescope lsp_definitions<Cr>" }
    keys[#keys + 1] = { "gr", ":Telescope lsp_references<Cr>" }
    keys[#keys + 1] = { "gi", ":Telescope lsp_implementations<Cr>" }
  end,
}
