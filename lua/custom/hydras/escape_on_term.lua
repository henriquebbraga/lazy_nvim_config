local layers_nvim = require("layers")

local layer = layers_nvim.mode.new()

layer:add("t", "<ESC>", "<ESC>", { silent = true, noremap = true, nowait = true })
layer:add("t", "q",
  function()
    vim.api.nvim_feedkeys("q", "t", false)
    layer:deactivate()
  end, { silent = true, noremap = true })

QuickEscKey = layer
