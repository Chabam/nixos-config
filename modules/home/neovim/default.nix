{ inputs, ... }:

{

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./config/autoformat.nix
    ./config/colorscheme.nix
    ./config/fzf.nix
    ./config/gitsigns.nix
    ./config/lsp.nix
    ./config/oil.nix
    ./config/treesitter.nix
    ./config/which-key.nix
  ];

  programs.nixvim = {
    enable = true;
    # performance.byteCompileLua = {
    #   enable = true;
    #   configs = true;
    #   init = true;
    # };

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
      sleuth.enable = true;
      sandwich.enable = true;
      quicker.enable = true;
      todo-comments.enable = true;
      rainbow-delimiters.enable = true;
      indent-blankline.enable = true;
      web-devicons.enable = true;
      nvim-autopairs.enable = true;

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
    '';
  };
}
