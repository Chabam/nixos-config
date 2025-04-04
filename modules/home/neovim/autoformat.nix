{ pkgs }:
with pkgs.vimPlugins; ''
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
        lua = { "stylua" },
        tex = { "latexindent" },
        cpp = { "clang_format" },
        nix = { "nixfmt" },
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
