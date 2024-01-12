local hydra = require("hydra")

local hint = [[
  Commands
  _l_ : send line
  _c_ : send command (multi_line)
  _s_ : send and stay
  ^
  Terminal
  _b_ : back with command
  _x_ : change terminal
  ^
  _q_: quit
]]

hydra({
  name = "Terminal Helper",
  hint = hint,
  config = {
    color = "red",
    invoke_on_body = true,
    hint = {
      border = "rounded",
      type = "window",
      position = "bottom-right",
    },
    on_enter = function() end,
    on_exit = function() end,
  },
  mode = { "n" },
  body = "<leader>tt",
  heads = {
    { "n", "<C-w>h", { silent = true } },
    { "i", "<C-w>l", { silent = true } },
    { "j", "<C-w>h", { silent = true } },
    { "k", "<C-w>l", { silent = true } },

    { "l", ":lua HbEasyTermSendLine()<Cr>", { exit = true, silent = true } },
    { "c", ":lua HbEasyTermSend()<Cr>", { exit = true, silent = true } },
    { "s", ":lua HbEasyTermSendAndStay()<Cr>", { exit = true, silent = true } },

    { "b", ":lua HbEasyReturnWithNewCommand()<Cr>", { exit = true, silent = true } },
    { "x", ":Telescope buffers<Cr>term://", { exit = true, silent = true } },

    { "q", nil, { exit = true, nowait = true, desc = "exit" } },
  },
})
