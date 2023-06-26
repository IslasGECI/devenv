FROM islasgeci/base:latest

# Install Nix package manager
ENV PATH="/root/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
RUN git clone https://github.com/IslasGECI/pde.git /root/pde && \
    cp /root/pde/flake.nix /workdir/flake.nix
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
    r-base \
    ripgrep \
    snapd \
    tmux \
    universal-ctags \
    wget \
        && \
    apt clean

# Instala modulos con pip
RUN pip install --upgrade pip && pip install \
    black \
    flake8 \
    ipython \
    mutmut \
    pylint \
    pytest \
    rope

# Instala paquetes de R
RUN Rscript -e "install.packages('languageserver', repos='http://cran.rstudio.com')"

# Install Neovim configuration
RUN mkdir --parents /root/.config && \
    git clone https://github.com/nvim-lua/kickstart.nvim.git /root/.config/nvim && \
    echo 'require("vimrc")' >> /root/.config/nvim/init.lua
RUN cp --force --recursive /root/pde/dotfiles/. /root

CMD ["nix", "develop", "'github:IslasGECI/pde'"]
