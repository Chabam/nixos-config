{ pkgs }:
with pkgs.vimPlugins;
# Lua
''
{
  dir = "${blink-cmp}",
  event = "InsertEnter",
  config = function()
    require("blink-cmp").setup({
      keymap = { preset = "default" },
      appearance = {
          nerd_font_variant = "mono"
      },
      snippets = { preset = "luasnip" },
      sources = {
          default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      signature = { enabled = true },
      completion = {
        accept = {
          auto_brackets = {
            enabled = false;
          },
        },
      },
      completion = {
        documentation = {
          auto_show = true
        },
        menu = {
          draw = {
             columns = {
                  { "kind_icon" },
                  { "label", "label_description" },
                  { "kind" }
            },
          }
        }
      }
    })
  end
}
''
