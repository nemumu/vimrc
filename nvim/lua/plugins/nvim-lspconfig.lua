return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "VeryLazy",
    priority = 600,
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
      { "williamboman/mason.nvim" },
    },
    config = function()
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = { "ansiblels", "ast_grep", "bashls", "dockerls", "html", "intelephense", "jsonls", "markdown_oxide", "pyright", "ruff", "volar", "yamlls" },
      })
      
      local lspconfig = require("lspconfig")
      lspconfig.ansiblels.setup {}
      lspconfig.ast_grep.setup {}
      lspconfig.bashls.setup {}
      lspconfig.dockerls.setup {}
      lspconfig.html.setup {}
      lspconfig.intelephense.setup {}
      lspconfig.jsonls.setup {}
      lspconfig.markdown_oxide.setup {}
      lspconfig.pyright.setup {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true
            }
          }
        }
      }
      lspconfig.ruff.setup {}
      lspconfig.volar.setup {
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        init_options = {
          hybridMode = false,
        },
      }
      lspconfig.yamlls.setup {}
    end,
  }
}
