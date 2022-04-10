# Configura tu entorno para desarrollo

## En tu estación de trabajo

1. Crea tu clave SSH con `ssh-keygen` y agrega o actualiza la bóbeda secreta de tu estación de trabajo
1. Instala Ansible en tu estación de trabajo
1. Create Droplet
1. Copy IP
1. Crea archivo `/etc/ansible/hosts`[^ansible_hosts]
1. Edita el archivo `/etc/hosts`[^host_aliases]
3. Ejecuta `make` en la raiz del repo [`development_server_setup`](https://github.com/IslasGECI/development_server_setup)

[^ansible_hosts]: El contenido del archivo `/etc/ansible/hosts` es el siguiente:
    ```
    [development]
    <IP que copiaste en el segundo paso> ansible_user=root
    ```

[^host_aliases]: Al archivo `/etc/hosts` agrega la línea siguiente:
    ```
    <IP que copiaste en el segundo paso>  development
    ```

## En el servidor de desarrollo

> TODO: Mueve esta sección al _playbook_ que se encuentra en [Workstation setup via Ansible](https://github.com/IslasGECI/workstation_setup)

1. Instala OpenSSH: `apt install openssh-client`
1. Crea tu clave SSH: `ssh-keygen`
1. Agrega una nueva llave SSH a [GitHub](https://github.com/settings/keys/) y [Bitbucket](https://bitbucket.org/account/settings/ssh-keys/) copiando el contenido de `~/.ssh/id_rsa.pub`.
1. Instala:
    - [exa](https://github.com/ogham/exa)
    - [geci-testmake](https://github.com/IslasGECI/testmake)
    - [Neofetch](https://github.com/dylanaraps/neofetch)
    - [Neovim](https://github.com/neovim/neovim)
    - [Powerline-shell](https://github.com/b-ryan/powerline-shell)
    - [tmux](https://github.com/tmux/tmux)
1. Sigue [estas instrucciones](https://github.com/devarops/dotfiles/blob/develop/README.md)
1. Agrega tu nombre y correo en Git: `git config --global --edit`

# Crea un entorno para desarrollo en un contenedor

Ejecuta:

```shell
docker pull evaristor/devenv:latest
docker run --interactive --name devenv --rm --tty --volume ${PWD}:/workdir evaristor/devenv:latest bash
```

# Related repos

- [Development environment container](https://github.com/devarops/devenv)
- [Dotfiles](https://github.com/devarops/dotfiles)
- [Development server setup via Ansible](https://github.com/IslasGECI/development_server_setup)
