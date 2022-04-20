# Personal Development Environment (PDE)

Ejecuta:

```shell
docker pull evaristor/pde:latest
docker run --interactive --name devenv --rm --tty --volume ${PWD}:/workdir evaristor/pde:latest bash
```

# Related repos

- [Internal Developer Platform (IDP)](https://github.com/IslasGEI/devenv)
- [Dotfiles](https://github.com/devarops/dotfiles)
- [Development server setup via Ansible](https://github.com/IslasGECI/development_server_setup)
