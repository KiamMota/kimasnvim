local corrections = {
  -- pré-processador
  include   = {"INcluide", "incldue", "inclide", "Include", "incblduye", "incluyde"},
  define    = {"DEFINE", "deifnde", "deinfe", "dei0fne"},
  endif     = {"endfi", "ednif"},
  ifdef     = {"ifdfe", "iddef"},
  ifndef    = {"ifndfe", "infdef"},

  -- estrutura
  namespace = {"namesapce", "namespce"},
  ["class"] = {"calss", "lcass", "clas"},
  struct    = {"strcut", "sturct"},
  virtual   = {"virutal", "virutla", "virtula", "viutal"},
  public    = {"publci", "pubilc"},
  private   = {"pritave", "privtae"},
  protected = {"protcted", "prtoected"},

  -- tipos
  ["const"] = {"constr", "cosnt"},
  void      = {"voud", "vodi"},
  bool      = {"bol", "boool"},
  size_t    = {"sizet", "size-t"},
  string    = {"stirng", "strign"},

  -- fluxo
  ["return"] = {"retun", "retrn"},
  ["while"]  = {"wilhe", "wihle", "whie"},
  ["switch"] = {"siwtch", "swithc", "esicjh", "sich", "swtich", "stich"},
  ["case"]   = {"caes"},
  default    = {"defualt", "defautl"},
  break      = {"breka", "berak"},
  continue   = {"contiune", "conitnue"},

  -- funções / STL comuns
  function = {"fucntion", "functoin"},
  length   = {"lenght", "lengh"},
  width    = {"witdht", "widht", "witdh"},
  begin    = {"begni"},
  end      = {"edn"},
}

local function in_string()
  local syn = vim.fn.synIDattr(
    vim.fn.synID(vim.fn.line("."), vim.fn.col(".") - 1, 1),
    "name"
  )
  return syn:match("String") ~= nil
end

for correct, wrongs in pairs(corrections) do
  for _, wrong in ipairs(wrongs) do
    vim.cmd(string.format(
      [[iabbrev <expr> %s (in_string() and "%s" or "%s")]],
      wrong, wrong, correct
    ))
  end
end
