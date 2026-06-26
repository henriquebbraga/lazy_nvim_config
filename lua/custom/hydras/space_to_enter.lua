local layers_nvim = require("layers")

local layer = layers_nvim.mode.new()

local enter_key = vim.api.nvim_replace_termcodes("<Cr>", true, false, true)
local esc_key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)

local function deactivationWithRetry()
  vim.defer_fn(function()
    layer:deactivate()
    vim.defer_fn(function()
      vim.api.nvim_feedkeys(esc_key, "i", false)
      vim.defer_fn(function()
        vim.api.nvim_feedkeys(esc_key, "n", false)
      end, 5)
    end, 5)
  end, 5)
end

layer:add("i", "<Esc>", function() if layer:active() then layer:deactivate() end end,
  { silent = true, noremap = true, nowait = true })
layer:add("n", "<Esc>", function() if layer:active() then layer:deactivate() end end,
  { silent = true, noremap = true, nowait = true })

layer:add("i", " ", function()
  vim.api.nvim_feedkeys(enter_key, "i", false)
  deactivationWithRetry()
end, { silent = true, noremap = true, nowait = true })


SpaceToEnterLayer = layer
