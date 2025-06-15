{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/30f5b83d-95af-416b-803a-124cf7ade40d";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/23B7-D746";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/run/media/chabam/Data" = {
    device = "/dev/disk/by-uuid/9848266f-f628-4f66-9cd3-d78bdddb9705";
    fsType = "ext4";
  };

  fileSystems."/run/media/chabam/Backups" = {
    device = "/dev/disk/by-uuid/6e9a5fca-8e48-40e9-8bbf-22af30c738f5";
    fsType = "ext4";
  };

  fileSystems."/run/media/chabam/Servers" = {
    device = "/dev/disk/by-uuid/160efb82-85ff-4c07-8542-f72f18b2bcd5";
    fsType = "ext4";
  };

  fileSystems."/run/media/chabam/Games" = {
    device = "/dev/disk/by-uuid/69737F0A08903A87";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
