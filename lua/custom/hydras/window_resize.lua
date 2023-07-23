local hydra = require("hydra")

local hint = [[
  verical size
  _k_/_e_ +
  _j_/_u_ -
  ^
  horizontal size
  _h_/_n_ +
  _l_/_i_ -
  ^
  _q_ quit
]]

hydra({
  name = "Window Resize",
  hint = hint,
  config = {
    color = "red",
    invoke_on_body = true,
    hint = {
      border = "rounded",
      type = "window",
    },
    on_enter = function() end,
    on_exit = function() end,
  },
  mode = { "n" },
  body = "<leader>ww",
  heads = {
    { "j", ":resize -10<CR>", { silent = true, desc = "decrease verical size" } },
    { "k", ":resize +10<CR>", { silent = true, desc = "increase verical size" } },
    { "h", ":vertical resize +10<CR>", { silent = true, desc = "increase horizontal size" } },
    { "l", ":vertical resize -10<CR>", { silent = true, desc = "dec horizontal size" } },

    { "u", ":resize -10<CR>", { silent = true, desc = "decrease verical size" } },
    { "e", ":resize +10<CR>", { silent = true, desc = "increase verical size" } },
    { "n", ":vertical resize +10<CR>", { silent = true, desc = "increase horizontal size" } },
    { "i", ":vertical resize -10<CR>", { silent = true, desc = "dec horizontal size" } },

    { "q", nil, { exit = true, nowait = true, desc = "exit" } },
  },
})
