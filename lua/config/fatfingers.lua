-- Auto-correção inteligente para C++ no Neovim
-- Corrige erros de digitação comuns mantendo strings intactas

local M = {}

-- Dicionário de correções: correto -> variantes incorretas
local corrections = {
  -- Pré-processador
  include = { "INcluide", "incldue", "inclide", "Include", "incblduye", "incluyde" },
  define = { "DEFINE", "deifnde", "deinfe", "dei0fne" },
  endif = { "endfi", "ednif" },
  ifdef = { "ifdfe", "iddef" },
  ifndef = { "ifndfe", "infdef" },
  undef = { "undfe", "udnef" },

  -- Estrutura
  namespace = { "namesapce", "namespce", "nmespace" },
  class = { "calss", "lcass", "clas", "classs" },
  struct = { "strcut", "sturct", "strcuct" },
  virtual = { "virutal", "virutla", "virtula", "viutal" },
  public = { "publci", "pubilc", "pubic" },
  private = { "pritave", "privtae", "pivate" },
  protected = { "protcted", "prtoected", "proected" },
  explicit = { "expilcit", "explict" },

  -- Tipos
  const = { "constr", "cosnt", "cnst" },
  void = { "voud", "vodi", "viod" },
  bool = { "bol", "boool", "bolo" },
  size_t = { "sizet", "size-t", "sizze_t" },
  string = { "stirng", "strign", "srting" },
  nullptr = { "nullprt", "nullptr_t" },

  -- Tipos primitivos
  int = { "itn", "intt" },
  char = { "caher", "chr" },
  float = { "flota", "floatt" },
  double = { "dobule", "duoble" },
  unsigned = { "unsigend", "unsined" },

  -- Fluxo de controle
  ["return"] = { "retun", "retrn", "retunr", "reutrn" },
  ["while"] = { "wilhe", "wihle", "whie", "whiel" },
  ["for"] = { "fro" },
  ["if"] = { "fi" },
  ["else"] = { "esle", "esle" },
  switch = { "siwtch", "swithc", "esicjh", "sich", "swtich", "stich" },
  case = { "caes", "csae" },
  default = { "defualt", "defautl", "deafult" },
  ["break"] = { "breka", "berak", "braek" },
  continue = { "contiune", "conitnue", "contineu" },

  -- Funções/métodos STL comuns
  ["function"] = { "fucntion", "functoin", "funciton" },
  length = { "lenght", "lengh", "legth" },
  width = { "witdht", "widht", "witdh" },
  height = { "heigth", "heihgt" },
  begin = { "begni", "biegn" },
  ["end"] = { "edn", "ned" },
  size = { "siez", "szie" },
  empty = { "emtpy", "empyt" },
  push_back = { "pushback", "push-back" },
  pop_back = { "popback", "pop-back" },

  -- Palavras-chave adicionais
  template = { "templte", "tempalte" },
  typename = { "typname", "tyepname" },
  operator = { "opertor", "opeartor" },
  friend = { "firend", "freind" },
  static = { "staitc", "statci" },
  extern = { "extenr", "exterrn" },
  inline = { "inlnie", "inilne" },
}

-- Verifica se o cursor está dentro de uma string ou comentário
local function in_string_or_comment()
  local synID = vim.fn.synID(vim.fn.line("."), vim.fn.col(".") - 1, 1)
  local synName = vim.fn.synIDattr(synID, "name")

  return synName:match("String") ~= nil or synName:match("Comment") ~= nil or synName:match("Character") ~= nil
end

-- Valida se a palavra pode ser usada como abreviação no Vim
local function is_valid_abbrev(word)
  -- Apenas palavras que começam com letra ou underscore
  -- e contêm apenas letras, números, underscores
  return word:match("^[%a_][%w_]*$") ~= nil
end

-- Configura uma abreviação inteligente
local function setup_abbrev(wrong, correct)
  if not is_valid_abbrev(wrong) then
    vim.notify(string.format("Ignorada abreviação inválida: '%s'", wrong), vim.log.levels.WARN)
    return false
  end

  -- Cria abreviação que respeita contexto
  vim.cmd(
    string.format(
      [[iabbrev <expr> %s luaeval('require("cpp_autocorrect").should_correct()') ? "%s" : "%s"]],
      wrong,
      correct,
      wrong
    )
  )

  return true
end

-- Decide se deve corrigir com base no contexto
function M.should_correct()
  return not in_string_or_comment()
end

-- Configura todas as correções
function M.setup(opts)
  opts = opts or {}

  -- Permite ao usuário adicionar correções customizadas
  local custom_corrections = opts.corrections or {}
  for correct, wrongs in pairs(custom_corrections) do
    corrections[correct] = wrongs
  end

  -- Habilitar apenas para buffers C/C++
  local filetypes = opts.filetypes or { "c", "cpp", "h", "hpp", "cc", "cxx" }

  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    callback = function()
      local count_success = 0
      local count_fail = 0

      -- Configura todas as abreviações
      for correct, wrongs in pairs(corrections) do
        for _, wrong in ipairs(wrongs) do
          if setup_abbrev(wrong, correct) then
            count_success = count_success + 1
          else
            count_fail = count_fail + 1
          end
        end
      end

      if opts.verbose then
        vim.notify(
          string.format("Auto-correção C++: %d abreviações configuradas (%d ignoradas)", count_success, count_fail),
          vim.log.levels.INFO
        )
      end
    end,
  })
end

-- Limpa todas as abreviações
function M.clear()
  for correct, wrongs in pairs(corrections) do
    for _, wrong in ipairs(wrongs) do
      if is_valid_abbrev(wrong) then
        vim.cmd(string.format("iunabbrev %s", wrong))
      end
    end
  end
end

-- Lista todas as correções disponíveis
function M.list_corrections()
  local items = {}
  for correct, wrongs in pairs(corrections) do
    table.insert(items, string.format("%s <- %s", correct, table.concat(wrongs, ", ")))
  end
  table.sort(items)

  vim.notify("Correções disponíveis:\n" .. table.concat(items, "\n"), vim.log.levels.INFO)
end

return M
