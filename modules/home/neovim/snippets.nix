{ pkgs }:
with pkgs.vimPlugins; ''
{
    dir = "${luasnip}",
    event = "InsertEnter",
    dependencies = { dir = "${friendly-snippets}" },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
''
