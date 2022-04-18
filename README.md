# Configura tu entorno para desarrollo

## Autenticación mediante SSH

1. En tu estación de trabajo crea tu clave SSH con: `ssh-keygen`
1. Agrega la clave SSH pública[^ssh_pub] de tu estación de trabajo a:
    - [Bitbucket](https://bitbucket.org/account/settings/ssh-keys/),
    - [DigitalOcean](https://cloud.digitalocean.com/account/security) y
    - [GitHub](https://github.com/settings/keys/)

[^ssh_pub]: Copia el contenido del archivo `~/.ssh/id_rsa.pub` de tu estación de trabajo y pégalo en las aplicaciones indicadas

## En DigitalOcean

1. [Crea una Droplet](https://cloud.digitalocean.com/droplets/new)
    - Selecciona la región correspondiente a la IP flotante (actualmente es San Francisco 3: SF3)
    - Selecciona la clave SSH de tu estación de trabajo como medio de autenticación
1. [Reasigna la IP](https://cloud.digitalocean.com/networking/floating_ips) flotante correspondiente a la Droplet nueva

## En tu estación de trabajo

> NOTA: En realidad esto no tiene que ser en tu estación de trabajo, podría ser desde otra estación de trabajo o servidor mediante Terraform.

1. Agrega o actualiza la bóbeda secreta de tu estación de trabajo
1. Copia la clave SSH de tu estación de trabajo al servidor[^ssh_config]
1. Instala Ansible y Make: `sudo apt update && sudo apt install --yes ansible make`
1. Crea el archivo `/etc/ansible/hosts`[^ansible_hosts]
1. En la raiz del repo [`development_server_setup`](https://github.com/IslasGECI/development_server_setup), ejecuta: `ANSIBLE_HOST_KEY_CHECKING=False && make`

[^ssh_config]: En tu estación de trabajo ejecuta:
    ```shell
    ssh-keygen -f "~/.ssh/known_hosts" -R "islasgeci.dev"
    scp ~/.ssh/id_rsa* root@islasgeci.dev:/root/.ssh/
    ```

[^ansible_hosts]: El contenido del archivo `/etc/ansible/hosts` es el siguiente:
    ```
    [development]
    islasgeci.dev ansible_user=root
    ```

## En el servidor de desarrollo

> TODO: Mueve esta sección al _playbook_ que se encuentra en [Development server setup via Ansible](https://github.com/IslasGECI/development_server_setup)

1. Entra mediante: `ssh root@islasgeci.dev`
1. Instala [geci-testmake](https://github.com/IslasGECI/testmake)
1. Instala los [archivos de configuración personal](https://github.com/devarops/dotfiles/blob/develop/README.md)
1. Agrega tu nombre y correo en Git: `git config --global --edit`

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
