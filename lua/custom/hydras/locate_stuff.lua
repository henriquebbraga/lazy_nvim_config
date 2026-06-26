local layers_nvim = require("layers")

local layer = layers_nvim.mode.new()

local newMap = function(lhs, rhs, desc)
  layer:add("n", lhs, rhs, { silent = true, noremap = true, desc = desc })
end

local neoscroll = require('neoscroll')

local function scroll(lines, duration)
  return function()
    neoscroll.scroll(lines, { duration = duration })
  end
end

newMap("e", scroll(-10, 50), "10 up")
newMap("u", scroll(10, 50), "10 down")

newMap("n", scroll(-25, 75), "25 up")
newMap("h", scroll(25, 75), "25 down")

newMap("<Esc>", function() layer:deactivate() end, "leave")

layer:auto_show_help()

vim.keymap.set("n", "<leader>m", function() layer:toggle() end, { silent = true, noremap = true })
