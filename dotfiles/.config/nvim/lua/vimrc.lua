vim.cmd([[
    colorscheme evening
    highlight ColorColumn ctermbg=238
    MasonInstall docker-compose-language-service
    MasonInstall dockerfile-language-server
    MasonInstall python-lsp-server
    MasonInstall r-languageserver
    set colorcolumn=100,120
    set cursorline
    set hlsearch
    set number
    syntax on
]])
