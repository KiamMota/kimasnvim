-- ============ NVIM-TREE ============
require("nvim-tree").setup({
  update_cwd = true,
  filesystem = {
    hijack_cursor = true, -- Mantém o cursor fixo em arquivos válidos
  },
  view = {
    side = "left",
    width = 30,
    float = {
      enable = false,
    },
  },
  
  -- BLOCO DE ANULAÇÃO E MAPEAMENTO DENTRO DO BUFFER DA ÁRVORE:
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    
    -- 1. Carrega todos os comandos e atalhos padrão do nvim-tree
    api.config.mappings.default_on_attach(bufnr)
    
    -- 2. BLOQUEIA O FILTER: Remove o comportamento padrão da tecla 'f' isolada
    vim.keymap.del('n', 'f', { buffer = bufnr })
    vim.keymap.del('n', 'F', { buffer = bufnr })
    
    -- 3. Injeta seus atalhos do Telescope dentro deste buffer para não haver conflito
    local opts = { buffer = bufnr, noremap = true, silent = true }
    
    vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
    vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', opts)
    vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
    
    -- Injeta a nossa busca estável via vimgrep nativo (sem depender de ripgrep)
    vim.keymap.set('n', '<leader>fg', function()
      local search = vim.fn.input("Grep para: ")
      if search ~= "" then
        pcall(vim.cmd, "vimgrep /" .. search .. "/g **/*")
        require('telescope.builtin').quickfix()
      end
    end, opts)
  end
})

-- ============ ATALHOS GLOBAIS (Para o resto do editor) ============
-- Mantenha seus mapeamentos normais aqui embaixo para quando estiver editando códigos:
local map = vim.keymap.set
map('n', '<leader>e',  function() require("nvim-tree.api").tree.toggle() end, { noremap = true, silent = true })
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>',           { desc = 'Find files' })
map('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>',             { desc = 'Recent files' })
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>',              { desc = 'Buffers' })
