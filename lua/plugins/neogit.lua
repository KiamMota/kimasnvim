-- Neogit configuration using vim.pack.add

-- Add Neogit and its dependencies
vim.pack.add({ 'https://github.com/NeogitOrg/neogit.git' })
vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim.git' })
vim.pack.add({ 'https://github.com/sindrets/diffview.nvim.git' })

-- Neogit setup
require('neogit').setup({
  kind = 'tab',
  disable_line_numbers = false,
  disable_relative_line_numbers = false,
  disable_signs = false,
  disable_hint = false,
  disable_context_highlighting = false,
  disable_commit_confirmation = false,
  auto_refresh = true,
  auto_show_console = false,
  status = {
    recent_commit_count = 10,
  },
  commit_editor = {
    kind = 'auto',
  },
  commit_select_view = {
    kind = 'auto',
  },
  commit_view = {
    kind = 'auto',
  },
  log_view = {
    kind = 'auto',
  },
  rebase_editor = {
    kind = 'auto',
  },
  reflog_view = {
    kind = 'auto',
  },
  merge_editor = {
    kind = 'auto',
  },
  preview_buffer = {
    kind = 'auto',
  },
  popup = {
    kind = 'auto',
  },
  signs = {
    hunk = { '', '' },
    item = { '▶', '▼' },
    section = { '▶', '▼' },
  },
  integrations = {
    diffview = true,
  },
  sections = {
    untracked = {
      folded = false,
    },
    unstaged = {
      folded = false,
    },
    staged = {
      folded = false,
    },
    stashes = {
      folded = true,
    },
    branches = {
      folded = true,
      hidden = true,
    },
  },
  use_magit_keybindings = false,
  remember_settings = true,
  filewatcher = {
    interval = 1000,
    ignore_dirs = {},
  },
})

-- Keybindings
local neogit = require('neogit')

vim.keymap.set('n', '<leader>gs', function() neogit.open({ kind = 'tab' }) end, { noremap = true, silent = true, desc = 'Neogit Status' })
vim.keymap.set('n', '<leader>gc', function() neogit.open({ 'commit' }) end, { noremap = true, silent = true, desc = 'Neogit Commit' })
vim.keymap.set('n', '<leader>gp', function() neogit.open({ 'pull' }) end, { noremap = true, silent = true, desc = 'Neogit Pull' })
vim.keymap.set('n', '<leader>gP', function() neogit.open({ 'push' }) end, { noremap = true, silent = true, desc = 'Neogit Push' })
vim.keymap.set('n', '<leader>gl', function() neogit.open({ 'log' }) end, { noremap = true, silent = true, desc = 'Neogit Log' })
vim.keymap.set('n', '<leader>gb', function() neogit.open({ 'branch' }) end, { noremap = true, silent = true, desc = 'Neogit Branch' })
