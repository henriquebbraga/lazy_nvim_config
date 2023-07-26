local Hydra = require("hydra")
local splits = require("smart-splits")

local cmd = require("hydra.keymap-util").cmd
local pcmd = require("hydra.keymap-util").pcmd

local window_hint = [[
 ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
 ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
 ^ ^ _e_ ^ ^  ^ ^ _E_ ^ ^   ^  ^ _J_   ^   _s_: horizontally 
 _n_ ^ ^ _i_  _N_ ^ ^ _I_   ^ _G_ ^  _Y_   _v_: vertically
 ^ ^ _u_ ^ ^  ^ ^ _U_ ^ ^   ^  ^ _<_   ^   _q_, _c_: close
 focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only

]]

Hydra({
  name = "Windows",
  hint = window_hint,
  config = {
    invoke_on_body = true,
    hint = {
      border = "rounded",
      offset = -1,
    },
  },
  mode = "n",
  body = "<leader>wr",
  heads = {
    { "n", "<C-w>h" },
    { "u", "<C-w>j" },
    { "e", pcmd("wincmd k", "E11", "close") },
    { "i", "<C-w>l" },

    { "N", cmd("WinShift left") },
    { "U", cmd("WinShift down") },
    { "E", cmd("WinShift up") },
    { "I", cmd("WinShift right") },

    {
      "G",
      function()
        splits.resize_left(2)
      end,
    },
    {
      "<",
      function()
        splits.resize_down(2)
      end,
    },
    {
      "J",
      function()
        splits.resize_up(2)
      end,
    },
    {
      "Y",
      function()
        splits.resize_right(2)
      end,
    },
    { "=", cmd("WindowsEqualize"), { exit = true, desc = "equalize" } },

    { "s", pcmd("split", "E36") },
    { "<C-s>", pcmd("split", "E36"), { desc = false } },
    { "v", pcmd("vsplit", "E36") },
    { "<C-v>", pcmd("vsplit", "E36"), { desc = false } },

    { "w", "<C-w>w", { exit = true, desc = false } },
    { "<C-w>", "<C-w>w", { exit = true, desc = false } },

    { "z", cmd("WindowsMaximize"), { exit = true, desc = "maximize" } },
    { "<C-z>", cmd("WindowsMaximize"), { exit = true, desc = false } },

    { "o", "<C-w>o", { exit = true, desc = "remain only" } },
    { "<C-o>", "<C-w>o", { exit = true, desc = false } },

    { "c", pcmd("close", "E444") },
    { "q", pcmd("close", "E444"), { desc = "close window" } },
    { "<C-c>", pcmd("close", "E444"), { desc = false } },
    { "<C-q>", pcmd("close", "E444"), { desc = false } },

    { "<Esc>", nil, { exit = true, desc = false } },
  },
})
