local function header_guard()
  local buf = vim.api.nvim_get_current_buf()
  local name = vim.fn.expand("%:t")
  if name == "" then return end

  local ext = name:match("%.([^.]+)$")
  if ext ~= "h" and ext ~= "hpp" then return end

  local guard = name
    :upper()
    :gsub("%.", "_")
    :gsub("[^A-Z0-9_]", "_")

  local lines = {
    "#ifndef " .. guard,
    "#define " .. guard,
    "",
    "",
    "#endif // " .. guard,
  }

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_win_set_cursor(0, {4, 0})
end

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = { "*.h", "*.hpp" },
  callback = header_guard,
})
