{  ... }:

{
  programs.nixvim = {

    plugins.oil = {
      enable = true;
      lazyLoad.settings.cmd = "Oil";

      settings = {
        watch_for_changes = true;
        win_options = {
          signcolumn = "yes:2";
        };
        buf_options = {
          buflisted = true;
        };
        keymaps = {
          "gd" = {
            desc = "Toggle file detail view";
            callback.__raw = ''
              function()
                  detail = not detail
                  if detail then
                      require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                  else
                      require("oil").set_columns({ "icon" })
                  end
              end
            '';
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "-";
        action = "<CMD>Oil<CR>";
        options = {
          desc = "Open parent directory";
        };
      }
    ];
  };
}
