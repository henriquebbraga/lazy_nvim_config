return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    local fzf = require("fzf-lua")
    fzf.setup({
      files = {
        formatter = "path.filename_first",
        git_icons = true,
        prompt = "files:",
        no_header = true,
        cwd_header = false,
        cwd_prompt = false,
      },
      buffers = {
        formatter = "path.filename_first",
        prompt = "buffers:",
        no_header = true,
        fzf_opts = { ["--delimiter"] = " ", ["--with-nth"] = "-1.." },
      },
    })
  end,
  keys = {
    { "<leader><space>", "<cmd>FzfLua files<cr>",                desc = "fzf find files" },
    { "<leader>/",       "<cmd>FzfLua live_grep<cr>",            desc = "fzf grep files" },
    { "<BS>o",           "<cmd>FzfLua buffers<cr>",            desc = "fzf grep files" },
    { "<BS>h",           "<cmd>FzfLua git_status<cr>",            desc = "fzf grep files" },
    { "<leader>sc",      "<cmd>FzfLua grep_cword<cr>",           desc = "fzf under cursor" },
    { "<leader>sd",      "<cmd>FzfLua lsp_document_symbols<cr>", desc = "fzf document symbols" },
    { "gd",              "<cmd>FzfLua lsp_definitions<cr>",      desc = "Go to definition" },
    { "gr",              "<cmd>FzfLua lsp_references<cr>",       desc = "Go to references" },
    { "gi",              "<cmd>FzfLua lsp_implementations<cr>",  desc = "Go to implementations" },
  }
}
