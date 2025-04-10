{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      openconnect = prev.openconnect.overrideAttrs (oldAttrs: {
        src = final.fetchFromGitLab {
          owner = "openconnect";
          repo = "openconnect";
          rev = "f17fe20d337b400b476a73326de642a9f63b59c8";
          hash = "sha256-OBEojqOf7cmGtDa9ToPaJUHrmBhq19/CyZ5agbP7WUw=";
        };
      });
    })
  ];

  networking = {
    hosts = {
      "10.40.84.215" = [ "uni" ];
    };

    networkmanager.ensureProfiles.profiles = {
      UdeS = {
        connection = {
          id = "UdeS";
          type = "vpn";
          autoconnect = false;
          permissions = "";
        };

        vpn = {
          authtype = "password";
          autoconnect-flags = 0;
          certsigs-flags = 0;
          cookie-flags = 2;
          disable_udp = "no";
          enable_csd_trojan = "no";
          gateway = "rpv.usherbrooke.ca";
          gateway-flags = 2;
          gwcert-flags = 2;
          lasthost-flags = 0;
          pem_passphrase_fsid = "no";
          prevent_invalid_cert = "no";
          protocol = "anyconnect";
          resolve-flags = 2;
          stoken_source = "disabled";
          useragent = "AnyConnect-compatible OpenConnect VPN agent";
          xmlconfig-flags = 0;
          service-type = "org.freedesktop.NetworkManager.openconnect";
        };

        ipv4 = {
          method = "auto";
        };

        ipv6 = {
          addr-gen-mode = "default";
          method = "auto";
        };

        proxy = { };
      };
    };
  };

}
