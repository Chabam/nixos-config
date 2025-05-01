{
  description = "A Python pip flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      lib = nixpkgs.lib;
      sysDeps = with pkgs; [
      ];
    in
    {
      packages.x86_64-linux.default = pkgs.mkShell {
        LD_LIBRARY_PATH = lib.makeLibraryPath sysDeps;
        packages = with pkgs; [
          python311
          python311Packages.pip
          python311Packages.venvShellHook
        ];
        venvDir = ".venv";
        postVenvCreation = ''
          unset SOURCE_DATE_EPOCH
          pip install -r requirements.txt
        '';
      };
    };
}
