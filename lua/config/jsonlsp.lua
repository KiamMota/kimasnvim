local lspconfig = require('lspconfig')

lspconfig.jsonls.setup{
    settings = {
        json = {
            validate = { enable = true },
            schemas = require('schemastore').json.schemas(),  -- opcional, autocomplete por schemas
        },
    },
}

