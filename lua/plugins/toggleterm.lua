vim.pack.add({
  "https://github.com/akinsho/toggleterm.nvim"
})

require("toggleterm").setup({
  start_in_insert = true,
  direction = "horizontal", -- Mudado de 'float' para 'horizontal' para ficar embaixo
  close_on_exit = true,
  size = 15,                -- Define a altura fixa do terminal embaixo (em linhas)
  on_open = function(term)
    -- Mantém sua regra para fechar o terminal ao apertar Esc de dentro dele
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "t",
      "<Esc>",
      "<C-\\><C-n>:close<CR>",
      { noremap = true, silent = true }
    )
  end,
})

-- Atalho corrigido para abrir o terminal embaixo com tamanho fixo
vim.keymap.set("n", "<leader>t", function()
  require("toggleterm").toggle(1, 15, nil, "horizontal")
end, { noremap = true, silent = true })
