{
  description = "A generic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          pandoc
          (texlive.combine {
            inherit (pkgs.texlive)
              scheme-small
              pmboxdraw
              ;
          })
        ];
        env = { };
        shellHook = '''';
      };
    };
}
