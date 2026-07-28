vim.pack.add({
  "https://github.com/sphamba/smear-cursor.nvim",
})
require('smear_cursor').setup({
  stiffness = 0.8,           -- Mais rígido = mais dramático
  trailing_tail = true,      -- Cauda arrastando
  cursor_color = "#00ff00",  -- Verde neon
  smear_between_buffers = true,
  use_default_keymaps = true,
  max_slope_horizontal = 3,
  max_slope_vertical = 3,
})
