{ ... }:
{
  nix.gc = {
     automatic = true;
     dates = "weekly";
     options = "--delete-older-than 14d";
  };

  nix.extraOptions = ''
    min-free = ${toString (100 * 1024 * 1024)}
    max-free = ${toString (1024 * 1024 * 1024)}
  '';
}
