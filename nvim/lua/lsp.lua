require'lspconfig'.pyright.setup{}

-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
--lspconfig.yamllint.setup {}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
lspconfig.html.setup { capabilities = capabilities }
lspconfig.cssls.setup { capabilities = capabilities }
lspconfig.jsonls.setup {}
lspconfig.eslint.setup {}
lspconfig.ansiblels.setup {}
lspconfig.bashls.setup {}

lspconfig.pylsp.setup{
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        },
        black = {
          enabled = true,
          line_length = 100
        },
        isort = {
          enabled = true
        },
        flake8 = { enabled = true },
        autopep8 = { enabled = false },
        mccabe = {enabled = false},
        pyflakes = {enabled = false}
      }
    }
  }
}
