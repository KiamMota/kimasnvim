local config = vim.fn.stdpath("config")

-- Themes
for _, file in ipairs(vim.fn.glob(config .. "/lua/plugins/themes/*.lua", false, true)) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    require("plugins.themes." .. name)
end

-- Plugins
for _, file in ipairs(vim.fn.glob(config .. "/lua/plugins/*.lua", false, true)) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    if name ~= "load" then
        require("plugins." .. name)
    end
end
