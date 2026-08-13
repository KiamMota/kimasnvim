-- lua/plugins/lualine.lua

vim.pack.add({
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
})
-- lua/plugins/lualine.lua
vim.pack.add({
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
})

local function buffer_directory()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == '' then
    return ''
  end
  return vim.fn.fnamemodify(bufname, ':h')
end

require('lualine').setup({
  options = {
    icons_enabled        = true,
    theme                = 'auto',
    component_separators = { left = '', right = '' },
    section_separators   = { left = '', right = '' },
    always_divide_middle = false,
    always_show_tabline  = false,
    globalstatus         = false,
    refresh              = {
      statusline   = 1000,
      tabline      = 1000,
      winbar       = 1000,
      refresh_time = 16,
      events       = {
        'WinEnter', 'BufEnter', 'BufWritePost',
        'SessionLoadPost', 'FileChangedShellPost',
        'VimResized', 'Filetype',
        'CursorMoved', 'CursorMovedI', 'ModeChanged',
      },
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'diagnostics', 'filename' },
    lualine_c = { 'branch', 'diff' },
    lualine_y = { 'filetype', buffer_directory, 'progress' },
    lualine_z = { 'location' },
  },
})
