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
    blink-cmp
    conform-nvim
    diffview-nvim
    friendly-snippets
    fzf-lua
    gitsigns-nvim
    indent-blankline-nvim
    iron-nvim
    lazy-nvim
    luasnip
    nightfox-nvim
    nvim-lspconfig
    nvim-treesitter
    nvim-treesitter-context
    nvim-web-devicons
    oil-nvim
    plenary-nvim
    quicker-nvim
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
  miscPkgs = with pkgs; [
    luajitPackages.jsregexp
    tree-sitter
  ];
in
{
  home.packages = lspPkgs ++ conformPkgs;

  programs.neovim = {
    enable = true;

    plugins = pluginsPkgs ++ treesitterPkgs ++ miscPkgs;

    extraLuaConfig = with pkgs.vimPlugins;
      ''
        ${(import ./options.nix) { }}
        require("lazy").setup({
          rocks = { enabled = false };
          pkg = { enabled = false };
          install = { enabled = false };
          change_detection = { enabled = false };
          spec = {
            {
              dir = "${vim-sleuth}",
              event = "BufRead"
            },
            {
              dir = "${vim-sandwich}",
              event = "InsertEnter"
            },
            {
              dir = "${indent-blankline-nvim}",
              event = "BufRead",
              config = function()
                require("ibl").setup()
              end
            },
            {
              dir = "${quicker-nvim}",
              event = "FileType qf",
              opts = {}
            },
            {
              dir = "${todo-comments-nvim}",
              event = "BufRead",
              config = function()
                require("todo-comments").setup({})
              end
            },
            ${pkgs.callPackage ./autocomplete.nix { }},
            ${pkgs.callPackage ./autoformat.nix { }},
            ${pkgs.callPackage ./colorscheme.nix { }},
            ${pkgs.callPackage ./diffview.nix { }},
            ${pkgs.callPackage ./fzf.nix { }},
            ${pkgs.callPackage ./gitsigns.nix { }},
            ${pkgs.callPackage ./iron.nix { }},
            ${pkgs.callPackage ./lsp.nix { }},
            ${pkgs.callPackage ./oil.nix { }},
            ${pkgs.callPackage ./snippets.nix { }},
            ${pkgs.callPackage ./treesitter.nix { }},
            ${pkgs.callPackage ./vimtex.nix { }},
          },
        })
        ${(import ./autogroups.nix) { }}
        ${(import ./functions.nix) { }}
        ${(import ./keymaps.nix) { }}
      '';
  };
}
