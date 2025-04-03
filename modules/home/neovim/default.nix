{ pkgs, inputs, lib, ...}:

{

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    # performance.byteCompileLua = {
    #   enable = true;
    #   configs = true;
    #   init = true;
    # };
    colorschemes.nightfox = {
      enable = true;
      flavor = "carbonfox";
      settings = {
        options = {
            terminal_colors = false;
            inverse = {
                match_paren = true;
            };
        };
        palettes = {
            dawnfox = {
                bg1 = "#ffffff";
            };
            carbonfox = {
                bg1 = "#1e1e1e";
            };
        };
        groups = {
            carbonfox = {
                Visual = { bg = "#2C394E"; };
                CurSearch = { bg = "#5F84C4"; };
            };
            dawnfox = {
                Visual = { bg = "#DDEAFF"; };
                CurSearch = { bg = "#9ABFFF"; };
            };
            all = {
                Search = { link = "Visual"; };
                IncSearch = { link = "CurSearch"; };

                Substitute = { link = "Visual"; };
                FloatBorder = { fg = "palette.bg0"; bg = "palette.bg0"; };

                Pmenu = { fg = "palette.comment"; bg = "palette.bg2"; };
                PmenuSel = { bg = "palette.bg3"; style = "bold"; };
                PmenuSbar = { bg = "palette.sel1"; };
                PmenuThumb = { bg = "palette.fg3"; };

                FzfLuaNormal = { fg = "palette.fg1"; bg = "palette.bg0"; };
                FzfLuaPreviewNormal = { fg = "palette.fg1"; bg = "palette.bg0"; };
                FzfLuaDirPart = { fg = "palette.magenta"; };
                FzfLuaFilePart = { fg = "palette.fg1"; };
                FzfLuaLivePrompt = { fg = "palette.fg1"; bg = "palette.bg0"; };
                FzfLuaBorder = { fg = "palette.bg0"; bg = "palette.bg0"; };
                FzfLuaTitle = { fg = "palette.bg0"; bg = "palette.green.bright"; };
                FzfLuaPreviewTitle = { fg = "palette.bg0"; bg = "palette.pink"; };
                FzfLuaCursor = { fg = "palette.fg1"; bg = "palette.bg0"; };
                FzfLuaCursorLineNr = { fg = "palette.red"; bg = "palette.bg0"; };
                FzfLuaCursorLine = { bg = "palette.bg1"; };
                FzfLuaScrollBorderEmpty = { bg = "palette.bg1"; };
                FzfLuaScrollBorderFull = { bg = "palette.bg2"; };
                FzfLuaBufNr = { fg = "palette.green"; };
                FzfLuaBufLineNr = { fg = "palette.blue"; };
                FzfLuaBufFlagCur = { fg = "palette.pink"; };

                FzfLuaFzfMatch = { fg = "palette.fg1"; bg = "palette.bg0"; };
                FzfLuaFzfHeader = { fg = "palette.fg1"; bg = "palette.bg0"; };
                FzfLuaFzfGutter = { bg = "palette.bg0"; };
                FzfLuaFzfNormal = { fg = "palette.fg1"; };
                FzfLuaFzfQuery = { fg = "palette.fg1"; };
                FzfLuaFzfMarker = { fg = "palette.pink"; };
                FzfLuaFzfPrompt = { fg = "palette.pink"; };
                FzfLuaHeaderBind = { fg = "palette.blue"; };

                BlinkCmpDoc = { fg = "palette.fg1"; bg = "palette.bg0"; };
                BlinkDocBorder = { fg = "palette.bg2"; bg = "palette.bg0"; };
                BlinkCmpAbbr = { fg = "palette.comment"; };
                BlinkCmpAbbrDeprecated = { fg = "syntax.dep"; style = "strikethrough"; };
                BlinkCmpAbbrMatch = { fg = "palette.fg1"; };
                BlinkCmpAbbrMatchFuzzy = { fg = "palette.fg1"; };

                BlinkCmpKind = { link = "CmpItemKindFunction"; };
                BlinkCmpKindDefault = { fg = "palette.fg2"; };

                BlinkCmpKindKeyword = { fg = "palette.fg1"; };

                BlinkCmpKindVariable = { fg = "syntax.variable"; };
                BlinkCmpKindConstant = { fg = "syntax.const"; };
                BlinkCmpKindReference = { fg = "syntax.keyword"; };
                BlinkCmpKindValue = { fg = "syntax.keyword"; };

                BlinkCmpKindFunction = { fg = "syntax.func"; };
                BlinkCmpKindMethod = { fg = "syntax.func"; };
                BlinkCmpKindConstructor = { fg = "syntax.func"; };

                BlinkCmpKindInterface = { fg = "syntax.const"; };
                BlinkCmpKindEvent = { fg = "syntax.const"; };
                BlinkCmpKindEnum = { fg = "syntax.const"; };
                BlinkCmpKindUnit = { fg = "syntax.const"; };

                BlinkCmpKindClass = { fg = "syntax.type"; };
                BlinkCmpKindStruct = { fg = "syntax.type"; };

                BlinkCmpKindModule = { fg = "syntax.ident"; };

                BlinkCmpKindProperty = { fg = "syntax.ident"; };
                BlinkCmpKindField = { fg = "syntax.ident"; };
                BlinkCmpKindTypeParameter = { fg = "syntax.ident"; };
                BlinkCmpKindEnumMember = { fg = "syntax.ident"; };
                BlinkCmpKindOperator = { fg = "syntax.operator"; };
                BlinkCmpKindSnippet = { fg = "palette.fg2"; };

                LspReferenceText = { link = "Visual"; };
                LspReferenceRead = { link = "LspReferenceText"; };
                LspReferenceWrite = { link = "LspReferenceText"; };

                TreesitterContext = { bg = "palette.bg3"; };
                TreesitterContextLineNumberBottom = { bg = "palette.bg1"; };
            };
        };
        inverse = {
            match_paren = true;
        };
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

    keymaps = [
      {
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
        mode = [ "n" ];
      }
    ];

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

    plugins = {
      lz-n.enable = true;
      sleuth.enable = true;
      sandwich.enable = true;
      quicker.enable = true;
      todo-comments.enable = true;
      rainbow-delimiters.enable = true;
      nvim-autopairs.enable = true;


      treesitter = {
        enable = true;

        settings = {
          highlight.enable = true;
          indent.enable = true;
        };

        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          fish
          markdown
          make
          lua
          c
          cpp
          python
          racket
          nix
        ];
      };

      blink-cmp = {
        enable = false;
        setupLspCapabilities = true;
        settings = {
            keymap = {
              preset = "enter";
            };
            appearance = {
                nerd_font_variant = "mono";
            };
            snippets = {
              preset = "luasnip";
            };
            sources = {
                default = [ "lsp" "path" "snippets" "buffer" ];
            };
            fuzzy = { implementation = "prefer_rust_with_warning"; };
            signature = { enabled = true; };
        };
      };

      fzf-lua = {
        enable = true;

        settings = {
          fzf_opts = {
            "--pointer" = " ";
            "--separator" = " ";
          };
          fzf_colors = {
            "fg" = [ "fg" "Comment" ];
            "bg" = [ "bg" "palette.bg0" ];
            "hl" = [ "fg" "Normal" ];
            "fg+" = [ "fg" "Comment" "bold" ];
            "bg+" = [ "bg" [ "palette.sel0" "Normal" ] ];
            "hl+" = [ "fg" "Normal" ];
            "info" = [ "fg" "NonText" ];
            "prompt" = [ "fg" "FzfLuaBufLineNr" ];
            "spinner" = [ "fg" "FzfLuaBufNr" ];
            "header" = [ "fg" "Normal" ];
            "query" = [ "fg" "palette.green" ];
            "gutter" = "-1";
          };
          winopts = {
            backdrop = false;
            height = 0.7;
            width = 0.65;
            preview = {
              layout = "vertical";
            };
          };
        };

        keymaps = {
          "<leader>sh" = {
            action = "helptags";
            settings = {
              desc = "[S]earch [H]elp";
            };
          };
          "<leader>sk" = {
            action = "keymaps";
            settings = {
              desc = "[S]earch [K]eymaps";
            };
          };
          "<leader>sf" = {
            action = "files";
            settings = {
              desc = "[S]earch [F]iles";
            };
          };
          "<leader>ss" = {
            action = "builtin";
            settings = {
              desc = "[S]earch [S]elect fzf";
            };
          };
          "<leader>sw" = {
            action = "grep_cword";
            settings = {
              desc = "[S]earch current [W]ord";
            };
          };
          "<leader>sg" = {
            action = "live_grep_native";
            settings = {
              desc = "[S]earch by [G]rep";
            };
          };
          "<leader>sr" = {
            action = "resume";
            settings = {
              desc = "[S]earch [R]esume";
            };
          };
          "<leader>sb" = {
            action = "buffers";
            settings = {
              desc = "[S]earch existing [B]uffers";
            };
          };
        };
      };
    };

    extraConfigLuaPost = ''
        require('nvim-autopairs').get_rules("'")[1].not_filetypes = { "scheme", "lisp", "racket" }
    '';
  };
}
