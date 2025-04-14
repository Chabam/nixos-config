{ pkgs }:
with pkgs.vimPlugins;
# Lua
''
  {
    dir = "${nvim-lspconfig}",
    config = function()
      local lspconfig = require("lspconfig")

      local servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "--header-insertion=never",
          },
        },
        ltex_plus = {
          settings = {
            ltex = {
              language = "auto",
              completionEnabled = true,
            },
          },
        },
        pyright = {},
        cmake = {},
        nil_ls = {},
        racket_langserver = {},
      }
      local blink_cmp = require("blink-cmp")
      for server_name, server_config in pairs(servers) do
        server_config.capabilities = blink_cmp.get_lsp_capabilities(server_config.capabilities)
        server_config.capabilities.textDocument.completion.completionItem.snippetSupport = false

        local server = require("lspconfig")[server_name]
        server.setup(server_config)
      end
    end
  }
''
