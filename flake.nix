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
    (python3.withPackages(ps: with ps; [
      black
      flake8
      ipython
      pip
      pylint
      pytest
      rope
    ]))
    (rWrapper.override{packages = with rPackages; [ languageserver ];})
    (with nodePackages; [ npm pyright ])
    fd
    mutmut
    neofetch
    neovim
    nodejs_20
    rich-cli
    shellcheck
      ];
    };
  };
}
