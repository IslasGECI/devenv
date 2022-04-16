# Configura tu entorno para desarrollo

## En DigitalOcean

1. Agrega a DigitalOcean la clave SSH pública de tu estación de trabajo
    - Antes, en tu estación de trabajo crea tu clave SSH con: `ssh-keygen`
1. Crea Droplet
1. Reasigna la IP flotante correspondiente a la Droplet nueva

## En tu estación de trabajo

> NOTA: En realidad esto no tiene que ser en tu estación de trabajo, podría ser desde otra estación de trabajo o servidor mediante Terraform.

1. Agrega o actualiza la bóbeda secreta de tu estación de trabajo
1. Crea el archivo `~/.ssh/config`[^ssh_config]
1. Crea el archivo `/etc/ansible/hosts`[^ansible_hosts]
1. Instala Ansible y Make: `sudo apt update && sudo apt install --yes ansible make`
1. En la raiz del repo [`development_server_setup`](https://github.com/IslasGECI/development_server_setup), ejecuta: `ANSIBLE_HOST_KEY_CHECKING=False && make`

[^ssh_config]: El contenido del archivo `~/.ssh/config` es el siguiente:
    ```
    Host islasgeci.dev
      ForwardAgent yes
    ```

[^ansible_hosts]: El contenido del archivo `/etc/ansible/hosts` es el siguiente:
    ```
    [development]
    islasgeci.dev ansible_user=root
    ```

## En el servidor de desarrollo

> TODO: Mueve esta sección al _playbook_ que se encuentra en [Development server setup via Ansible](https://github.com/IslasGECI/development_server_setup)

1. Instala:
    - [exa](https://github.com/ogham/exa)
    - [geci-testmake](https://github.com/IslasGECI/testmake)
    - [Neovim](https://github.com/neovim/neovim/releases/tag/stable)[^install_neovim]
1. Sigue [estas instrucciones](https://github.com/devarops/dotfiles/blob/develop/README.md)
1. Agrega tu nombre y correo en Git: `git config --global --edit`

[^install_neovim]: Para instalar Neovim ejecuta:
    ```shell
    wget --directory-prefix=$HOME https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod u+x $HOME/nvim.appimage
    $HOME/nvim.appimage --appimage-extract
    ln --symbolic $HOME/squashfs-root/usr/bin/nvim /usr/bin/nvim 
    ```

# Crea un entorno para desarrollo en un contenedor

Ejecuta:

```shell
docker pull islasgeci/devenv:latest
docker run --interactive --name devenv --rm --tty --volume ${PWD}:/workdir islasgeci/devenv:latest bash
```

# Related repos

- [Development environment container](https://github.com/devarops/devenv)
- [Dotfiles](https://github.com/devarops/dotfiles)
- [Development server setup via Ansible](https://github.com/IslasGECI/development_server_setup)
