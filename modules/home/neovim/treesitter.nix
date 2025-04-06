{ pkgs }:
with pkgs.vimPlugins; ''
{
  dir = "${nvim-treesitter}",
  opts = {
    highlight = {
      enable = true,
    },
    indent = { enable = true },
  }
},
{
  dir = "${nvim-treesitter-context}",
  opts = {
    max_lines = 1,
    mode = "topline",
  }
}
''
