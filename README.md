# Personal Development Environment (PDE) en un contenedor

Ejecuta:

```shell
docker pull islasgeci/devenv:latest
docker run --interactive --name devenv --rm --tty --volume ${PWD}:/workdir islasgeci/devenv:latest bash
```

# Related repos

- [Internal Developer Platform (IDP)](https://github.com/IslasGEI/devenv)
- [Dotfiles](https://github.com/devarops/dotfiles)
- [Development server setup via Ansible](https://github.com/IslasGECI/development_server_setup)
