{ pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    neovim
    unzip
    fzf
    ripgrep

    # Mason
    nodejs_23
  ];

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };

  programs.nixvim = {
    enable = true;
  }
}
