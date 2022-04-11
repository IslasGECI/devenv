# Configura tu entorno para desarrollo

## En tu estación de trabajo

> NOTA: En realidad esto no tiene que ser en tu estación de trabajo, podría ser desde otra estación de trabajo o servidor mediante Terraform.

1. Agrega o actualiza la bóbeda secreta de tu estación de trabajo
1. Crea Droplet
1. Copia IP
1. Crea tu clave SSH con `ssh-keygen`
1. Copia tu clave SSH con `ssh-copy-id root@<IP que copiaste en el tercer paso>`
1. Instala Ansible y Make: `sudo apt update && sudo apt install --yes ansible make`
1. Crea archivo `/etc/ansible/hosts`[^ansible_hosts]
1. En la raiz del repo [`development_server_setup`](https://github.com/IslasGECI/development_server_setup), ejecuta: `ANSIBLE_HOST_KEY_CHECKING=False && make`

[^ansible_hosts]: El contenido del archivo `/etc/ansible/hosts` es el siguiente:
    ```
    [development]
    <IP que copiaste en el tercer paso> ansible_user=root
    ```

## En el servidor de desarrollo

> TODO: Mueve esta sección al _playbook_ que se encuentra en [Workstation setup via Ansible](https://github.com/IslasGECI/workstation_setup)

1. Crea tu clave SSH: `ssh-keygen`
1. Agrega una nueva llave SSH a [GitHub](https://github.com/settings/keys/) y [Bitbucket](https://bitbucket.org/account/settings/ssh-keys/) copiando el contenido de `~/.ssh/id_rsa.pub`.
1. Instala:
    - [exa](https://github.com/ogham/exa)
    - [geci-testmake](https://github.com/IslasGECI/testmake)
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
