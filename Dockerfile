FROM islasgeci/base:latest

# Install Nix package manager
ENV PATH="/root/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
RUN curl -L https://nixos.org/nix/install | sh -s -- --daemon && \
    echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
RUN git clone https://github.com/IslasGECI/pde.git /root/pde && \
    cp /root/pde/flake.nix /workdir/flake.nix
RUN . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && \
    nix develop --command nvim --version

# Instala paquetes en el sistema operativo
RUN apt update && apt full-upgrade --yes && apt install --yes \
    fd-find \
    pip \
    ripgrep \
    universal-ctags \
    wget \
        && \
    apt clean

# Instala modulos con pip
RUN pip install --upgrade pip && pip install \
    rope

# Install Node
ENV NODE_VERSION=18.16.1
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

# Instala modulos con npm
RUN npm install --global \
    pyright

# Instala paquetes de R
RUN Rscript -e "install.packages('languageserver', repos='http://cran.rstudio.com')"

# Install Neovim
RUN wget --directory-prefix="/root" https://github.com/neovim/neovim/releases/download/stable/nvim.appimage && \
    chmod u+x /root/nvim.appimage && \
    cd /root && /root/nvim.appimage --appimage-extract && \
    ln -s /root/squashfs-root/AppRun /usr/bin/nvim

# Setup Neovim kickstart configuration
RUN mkdir --parents /root/.config && \
    git clone https://github.com/nvim-lua/kickstart.nvim.git /root/.config/nvim && \
    echo 'require("vimrc")' >> /root/.config/nvim/init.lua
RUN cp --force --recursive /root/pde/dotfiles/. /root
