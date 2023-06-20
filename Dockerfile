FROM islasgeci/base:latest
COPY dotfiles /root
COPY src /install_scripts

# Define variables de entorno
ENV PATH="/workdir/src:$PATH"

# Instala paquetes en el sistema operativo
RUN apt update && apt full-upgrade --yes && apt install --yes \
    build-essential \
    exa \
    fd-find \
    golang-go \
    neofetch \
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
## Instala lazygit
RUN /install_scripts/install_lazygit.sh
## Instala Neovim
RUN /install_scripts/install_neovim.sh
## Instala paquetes con pipx
RUN /install_scripts/install_pipx_packages.sh
