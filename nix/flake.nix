{
  description = "Portable Development Environment (PDE)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      packages.x86_64-linux.default = pkgs.mkShell {
        name = "pde";
        packages = with pkgs; [ neofetch ];
      };
    };
}
