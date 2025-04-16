{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.main-user;
in
{
  options = {
    main-user = {
      enable = lib.mkEnableOption "Enable main user module";
      userName = lib.mkOption {
        type = lib.types.str;
        default = "chabam";
        description = "The user's name";
      };
      fullName = lib.mkOption {
        type = lib.types.str;
        default = "Chabam";
        description = "The user's full name";
      };
      initialPassword = "12345";
      enableDocker = lib.mkEnableOption "Enable docker";
      enableVirtManager = lib.mkEnableOption "Enable Virt-Manager";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      description = "${cfg.fullName}";
      extraGroups =
        [
          "networkmanager"
          "wheel"
        ]
        ++ lib.optional cfg.enableDocker "docker"
        ++ lib.optional cfg.enableDocker "libvirtd";
      packages = [
        pkgs.flatpak
      ];
    };
  };
}
