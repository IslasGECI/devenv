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

  packages = with pkgs; [
    (pkgs.python3.withPackages(ps: with ps; [ 
      black
      flake8
      ipython
      pylint
      pytest
      rope
    ]))
    mutmut
    neofetch
    neovim
    nodejs_20
    nodePackages.npm
    nodePackages.pyright
    python310Packages.pip
    rich-cli
    shellcheck
      ];
    };
  };
}
