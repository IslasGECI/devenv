# Crea un entorno para desarrollo en el servidor

## En el servidor:

1. Crear cuenta de usuario: `sudo adduser evaro`
1. Agrega usuaro a los grupos _docker_ y _sudo_: `sudo usermod --append --groups docker,sudo evaro`
1. Cambia de usario: `su - evaro`
1. Crea tu clave SSH: `ssh-keygen`
1. Agrega una nueva llave SSH a [GitHub](https://github.com/settings/keys/) y [Bitbucket](https://bitbucket.org/account/settings/ssh-keys/) copiando el contenido de `~/.ssh/id_rsa.pub`.
1. Sigue [estas instrucciones](https://github.com/devarops/dotfiles/blob/develop/README.md)
1. Instala:
    - [exa](https://github.com/ogham/exa)
    - [Neofetch](https://github.com/dylanaraps/neofetch)
    - [Neovim](https://github.com/neovim/neovim)
    - [Powerline-shell](https://github.com/b-ryan/powerline-shell)
    - [tmux](https://github.com/tmux/tmux)
1. Agrega tu nombre y correo en Git: `git config --global --edit`

## En tu estación de trabajo:

1. (Si no lo haz hecho, crea tu clave SSH: `ssh-keygen`)
1. Agrega la clave SSH de tu estación de trabajo al servidor: `ssh-copy-id evaro@islasgeci.dev`

## Related repos

- [Development environment container](https://github.com/devarops/devenv)
- [Dotfiles](https://github.com/devarops/dotfiles)
- [Workstation setup via Ansible](https://github.com/IslasGECI/workstation_setup)
