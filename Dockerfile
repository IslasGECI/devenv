FROM ubuntu:22.04
WORKDIR /workdir
COPY . .

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
    git \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    neofetch \
    npm \
    pip \
    r-base \
    ripgrep \
    tmux \
    universal-ctags

# Use Python 3 as the default version of Python
RUN ln --symbolic /usr/bin/python3 /usr/bin/python

# Instala modulos con pip
RUN pip install --upgrade pip && pip install \
    black \
    flake8 \
    ipython \
    mutmut \
    powerline-shell \
    pylint \
    pytest \
    rope

# Instala modulos con pip
RUN npm install --global \
    pyright

# Instala paquetes de R
RUN Rscript -e "install.packages('languageserver', repos='http://cran.rstudio.com')"

# Instala ShellSpec
RUN curl \
    --fail \
    --location https://git.io/shellspec \
    --show-error \
    --silent \
    | sh -s -- --yes
RUN shellspec --init

# Instala Neovim
RUN curl --output $HOME/nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage && \
    chmod u+x $HOME/nvim.appimage && \
    $HOME/nvim.appimage --appimage-extract && \
    ln --symbolic $HOME/squashfs-root/usr/bin/nvim /usr/bin/nvim

# Importa archivos de configuración
RUN mkdir --parents ${HOME}/repositorios && \
    git clone --bare https://github.com/devarops/dotfiles.git ${HOME}/repositorios/dotfiles.git && \
    git --git-dir=${HOME}/repositorios/dotfiles.git --work-tree=${HOME} checkout && \
    git --git-dir=${HOME}/repositorios/dotfiles.git --work-tree=${HOME} config --local status.showUntrackedFiles no
