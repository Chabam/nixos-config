{ pkgs }:
with pkgs.vimPlugins; ''
{
  dir = "${nvim-treesitter}",
  event = "BufRead",
  opts = {
    highlight = {
      enable = true,
    },
    indent = { enable = true },
  }
},
{
  dir = "${nvim-treesitter-context}",
  event = "BufRead",
  opts = {
    max_lines = 1,
    mode = "topline",
  }
}
''
