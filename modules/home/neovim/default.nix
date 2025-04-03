{ inputs, ... }:

{

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./autocomplete.nix
    ./autoformat.nix
    ./colorscheme.nix
    ./fzf.nix
    ./gitsigns.nix
    ./lsp.nix
    ./lualine.nix
    ./oil.nix
    ./snippets.nix
    ./treesitter.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    enable = true;

    performance = {
      byteCompileLua = {
        enable = true;
        plugins = true;
        nvimRuntime = true;
        initLua = true;
        configs = true;
      };
    };

    globals = {
      mapleader = " ";
    };

    opts = {
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;
      expandtab = true;
      number = true;
      relativenumber = true;
      mouse = "a";
      showmode = false;
      cursorline = true;
      clipboard = "unnamedplus";
      breakindent = true;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      signcolumn = "yes";
      updatetime = 1000;
      splitright = true;
      splitbelow = true;
      list = false;
      listchars = {
        tab = "» ";
        trail = "·";
        space = "·";
        nbsp = "␣";
      };
      inccommand = "split";
      scrolloff = 10;
    };

    autoGroups = {
      highlight-yank = {
        clear = true;
      };
    };

    autoCmd = [
      # Clear whitespace on the end of lines
      {
        event = [ "BufWritePre" ];
        pattern = "*";
        command = "%s/\\s\\+$//e";
      }
      # Show diagnostic
      {
        event = [ "CursorHold" ];
        callback = {
          __raw = ''
            function()
              local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                source = "always",
                prefix = " ",
                scope = "cursor",
              }
              vim.diagnostic.open_float(nil, opts)
            end
          '';
        };
      }

      # Highlight on yank
      {
        event = [ "TextYankPost" ];
        group = "highlight-yank";
        callback = {
          __raw = ''
            function()
              vim.highlight.on_yank()
            end
          '';
        };
      }
    ];

    diagnostics = {
      virtual_text = true;
      signs = true;
    };

    keymaps = [
      {
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
        mode = [ "n" ];
      }
    ];

    plugins = {
      # WARNING: experimental
      lz-n.enable = true;
      sleuth.enable = true;
      sandwich.enable = true;
      quicker.enable = true;
      todo-comments.enable = true;
      rainbow-delimiters.enable = true;
      indent-blankline.enable = true;
      web-devicons.enable = true;
      nvim-autopairs.enable = true;
      vimtex.enable = true;

      diffview = {
        enable = true;
        extraOptions = {
          view = {
            merge_tool = {
              layout = "diff3_mixed";
            };
          };
        };
      };
    };

    extraConfigLuaPost = ''
      require('nvim-autopairs').get_rules("'")[1].not_filetypes = { "scheme", "lisp", "racket" }

      require('fzf-lua').register_ui_select()

      require("luasnip.loaders.from_vscode").lazy_load()

      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        out_dir = "ignore",
        aux_dir = "ignore",
      }
      vim.g.vimtex_log_ignore = {
        "Underfull",
        "Overfull",
      }

      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    '';
  };
}
