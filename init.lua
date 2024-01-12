-- bootstrap lazy.nvim, LazyVim and your plugins

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.lazy")
require("custom.hb_easy_term")
require("custom.hydra_setup")
