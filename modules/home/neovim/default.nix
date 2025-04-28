{ pkgs, ... }:
let
  conformPkgs = with pkgs; [
    clang-tools # Also for clangd
    nixfmt-rfc-style
    black
    isort
    stylua
    texlivePackages.latexindent
  ];
  treesitterGrammars = with pkgs.vimPlugins; nvim-treesitter.withPlugins (p: [
    p.bash
    p.c
    p.cpp
    p.lua
    p.make
    p.markdown
    p.nix
    p.python
    p.racket
    p.r
  ]);
  pluginsPkgs = with pkgs.vimPlugins; [
    blink-cmp
    conform-nvim
    diffview-nvim
    friendly-snippets
    fzf-lua
    gitsigns-nvim
    iron-nvim
    lazy-nvim
    luasnip
    nightfox-nvim
    nvim-lspconfig
    nvim-surround
    treesitterGrammars
    nvim-treesitter-context
    nvim-web-devicons
    oil-nvim
    vim-dispatch
    vim-sleuth
    vimtex
  ];
  lspPkgs = with pkgs; [
    cmake-language-server
    ltex-ls-plus
    nixd
    pyright
    # For some reason the R lsp doesn't work without R
    # (rWrapper.override {
    #   packages = with rPackages; [ languageserver ];
    # })
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
    defaultEditor = true;

    plugins = pluginsPkgs ++ miscPkgs;

    extraLuaConfig = with pkgs.vimPlugins;
      # Lua
      ''
      ${pkgs.callPackage ./options.nix { }}
      require("lazy").setup({
        rocks = { enabled = false };
        pkg = { enabled = false };
        install = { enabled = false };
        change_detection = { enabled = false };
        spec = {
          {
            dir = "${vim-sleuth}",
            event = {"BufReadPre", "BufNewFile"},
          },
          {
            dir = "${vim-dispatch}",
            cmd = { "Make" },
          },
          {
            dir = "${nvim-surround}",
            event = {"BufRead", "BufNewFile"},
            opts = {}
          },
          ${pkgs.callPackage ./autoformat.nix { }},
          ${pkgs.callPackage ./blink.nix { }},
          ${pkgs.callPackage ./colorscheme.nix { }},
          ${pkgs.callPackage ./diffview.nix { }},
          ${pkgs.callPackage ./fzf.nix { }},
          ${pkgs.callPackage ./gitsigns.nix { }},
          ${pkgs.callPackage ./iron.nix { }},
          ${pkgs.callPackage ./lsp.nix { }},
          ${pkgs.callPackage ./oil.nix { }},
          ${pkgs.callPackage ./snippets.nix { }},
          ${pkgs.callPackage ./treesitter.nix { grammars = treesitterGrammars; }},
          ${pkgs.callPackage ./vimtex.nix { }},
        },
      })
      ${(import ./autogroups.nix) { }}
      ${(import ./functions.nix) { }}
      ${(import ./keymaps.nix) { }}
    '';
  };
}
