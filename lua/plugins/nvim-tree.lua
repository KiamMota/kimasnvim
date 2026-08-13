vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-tree.lua",
})

-- ============ NVIM-TREE MINIMALISTA ============
require("nvim-tree").setup({
  update_cwd = true,
  view = {
    side = "left",
    width = 30,
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    api.config.mappings.default_on_attach(bufnr)
    
    local opts = { buffer = bufnr, noremap = true, silent = true }
    
    -- Remove filter defaults
    pcall(vim.keymap.del, 'n', 'f', { buffer = bufnr })
    pcall(vim.keymap.del, 'n', 'F', { buffer = bufnr })
    
    -- <leader>cd = Mudar PWD para pasta selecionada
    vim.keymap.set('n', '<leader>cd', function()
      local node = api.tree.get_node_under_cursor()
      if node and node.absolute_path then
        if vim.fn.isdirectory(node.absolute_path) == 1 then
          vim.cmd('cd ' .. vim.fn.fnameescape(node.absolute_path))
          print('📂 PWD: ' .. node.absolute_path)
        else
          local dir = vim.fn.fnamemodify(node.absolute_path, ':h')
          vim.cmd('cd ' .. vim.fn.fnameescape(dir))
          print('📂 PWD: ' .. dir)
        end
      end
    end, opts)
  end
})

-- ============ ATALHOS GLOBAIS ============
local map = vim.keymap.set

map('n', '<leader>e', function()
  require("nvim-tree.api").tree.toggle()
end, { noremap = true, silent = true, desc = "Toggle NvimTree" })

map('n', '<leader>cd', function()
  local current_dir = vim.fn.expand('%:p:h')
  if vim.bo.buftype == "" and current_dir ~= "" then
    vim.cmd('cd ' .. vim.fn.fnameescape(current_dir))
    print('📂 PWD: ' .. current_dir)
  end
end, { noremap = true, silent = true, desc = 'PWD = arquivo atual' })
