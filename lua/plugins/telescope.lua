vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
})

local actions = require('telescope.actions')
require('telescope').setup({
  defaults = {
    -- CONFIGURAÇÃO PARA USAR O GREP PADRÃO (SEM RIPGREP)
    vimgrep_arguments = {
      "grep",
      "--extended-regexp",
      "--color=never",
      "--with-filename",
      "--line-number",
      "-b",
      "--ignore-case",
      "--recursive",
      "--no-messages",
      "--exclude-dir=.git",
      "--exclude-dir=node_modules",
      "--binary-files=without-match"
    },
    layout_strategy = 'flex',
    layout_config = {
      width  = 0.9,
      height = 0.9,
      flex = {
        flip_columns = 120,
      },
      horizontal = {
        preview_width  = 0.55,
        preview_cutoff = 120,
      },
      vertical = {
        preview_height = 0.5,
        preview_cutoff = 40,
        mirror         = false,
      },
    },
    sorting_strategy = 'ascending',
    path_display     = { 'truncate' },
    file_ignore_patterns = {
      'node_modules', '.git/', 'dist/', 'build/',
      '%.lock', '%.min%.js',
    },
    mappings = {
      i = {
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
        ['<Esc>'] = actions.close,
        ['<C-u>'] = false,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      sort_mru              = true,
      ignore_current_buffer = true,
      mappings = {
        i = { ['<C-d>'] = actions.delete_buffer },
      },
    },
  },
})

local map = vim.keymap.set
map('n', '<leader>ff',       '<cmd>Telescope find_files<cr>',           { desc = 'Find files' })
map('n', '<leader>fr',       '<cmd>Telescope oldfiles<cr>',             { desc = 'Recent files' })
map('n', '<leader>fb',       '<cmd>Telescope buffers<cr>',              { desc = 'Buffers' })
map('n', '<leader>fh',       '<cmd>Telescope help_tags<cr>',            { desc = 'Help tags' })
map('n', '<leader>gcs',       '<cmd>Telescope git_commits<cr>',          { desc = 'Git commits' })
map('n', '<leader>gs',       '<cmd>Telescope git_status<cr>',           { desc = 'Git status' })
map('n', '<leader>fd',       '<cmd>Telescope diagnostics<cr>',          { desc = 'Diagnostics' })
map('n', '<leader>fs',       '<cmd>Telescope lsp_document_symbols<cr>', { desc = 'Document symbols' })
map('n', '<leader>fk',       '<cmd>Telescope keymaps<cr>',              { desc = 'Keymaps' })
map('n', '<leader><leader>', '<cmd>Telescope resume<cr>',               { desc = 'Resume last picker' })

-- NOVOS ATALHOS PARA BUSCA SEM RIPGREP:


map('n', '<leader>fg', function()
  local search = vim.fn.input("Grep para: ")
  if search ~= "" then
    -- Executa o vimgrep nativo do Neovim no projeto atual
    -- (O pcall evita mensagens de erro feias caso nada seja encontrado)
    pcall(vim.cmd, "vimgrep /" .. search .. "/g **/*")
    -- Envia a lista encontrada direto para o painel de resultados do Telescope
    require('telescope.builtin').quickfix()
  end
end, { desc = 'Grep por digitação (vimgrep nativo)' })

-- 2. Substituição para o <leader>fw (Grep da palavra sob o cursor)
map('n', '<leader>fw', function()
  local word = vim.fn.expand("<cword>")
  if word ~= "" then
    pcall(vim.cmd, "vimgrep /" .. word .. "/g **/*")
    require('telescope.builtin').quickfix()
  end
end, { desc = 'Buscar palavra sob o cursor (vimgrep nativo)' })
