{ pkgs }:
with pkgs.vimPlugins; ''
{
    dir = "${nvim-treesitter}",
    config = function()
      require("nvim-treesitter").setup({
        highlight = {
            enable = true,
        },
        indent = { enable = true },
    })
    end
},
{
    dir = "${nvim-treesitter-context}",
    config = function()
      require("treesitter-context").setup({
        max_lines = 1,
        mode = "topline",
    })
    end
}
''
