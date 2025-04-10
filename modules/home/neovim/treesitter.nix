{ pkgs }:
let grammarsPath = with pkgs.vimPlugins; pkgs.symlinkJoin  {
  name = "nvim-treesitter-grammars";
  paths = nvim-treesitter.withAllGrammars.dependencies;
  }; in with pkgs.vimPlugins;
# Lua
''
{
  dir = "${nvim-treesitter}",
  event = "BufRead",
  config = function()
    vim.opt.runtimepath:append("${nvim-treesitter}")
    vim.opt.runtimepath:append("${grammarsPath}")
    require("nvim-treesitter.configs").setup({
      modules = {},
      sync_install = false,
      ignore_install = {},
      ensure_installed = {},
      auto_install = false,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true
      },
    })
  end
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
