{ pkgs }:
with pkgs.vimPlugins;
''
{
      dir = "${gitsigns-nvim}",
      opts = {}
}
''
