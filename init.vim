" ### INÍCIO: Plugin Manager ###
call plug#begin()
    " Gerenciamento de temas
    Plug 'loctvl842/monokai-pro.nvim'
    Plug 'daltonmenezes/aura-theme', { 'rtp': 'packages/neovim' }

    " Plugins de funcionalidades
    Plug 'm4xshen/autoclose.nvim'           " Autocompleta parênteses, colchetes, etc.

    " Plugin de navegação de arquivos 
    Plug 'nvim-tree/nvim-tree.lua'          " Navegador de arquivos
    Plug 'nvim-tree/nvim-web-devicons'      " Ícones pro nvim-tree
    Plug 'vim-airline/vim-airline'          " Status bar
    Plug 'ryanoasis/vim-devicons'           " Ícones para arquivos e pastas
    Plug 'sheerun/vim-polyglot'             " Suporte a múltiplas linguagens
    Plug 'terrortylor/nvim-comment'         " Comentários rápidos

    " Plugins para busca
    Plug 'nvim-telescope/telescope.nvim'    " Busca avançada
    Plug 'nvim-lua/plenary.nvim'            " Dependência para o Telescope

    " Plugins de autocompletar
    Plug 'neovim/nvim-lspconfig'            " Suporte a LSP (Language Server Protocol)
    Plug 'hrsh7th/cmp-nvim-lsp'             " Integração entre o LSP e o completador
    Plug 'hrsh7th/cmp-buffer'               " Sugestões com base no buffer atual
    Plug 'hrsh7th/cmp-path'                 " Sugestões de caminhos de arquivos
    Plug 'hrsh7th/cmp-cmdline'              " Sugestões no modo de comando
    Plug 'hrsh7th/nvim-cmp'                 " Completador principal
    Plug 'petertriho/cmp-git'               " Sugestões para Git

    " Plugin de terminal embutido
    Plug 'akinsho/toggleterm.nvim'

    " Plugin de snippets
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'

    " Plugin de formatação
    Plug 'stevearc/conform.nvim'
call plug#end()
" ### FIM: Plugin Manager ###

" ### INÍCIO: Mapeamento de Teclas ###
" Configuração do nvim-tree
nmap <C-a>     :NvimTreeToggle<CR>  " Abre/fecha o Nvim-Tree
nmap <leader>r :NvimTreeRefresh<CR> " Atualiza o Nvim-Tree
nmap <leader>n :NvimTreeFindFile<CR> " Localiza o arquivo atual na árvore

" Ajustar tamanho de splits (horizontal)
nnoremap <leader>k :resize -5<CR>
nnoremap <leader>j :resize +5<CR>

" Ajustar tamanho de vsplits (vertical)
nnoremap <leader>h :vertical resize -5<CR>
nnoremap <leader>l :vertical resize +5<CR>

" Definir tecla leader
let mapleader = "\\"

" Pra sair da busca atual
nnoremap <Esc> :noh<CR>

" Mover para o próximo buffer com Ctrl + l
nnoremap <S-l> :bnext<CR>

" Mover para o buffer anterior com Ctrl + h
nnoremap <S-h> :bprevious<CR>

" Fechar o buffer atual com Ctrl + w
nnoremap <S-w> :bd<CR>

" Salvar alterações com Ctrl + s
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a
vnoremap <C-s> <Esc>:w<CR>gv

" Find files using Telescope command-line sugar
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Shortcuts for split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Remap delete to black hole register
nnoremap D "_dd

" Redo
nnoremap U <C-R>
" ### FIM: Mapeamento de Teclas ###

" ### INÍCIO: Configurações Globais ###

" Configura a fonte para JetBrains Mono com tamanho 12px
set guifont=JetBrains\ Mono:h12
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" TEMA USADO NO NEOVIM
colorscheme aura-dark-soft-text

" Ajusta a escala da interface para 1.2
let g:neovide_scale_factor = 1.2
set cursorline       " Enable gutter
syntax on            " Enable syntax highlight
set nu               " Enable line numbers
set nowrap           " Disable line wrap
set tabstop=4        " Show existing tab with 4 spaces width
set softtabstop=4    " Show existing tab with 4 spaces width
set shiftwidth=4     " When indenting with '>', use 4 spaces width
set expandtab        " On pressing tab, insert 4 spaces
set smarttab         " insert tabs on the start of a line according to shiftwidth
set smartindent      " Automatically inserts one extra level of indentation in some cases
set hidden           " Hides the current buffer when a new file is opened
set incsearch        " Incremental search
set ignorecase       " Ignore case in search
set smartcase        " Consider case if there is an upper case character
set scrolloff=8      " Minimum number of lines to keep above and below the cursor
set colorcolumn=100  " Draws a line at the given line to keep aware of the line size
set signcolumn=yes   " Add a column on the left. Useful for linting
set cmdheight=2      " Give more space for displaying messages
set updatetime=100   " Time in milliseconds to consider the changes
set encoding=UTF-8   " The encoding should be utf-8 to activate the font icons
set nobackup         " No backup files
set nowritebackup    " No backup files
set splitright       " Create the vertical splits to the right
set splitbelow       " Create the horizontal splits below
set autoread         " Update vim after file update from outside
set mouse=a          " Enable mouse support
set relativenumber   " Enable vim relative number scroll
filetype on          " Detect and set the file type option and trigger the FileType Event
filetype plugin on   " Load the plugin file for the file type, if any
filetype indent on   " Load the indent file for the file type, if any

lua require('init')
" ### FIM: Configurações Globais ###
