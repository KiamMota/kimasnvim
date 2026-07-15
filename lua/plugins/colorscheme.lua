-- lua/plugins/colorscheme.lua

vim.pack.add({
  "https://github.com/bluz71/vim-moonfly-colors"
})

-- Troque o nome para experimentar cada um:
-- 'vscode'       → VS Code dark
-- 'darcula'      → JetBrains Darcula
-- 'kanagawa'     → Kanagawa
-- 'tokyonight'   → Tokyo Night
-- 'catppuccin'   → Catppuccin Mocha

vim.cmd.colorscheme('moonfly')
