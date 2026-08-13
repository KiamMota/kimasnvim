local M = {}

-- Variável para guardar o PWD do primeiro arquivo aberto
local first_pwd = nil

-- Função interna para gerar o caminho do arquivo de sessão
local function get_session_file()
  -- Usa o PWD guardado ou o atual caso ainda não exista
  local target_dir = first_pwd or vim.fn.getcwd()
  local cwd = target_dir:gsub("[/\\]", "%%")
  return vim.fn.stdpath("data") .. "/session_" .. cwd .. ".vim"
end

-- Função para salvar a sessão atual
function M.save_session()
  local session_file = get_session_file()
  vim.cmd('mksession! ' .. vim.fn.fnameescape(session_file))
end

-- Função para carregar a sessão
function M.load_session()
  local session_file = get_session_file()
  if vim.fn.filereadable(session_file) == 1 then
    vim.cmd('source ' .. vim.fn.fnameescape(session_file))
  end
end

-- Inicializa as configurações e automações
function M.setup()
  local group = vim.api.nvim_create_augroup("AutoSessionManagement", { clear = true })

  -- 1. Captura o PWD do primeiro arquivo/buffer válido aberto
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = group,
    once = true, -- Executa apenas uma vez por inicialização
    callback = function()
      -- Garante que não é um buffer especial (como NvimTree ou prompt)
      if vim.bo.buftype == "" then
        first_pwd = vim.fn.getcwd()
      end
    end,
  })

  -- 2. Carrega a sessão automaticamente ao abrir o Neovim
  vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    nested = true, -- Permite que outros plugins carreguem corretamente junto
    callback = function()
      -- Só carrega se o Neovim foi aberto sem argumentos (ex: apenas `nvim`)
      if vim.fn.argc() == 0 then
        M.load_session()
      end
    end,
  })

  -- 3. Salva a sessão automaticamente antes de fechar o Neovim
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = function()
      M.save_session()
    end,
  })
end


return M
