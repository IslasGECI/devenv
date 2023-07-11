FROM islasgeci/base:latest

# Install Nix package manager
ENV PATH="/root/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
RUN curl -L https://nixos.org/nix/install | sh -s -- --daemon && \
    echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
RUN git clone https://github.com/IslasGECI/pde.git /root/pde && \
    cp /root/pde/flake.nix /workdir/flake.nix
RUN . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && \
    nix develop --command node --version | grep "v20"

# Install Neovim configuration
RUN mkdir --parents /root/.config && \
    git clone https://github.com/nvim-lua/kickstart.nvim.git /root/.config/nvim && \
    echo 'require("vimrc")' >> /root/.config/nvim/init.lua
RUN cp --force --recursive /root/pde/dotfiles/. /root
