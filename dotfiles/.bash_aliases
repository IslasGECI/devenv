alias develop='nix develop "github:IslasGECI/pde"'
alias nvim='which nvim | grep "/nix/store" && nvim || nix develop "github:IslasGECI/pde" --command nvim'
alias v=nvim
alias vi=nvim
alias vim=nvim
