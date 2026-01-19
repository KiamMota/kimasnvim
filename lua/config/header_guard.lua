local function header_guard()
  local buf = vim.api.nvim_get_current_buf()
  local name = vim.fn.expand("%:t")
  if name == "" then
    return
  end

  local ext = name:match("%.([^.]+)$")
  if ext ~= "h" and ext ~= "hpp" then
    return
  end

  -- só aplica se buffer estiver praticamente vazio
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  if #lines > 1 or (lines[1] and lines[1] ~= "") then
    return
  end

  local guard = name:upper():gsub("%.", "_"):gsub("[^A-Z0-9_]", "_")

  local insert = {
    "#ifndef " .. guard,
    "#define " .. guard,
    "",
    "",
    "#endif // " .. guard,
  }

  -- adia execução para evitar conflitos com plugins
  vim.schedule(function()
    if vim.api.nvim_buf_get_option(buf, "buftype") ~= "" then
      -- buffer especial, ignora
      return
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, insert)
    vim.api.nvim_win_set_cursor(0, { 4, 0 })
    vim.notify("header_guard inserted for " .. name, vim.log.levels.INFO)
  end)
end

-- registrar apenas BufNewFile e BufReadPost para buffers normais
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = { "*.h", "*.hpp" },
  callback = header_guard,
})
