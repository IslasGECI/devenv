FROM islasgeci/base:latest


# Instala paquetes en el sistema operativo
RUN apt update && apt full-upgrade --yes && apt install --yes \
    build-essential \
    exa \
    fd-find \
    r-base \
    ripgrep \
    snapd \
    tmux \
    universal-ctags \
    wget \
        && \
    apt clean

# Install Nix package manager
ENV PATH="/root/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
RUN git clone https://github.com/IslasGECI/pde.git /root/pde && \
    cp /root/pde/flake.nix /workdir/flake.nix
RUN curl -L https://nixos.org/nix/install | sh -s -- --daemon && \
    echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf && \
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && \
    nix develop --command neofetch

# Install Neovim configuration
RUN mkdir --parents /root/.config && \
    git clone https://github.com/nvim-lua/kickstart.nvim.git /root/.config/nvim && \
    echo 'require("vimrc")' >> /root/.config/nvim/init.lua
RUN cp --force --recursive /root/pde/dotfiles/. /root

# Enter the development environment
CMD ["nix", "develop", "github:IslasGECI/pde"]
