{ ... }:
{
  imports = [
    ./auto-upgrade.nix
    ./flatpak.nix
    ./gc.nix
    ./gnome.nix
    ./grub.nix
    ./main-user.nix
    ./nvidia.nix
    ./plymouth.nix
    ./syncthing.nix
    ./uni-remote.nix
    ./virt-manager.nix
  ];
}
