{ pkgs, grammars, ... }:
let grammarsPath = pkgs.symlinkJoin  {
  name = "nvim-treesitter-grammars";
  paths = grammars.dependencies;
  }; in with pkgs.vimPlugins;
# Lua
''
{
  dir = "${nvim-treesitter}",
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
  opts = {
    max_lines = 1,
    mode = "topline",
  }
}
''
