{ ... }:

{
  programs.nixvim = {
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
            Visual = {
              bg = "#2C394E";
            };
            CurSearch = {
              bg = "#5F84C4";
            };
          };
          dawnfox = {
            Visual = {
              bg = "#DDEAFF";
            };
            CurSearch = {
              bg = "#9ABFFF";
            };
          };
          all = {
            Search = {
              link = "Visual";
            };
            IncSearch = {
              link = "CurSearch";
            };

            Substitute = {
              link = "Visual";
            };
            FloatBorder = {
              fg = "palette.bg0";
              bg = "palette.bg0";
            };

            Pmenu = {
              fg = "palette.comment";
              bg = "palette.bg2";
            };
            PmenuSel = {
              bg = "palette.bg3";
              style = "bold";
            };
            PmenuSbar = {
              bg = "palette.sel1";
            };
            PmenuThumb = {
              bg = "palette.fg3";
            };

            FzfLuaNormal = {
              fg = "palette.fg1";
              bg = "palette.bg0";
            };
            FzfLuaPreviewNormal = {
              fg = "palette.fg1";
              bg = "palette.bg0";
            };
            FzfLuaDirPart = {
              fg = "palette.magenta";
            };
            FzfLuaFilePart = {
              fg = "palette.fg1";
            };
            FzfLuaLivePrompt = {
              fg = "palette.fg1";
              bg = "palette.bg0";
            };
            FzfLuaBorder = {
              fg = "palette.bg0";
              bg = "palette.bg0";
            };
            FzfLuaTitle = {
              fg = "palette.bg0";
              bg = "palette.green.bright";
            };
            FzfLuaPreviewTitle = {
              fg = "palette.bg0";
              bg = "palette.pink";
            };
            FzfLuaCursor = {
              fg = "palette.fg1";
              bg = "palette.bg0";
            };
            FzfLuaCursorLineNr = {
              fg = "palette.red";
              bg = "palette.bg0";
            };
            FzfLuaCursorLine = {
              bg = "palette.bg1";
            };
            FzfLuaScrollBorderEmpty = {
              bg = "palette.bg1";
            };
            FzfLuaScrollBorderFull = {
              bg = "palette.bg2";
            };
            FzfLuaBufNr = {
              fg = "palette.green";
            };
            FzfLuaBufLineNr = {
              fg = "palette.blue";
            };
            FzfLuaBufFlagCur = {
              fg = "palette.pink";
            };

            FzfLuaFzfMatch = {
              fg = "palette.fg1";
              bg = "palette.bg0";
            };
            FzfLuaFzfHeader = {
              fg = "palette.fg1";
              bg = "palette.bg0";
            };
            FzfLuaFzfGutter = {
              bg = "palette.bg0";
            };
            FzfLuaFzfNormal = {
              fg = "palette.fg1";
            };
            FzfLuaFzfQuery = {
              fg = "palette.fg1";
            };
            FzfLuaFzfMarker = {
              fg = "palette.pink";
            };
            FzfLuaFzfPrompt = {
              fg = "palette.pink";
            };
            FzfLuaHeaderBind = {
              fg = "palette.blue";
            };

            BlinkCmpDoc = {
              fg = "palette.fg1";
              bg = "palette.bg0";
            };
            BlinkDocBorder = {
              fg = "palette.bg2";
              bg = "palette.bg0";
            };
            BlinkCmpAbbr = {
              fg = "palette.comment";
            };
            BlinkCmpAbbrDeprecated = {
              fg = "syntax.dep";
              style = "strikethrough";
            };
            BlinkCmpAbbrMatch = {
              fg = "palette.fg1";
            };
            BlinkCmpAbbrMatchFuzzy = {
              fg = "palette.fg1";
            };

            BlinkCmpKind = {
              link = "CmpItemKindFunction";
            };
            BlinkCmpKindDefault = {
              fg = "palette.fg2";
            };

            BlinkCmpKindKeyword = {
              fg = "palette.fg1";
            };

            BlinkCmpKindVariable = {
              fg = "syntax.variable";
            };
            BlinkCmpKindConstant = {
              fg = "syntax.const";
            };
            BlinkCmpKindReference = {
              fg = "syntax.keyword";
            };
            BlinkCmpKindValue = {
              fg = "syntax.keyword";
            };

            BlinkCmpKindFunction = {
              fg = "syntax.func";
            };
            BlinkCmpKindMethod = {
              fg = "syntax.func";
            };
            BlinkCmpKindConstructor = {
              fg = "syntax.func";
            };

            BlinkCmpKindInterface = {
              fg = "syntax.const";
            };
            BlinkCmpKindEvent = {
              fg = "syntax.const";
            };
            BlinkCmpKindEnum = {
              fg = "syntax.const";
            };
            BlinkCmpKindUnit = {
              fg = "syntax.const";
            };

            BlinkCmpKindClass = {
              fg = "syntax.type";
            };
            BlinkCmpKindStruct = {
              fg = "syntax.type";
            };

            BlinkCmpKindModule = {
              fg = "syntax.ident";
            };

            BlinkCmpKindProperty = {
              fg = "syntax.ident";
            };
            BlinkCmpKindField = {
              fg = "syntax.ident";
            };
            BlinkCmpKindTypeParameter = {
              fg = "syntax.ident";
            };
            BlinkCmpKindEnumMember = {
              fg = "syntax.ident";
            };
            BlinkCmpKindOperator = {
              fg = "syntax.operator";
            };
            BlinkCmpKindSnippet = {
              fg = "palette.fg2";
            };

            LspReferenceText = {
              link = "Visual";
            };
            LspReferenceRead = {
              link = "LspReferenceText";
            };
            LspReferenceWrite = {
              link = "LspReferenceText";
            };

            TreesitterContext = {
              bg = "palette.bg3";
            };
            TreesitterContextLineNumberBottom = {
              bg = "palette.bg1";
            };
          };
        };
        inverse = {
          match_paren = true;
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>cl";
        action = "<CMD>colorscheme dawnfox<CR>";
        options = {
          desc = "Toggle light mode";
        };
      }
      {
        mode = "n";
        key = "<leader>cd";
        action = "<CMD>colorscheme carbonfox<CR>";
        options = {
          desc = "Toggle dark mode";
        };
      }
    ];
  };
}
