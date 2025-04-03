{ ... }:

{
  programs.nixvim = {

    plugins = {
      fidget = {
        enable = true;
        settings = {
          notification = {
            window = {
              winblend = 0;
            };
          };
        };
      };

      lsp = {
        enable = true;

        inlayHints = true;

        servers = {
          clangd.enable = true;
          ltex.enable = true;
          pyright.enable = true;
          neocmake.enable = true;
          lua_ls.enable = true;
          nixd.enable = true;
          racket_langserver = {
            enable = true;
            package = null;
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "gd";
        action.__raw = ''
          function()
            require("fzf-lua").lsp_definitions({ jump1 = true })
          end
        '';
        options = {
          desc = "[G]oto [D]efinition";
        };
      }
      {
        mode = "n";
        key = "gr";
        action.__raw = ''
          function()
            require("fzf-lua").lsp_references({ jump1 = true })
          end
        '';
        options = {
          desc = "[G]oto [R]eferences";
        };
      }
      {
        mode = "n";
        key = "gI";
        action.__raw = ''
          function()
            require("fzf-lua").lsp_implementations({ jump1 = true })
          end
        '';
        options = {
          desc = "[G]oto [I]mplementation";
        };
      }
      {
        mode = "n";
        key = "<leader>D";
        action.__raw = ''
          function()
            require("fzf-lua").lsp_typedefs({ jump1 = true })
          end
        '';
        options = {
          desc = "Type [D]efinition";
        };
      }
      {
        mode = "n";
        key = "<leader>ds";
        action.__raw = "require('fzf-lua').lsp_document_symbols";
        options = {
          desc = "[D]ocument [S]ymbols";
        };
      }
      {
        mode = "n";
        key = "<leader>ws";
        action.__raw = "require('fzf-lua').lsp_workspace_symbols";
        options = {
          desc = "[W]orkspace [S]ymbols";
        };
      }
      {
        mode = "n";
        key = "<leader>rn";
        action.__raw = "vim.lsp.buf.rename";
        options = {
          desc = "[R]e[n]ame";
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>ca";
        action.__raw = "require('fzf-lua').lsp_code_actions";
        options = {
          desc = "[C]ode [A]ction";
        };
      }
      {
        mode = "n";
        key = "gD";
        action.__raw = "vim.lsp.buf.declaration";
        options = {
          desc = "[G]oto [D]eclaration";
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "gH";
        action = "<CMD>ClangdSwitchSourceHeader<CR>";
        options = {
          desc = "[G]oto [H]eader";
        };
      }
      {
        key = "<leader>th";
        action.__raw = ''
          function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end
        '';
        options = {
          desc = "[T]oggle Inlay [H]ints";
        };
      }
      {
        key = "<leader>q";
        action = "vim.lsp.setloclist";
        options = {
          desc = "Open diagnostic [Q]uickfix list";
        };
      }
    ];
  };
}
