{ pkgs, ... }:
let
  conformPkgs = with pkgs; [
    clang-tools # Also for clangd
    nixfmt-rfc-style
    stylua
    texlivePackages.latexindent
  ];
  treesitterPkgs = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    bash
    c
    cpp
    fish
    lua
    make
    markdown
    nix
    python
    racket
  ];
  pluginsPkgs = with pkgs.vimPlugins; [
    # oil-git-status.nvim
    adwaita-nvim
    blink-cmp
    conform-nvim
    diffview-nvim
    fzf-lua
    gitsigns-nvim
    indent-blankline-nvim
    lazy-nvim
    nvim-lspconfig
    nvim-treesitter
    nvim-treesitter-context
    nvim-web-devicons
    oil-nvim
    plenary-nvim
    quicker-nvim
    rainbow-delimiters-nvim
    todo-comments-nvim
    vim-sandwich
    vim-sleuth
    vimtex
  ];
  lspPkgs = with pkgs; [
    cmake-language-server
    ltex-ls-plus
    nil # Nix
    pyright
  ];
in
{
  home.packages = lspPkgs ++ conformPkgs;

  programs.neovim = {
    enable = true;

    plugins = pluginsPkgs ++ treesitterPkgs;

    extraLuaConfig =
      with pkgs.vimPlugins;
      # lua
      ''
        ${(import ./options.nix) { }}
        require("lazy").setup({
          rocks = { enabled = false };
          pkg = { enabled = false };
          install = { enabled = false };
          change_detection = { enabled = false };
          spec = {
            { dir = "${vim-sleuth}" },
            { dir = "${vim-sandwich}" },
            { dir = "${rainbow-delimiters-nvim}" },
            { dir = "${oil-nvim}" },
            {
              dir = "${indent-blankline-nvim}",
              main = "ibl",
              opts = {}
            },
            { dir = "${quicker-nvim}" },
            {
              dir = "${todo-comments-nvim}",
              event = "VimEnter",
            },
            {
              {
                dir = "${diffview-nvim}",
                opts = {
                  view = {
                    merge_tool = {
                      layout = "diff3_mixed"
                    }
                  }
                }
              }
            },
            ${pkgs.callPackage ./autocomplete.nix { }},
            ${pkgs.callPackage ./autoformat.nix { }},
            ${pkgs.callPackage ./treesitter.nix { }},
            ${pkgs.callPackage ./fzf.nix { }},
            ${pkgs.callPackage ./oil.nix { }},
            ${pkgs.callPackage ./lsp.nix { }},
            ${pkgs.callPackage ./colorscheme.nix { }},
            ${pkgs.callPackage ./gitsigns.nix { }},
          },
        })
        ${(import ./autogroups.nix) { }}
        ${(import ./keymaps.nix) { }}
      '';
  };
}
