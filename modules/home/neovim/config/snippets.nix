{ pkgs, ... }:

{
  programs.nixvim = {

    plugins = {
      luasnip.enable = true;
      friendly-snippets.enable = true;
    };

    extraPackages = with pkgs; [
      luajitPackages.jsregexp
    ];
  };
}
