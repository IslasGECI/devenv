# Crea un entorno para desarrollo en el servidor

## En el servidor:

1. Crear cuenta de usuario: `sudo adduser evaro`
1. Agrega usuaro al grupo sudo: `sudo usermod --append --groups sudo evaro`
1. Cambia de usario: `su - evaro`
1. Crea tu clave SSH: `ssh-keygen`
1. Agrega una nueva llave SSH a [GitHub](https://github.com/settings/keys/) y [Bitbucket](https://bitbucket.org/account/settings/ssh-keys/) copiando el contenido de `~/.ssh/id_rsa.pub`.
1. Sigue [estas instrucciones](https://github.com/devarops/dotfiles/blob/develop/README.md)

## En tu estación de trabajo:

1. (Si no lo haz hecho, crea tu clave SSH: ssh-keygen)
1. 1. Agrega la clave SSH de tu estación de trabajo al servidor: `ssh-copy-id evaro@islasgeci.dev`


