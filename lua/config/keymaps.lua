local function map(mode, key, action, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, key, action, opts)
end

-- Movimentação rápida dentro da linha
map("n", "<Tab>", "$la")

-- Rename do LSP
map("n", "<leader>rn", vim.lsp.buf.rename)

-- Duplicar linha
map("n", "<C-d>", function() vim.cmd("t-1") end)

-- x vira V no normal (atenção: altera comportamento padrão)
map("n", "x", "V", { silent = false })

-- Navegação entre janelas usando loops
local nav_keys = {
  ["<A-Right>"] = "l",
  ["<A-Left>"] = "h",
  ["<S-Up>"] = "k",
  ["<S-Down>"] = "j",
}
for k, v in pairs(nav_keys) do
  map("n", k, function() vim.cmd("wincmd " .. v) end)
end

-- Trocar buffer
map("n", "<S-Tab>", ":bnext<CR>")

-- Mover linha verticalmente (Alt+Up/Down)
local move_keys = { ["<A-Up>"] = ".-2", ["<A-Down>"] = ".+1" }
for k, v in pairs(move_keys) do
  map("", k, function() vim.cmd("m " .. v) end)
end
