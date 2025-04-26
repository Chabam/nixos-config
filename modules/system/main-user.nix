{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.main-user;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options = {
    main-user = {
      userName = lib.mkOption {
        type = lib.types.str;
        description = "The user's name";
      };
      fullName = lib.mkOption {
        type = lib.types.str;
        description = "The user's full name";
      };
      initialPassword = "12345";
    };
  };

  config = {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      description = "${cfg.fullName}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "docker"
      ] ++ lib.optionals config.gaming.enable [ "gamemode" ];
      packages = [
        inputs.home-manager.packages.${pkgs.system}.default
        pkgs.flatpak
      ];
    };

    home-manager = {
      extraSpecialArgs = { inherit inputs; };
      useGlobalPkgs = true;
      useUserPackages = true;
      users = {
        "${cfg.userName}" = ../home;
      };
    };
  };
}
