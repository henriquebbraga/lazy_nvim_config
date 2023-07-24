local hydra = require("hydra")

local hint = [[
  _j_/_u_: move down 5
  _k_/_e_: move up 5
  ^
  _b_: Toggle block
  ^
  _d_: Document symbols 
  _n_: Navbuddy
  _f_: Fuzzy finder
  ^
  _q_: quit
]]

hydra({
  name = "Move inside files",
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
  body = "<leader>m",
  heads = {
    { "j", "5j", { silent = true } },
    { "u", "5j", { silent = true } },
    { "k", "5k", { silent = true } },
    { "e", "5k", { silent = true } },

    { "d", ":Telescope lsp_document_symbols<Cr>", { exit = true, silent = true } },
    { "f", ":Telescope current_buffer_fuzzy_find<Cr>", { exit = true, silent = true } },
    { "n", ":Navbuddy<CR>", { exit = true, silent = true } },
    { "b", ":Block<CR>", { silent = true } },

    { "q", nil, { exit = true, nowait = true, desc = "exit" } },
  },
})
