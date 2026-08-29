
-- Adiciona e carrega o dropbar.nvim usando vim.pack
vim.pack.add({
  { src = 'https://github.com/Bekaboo/dropbar.nvim' }
})

-- Configuração padrão do plugin
require('dropbar').setup({})
