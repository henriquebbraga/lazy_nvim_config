return {
  "sainnhe/gruvbox-material",
  config = function()
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_foreground = 'original'
    vim.cmd.colorscheme("gruvbox-material")
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = "#000000" })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = "#000000" })
    vim.api.nvim_set_hl(0, 'CursorLineSign', { bg = "#000000" })
    vim.api.nvim_set_hl(0, 'CursorLineFold', { bg = "#000000" })
  end
}
