
-- Habilita suporte a 24-bit RGB color
vim.opt.termguicolors = true

-- Força o carregamento dos pacotes nativos
vim.cmd('packadd! lualine.nvim')
vim.cmd('packadd! nvim-web-devicons')

-- Configuração básica e minimalista do Lualine
require('lualine').setup({
  options = {
    theme = 'auto', -- Adapta automaticamente ao seu colorscheme
    globalstatus = true, -- Barra de status única no rodapé
    component_separators = { left = '│', right = '│' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 1 } }, -- Mostra caminho relativo do arquivo
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  }
})
