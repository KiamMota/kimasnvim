vim.pack.add({
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
})

-- ============================================================
-- NOVO ESTILO 1: BUBBLES / PILL STYLE (O Queridinho do Reddit)
-- Cria blocos arredondados e separados, dando aspecto de TUI moderna.
-- ============================================================
local function setup_bubbles()
  -- Paleta de cores customizada para o efeito flutuante
  local colors = {
    blue   = '#80a0ff',
    cyan   = '#79dac8',
    black  = '#080808',
    white  = '#c6c6c6',
    red    = '#ff5189',
    violet = '#d183e8',
    grey   = '#303030',
  }

  local bubbles_theme = {
    normal = {
      a = { fg = colors.black, bg = colors.violet, gui = 'bold' },
      b = { fg = colors.white, bg = colors.grey },
      c = { fg = colors.white },
    },
    insert = { a = { fg = colors.black, bg = colors.blue, gui = 'bold' } },
    visual = { a = { fg = colors.black, bg = colors.cyan, gui = 'bold' } },
    replace = { a = { fg = colors.black, bg = colors.red, gui = 'bold' } },
    inactive = {
      c = { fg = colors.white },
    },
  }

  require('lualine').setup({
    options = {
      theme = bubbles_theme,
      component_separators = '',
      section_separators = { left = '', right = '' }, -- Cria o formato arredondado
      globalstatus = true,
    },
    sections = {
      lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
      lualine_b = { 'filename', 'branch', 'diff' },
      lualine_c = { '%=', 'diagnostics' }, -- Centraliza os diagnósticos
      lualine_x = { 'encoding', 'fileformat' },
      lualine_y = { 'filetype', 'progress' },
      lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
  })
end


-- ============================================================
-- NOVO ESTILO 2: EVIL LUALINE MODIFICADO (Elegante e Transparente)
-- Uma barra minimalista sem blocos de cores sólidas, focada em texto puro.
-- ===========================================================
setup_bubbles()
