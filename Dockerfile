FROM islasgeci/base:latest

# Define variables de entorno
ENV PATH="/workdir/src:$PATH"

# Install Nix package manager
COPY flake.nix /workdir/flake.nix
RUN curl -L https://nixos.org/nix/install | sh -s -- --daemon && \
    echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf && \
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && \
    nix develop --command neofetch

# Instala paquetes en el sistema operativo
RUN apt update && apt full-upgrade --yes && apt install --yes \
    build-essential \
    exa \
    fd-find \
    pip \
    pipx \
    r-base \
    ripgrep \
    shellcheck \
    snapd \
    tmux \
    universal-ctags \
    wget \
        && \
    apt clean

# Instala modulos con pip
RUN pip install --upgrade pip && pip install \
    black \
    dunk \
    flake8 \
    ipython \
    mutmut \
    powerline-shell \
    pylint \
    pytest \
    rope

# Install Node
ENV NODE_VERSION=18.12.1
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
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

# Inslalaciones ad-hoc:
COPY src /install_scripts
## Instala paquetes con pipx
RUN /install_scripts/install_pipx_packages.sh

# Install Neovim configuration
RUN mkdir --parents /root/.config && \
    git clone https://github.com/nvim-lua/kickstart.nvim.git /root/.config/nvim && \
    echo 'require("vimrc")' >> /root/.config/nvim/init.lua
COPY dotfiles /root
