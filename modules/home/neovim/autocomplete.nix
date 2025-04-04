{ pkgs }:
with pkgs.vimPlugins; ''
{
    dir = "${blink-cmp}",
    config = function()
      require("blink-cmp").setup({
        keymap = { preset = "enter" },
        appearance = {
            nerd_font_variant = "mono"
        },
        -- snippets = { preset = "luasnip" },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        signature = { enabled = true },
      })
    end
}
''
