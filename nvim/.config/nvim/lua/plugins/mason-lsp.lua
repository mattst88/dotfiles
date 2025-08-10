return {
  {
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    lazy = false,
    dependencies = {
      { "williamboman/mason-lspconfig.nvim", name = "mason-lspconfig" },
      { "williamboman/mason.nvim",           name = "mason" },
    },
    config = function()
      local lspconfig       = require("lspconfig")
      local mason           = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities    = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local servers         = { "lua_ls", "marksman", "pylsp" }
--      local options         = { noremap = true, silent = true }

      mason.setup({})

      mason_lspconfig.setup({ ensure_installed = servers })

      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup {
            settings = {
              Lua = {
                runtime = { version = 'LuaJIT', },
                diagnostics = {
                  globals = {
                    'vim',
                    'require',
                  },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                telemetry = { enable = false },
              },
            },
          }
        end,
        ["pylsp"] = function()
          lspconfig.pylsp.setup {
            settings = {
              pylsp = {
                plugins = {
                  pycodestyle = {
                    ignore = {'W391'},
                    maxLineLength = 100,
                  }
                },
              },
            },
          }
        end
      })
    end
  },
}
