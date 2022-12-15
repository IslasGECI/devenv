FROM islasgeci/base:latest
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

# Instala modulos con snap
RUN service snapd start
RUN snap install node --classic

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

# Importa archivos de configuración
RUN mkdir --parents ${HOME}/repositorios && \
    git clone --bare https://github.com/devarops/dotfiles.git ${HOME}/repositorios/dotfiles.git && \
    git --git-dir=${HOME}/repositorios/dotfiles.git --work-tree=${HOME} checkout && \
    git --git-dir=${HOME}/repositorios/dotfiles.git --work-tree=${HOME} config --local status.showUntrackedFiles no
