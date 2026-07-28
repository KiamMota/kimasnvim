vim.g.mapleader      = ' '
vim.filetype.add({
  extension = {
    h = "c",
  }
})
vim.opt.termguicolors = true
vim.g.maplocalleader = '\\'
vim.api.nvim_create_user_command("Edit", function()
  local config_path = vim.fn.stdpath("config")
  vim.cmd("cd " .. config_path)
end, {})
require("plugins.load") -- PRIMEIRO: instala e carrega tudo
require("editor")       -- configurações gerais do editor
require("keymaps")      -- keymaps que podem depender de plugins
require("lsp")          -- lsp que depende de mason/lspconfig
require('abbrev')
-- Salva o diretório atual em um arquivo
local session_file = vim.fn.stdpath('data') .. '/simple_session.vim'

-- Salva tudo
vim.keymap.set('n', '<leader>ms', function()
  vim.cmd('mksession! ' .. session_file)
  print('✅ Tudo salvo!')
end, { desc = 'Save everything' })

-- Carrega tudo
vim.keymap.set('n', '<leader>ml', function()
  vim.cmd('source ' .. session_file)
  print('✅ Tudo restaurado!')
end, { desc = 'Load everything' })
