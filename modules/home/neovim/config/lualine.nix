{ ... }:

{
  programs.nixvim = {

    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          section_separators = "";
          component_separators = "";
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [
            "branch"
            "diff"
            "diagnostics"
          ];
          lualine_c = [ "filesize" ];
          lualine_x = [
            "encoding"
            "fileformat"
            "filetype"
          ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
        inactive_sections = {
          lualine_c = [
            {
              __unkeyed = "filename";
              path = 1;
            }
          ];
        };
        tabline = {
          lualine_a = [
            {
              __unkeyed = "filename";
              path = 1;
              shorting_target = 0;
            }
          ];
          lualine_y = [
            "searchcount"
            "selectioncount"
          ];
          lualine_z = [
            {
              __unkeyed = "tabs";
              mode = 2;
            }
          ];
        };
      };
    };
  };
}
