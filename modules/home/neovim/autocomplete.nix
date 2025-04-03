{ ... }:

{
  programs.nixvim = {
    plugins.blink-cmp = {
      enable = true;
      setupLspCapabilities = true;
      settings = {
        keymap = {
          preset = "enter";
        };
        appearance = {
          nerd_font_variant = "mono";
        };
        snippets = {
          preset = "luasnip";
        };
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
        };
        fuzzy = {
          implementation = "prefer_rust_with_warning";
        };
        signature = {
          enabled = true;
        };
      };
    };

  };
}
