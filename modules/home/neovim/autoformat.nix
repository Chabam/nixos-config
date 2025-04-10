{ pkgs }:
with pkgs.vimPlugins;
# Lua
''
{
  dir = "${conform-nvim}",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  config = function()
    require("conform").setup({
      notify_on_error = false,
      formatters_by_ft = {
        cpp = { "clang_format" },
        lua = { "stylua" },
        nix = { "nixfmt" },
        python = { "isort", "black" },
        tex = { "latexindent" },
      },
      formatters = {
        stylua = {
          prepend_args = {
            "--indent-type",
            "Spaces",
          },
        },
        clang_format = {
          prepend_args = { "--style=file", "--fallback-style=Microsoft"}
        }
      },
    })
  end
}
''
