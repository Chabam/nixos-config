{ pkgs }:
with pkgs.vimPlugins; ''
{
    dir = "${luasnip}",
    event = "InsertEnter",
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
},
{
  dir = "${friendly-snippets}"
}
''
