FROM islasgeci/base:latest
WORKDIR /workdir
COPY src /install_scripts

# Define variables de entorno
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.local/lib/shellspec:/workdir/src:$PATH"
ENV PYTHONIOENCODING=utf-8
ENV QT_QPA_PLATFORM=offscreen
ENV TZ=US/Pacific

# Instala paquetes en el sistema operativo
RUN apt update && apt full-upgrade --yes && apt install --yes \
    build-essential \
    curl \
    exa \
    fd-find \
    git \
    golang-go \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    neofetch \
    npm \
    pip \
    r-base \
    ripgrep \
    shellcheck \
    tmux \
    universal-ctags \
    wget

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

# Instala modulos con npm
RUN npm install --global \
    pyright

# Instala paquetes de R
RUN Rscript -e "install.packages('languageserver', repos='http://cran.rstudio.com')"

# Inslalaciones ad-hoc:
## Instala ShellSpec
RUN curl \
    --fail \
    --location https://git.io/shellspec \
    --show-error \
    --silent \
    | sh -s -- --yes
RUN shellspec --init

## Instala Neovim
RUN /install_scripts/install_neovim.sh

## Instala lazygit
RUN /install_scripts/install_lazygit.sh

# Importa archivos de configuración
RUN mkdir --parents ${HOME}/repositorios && \
    git clone --bare https://github.com/devarops/dotfiles.git ${HOME}/repositorios/dotfiles.git && \
    git --git-dir=${HOME}/repositorios/dotfiles.git --work-tree=${HOME} checkout && \
    git --git-dir=${HOME}/repositorios/dotfiles.git --work-tree=${HOME} config --local status.showUntrackedFiles no
