" ### INÍCIO: Plugin Manager ###
call plug#begin()
    " Gerenciamento de temas
    Plug 'loctvl842/monokai-pro.nvim'
    Plug 'catppuccin/nvim'
    Plug 'daltonmenezes/aura-theme', { 'rtp': 'packages/neovim' }
    Plug 'nvim-tree/nvim-web-devicons'      " Ícones  melhores

    " Plugins de funcionalidades
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Coloração avançada
    Plug 'm4xshen/autoclose.nvim'           " Autocompleta parênteses, colchetes, etc.
    Plug 'utilyre/barbecue.nvim'            " Auxiliar de POO, barra de classes
    Plug 'rcarriga/nvim-notify'             " Notificações
    Plug 'SmiteshP/nvim-navic'              " Lualine dependencia
    Plug 'nvim-lualine/lualine.nvim'        " Status bar melhor
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
    Plug 'github/copilot.vim'               " Github Copilot
    Plug 'nvimtools/none-ls.nvim'           " Auxiliar formatador 
    Plug 'lukas-reineke/indent-blankline.nvim' " Identação de linhas em branco
    Plug 'jose-elias-alvarez/typescript.nvim' " Suporte a TypeScript
    Plug 'prisma/vim-prisma'                  " Suporte a Prisma ORM (Node.JS)
    Plug 'jose-elias-alvarez/null-ls.nvim'    " Suporte a funcionalidades externas

    " Plugin Gerenciador de Tempo
    Plug 'wakatime/vim-wakatime'

    " Plugin de navegação de arquivos 
    Plug 'nvim-tree/nvim-tree.lua'          " Navegador de arquivos
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

" Definir tecla leader
let mapleader = " "

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

" Map pra adicionar linha abaixo sem abrir modo inserção
nnoremap O o<Esc>k
nnoremap t ko

" Map pra abrir modo de inserção e identar automaticament
nnoremap <Tab> i<Tab>

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

" ### CARREGAR CONFIG LUA ############"
lua require('init')

" ### INÍCIO: Configurações Globais ###
" Configura a fonte para JetBrains Mono com tamanho 12px
set guifont=Hack\ Nerd\ Font:h12

" TEMA USADO NO NEOVIM
"colorscheme catppuccin-macchiato

" Ajusta a escala da interface para 1.2
"let g:neovide_scale_factor = 1.2

filetype on          " Detect and set the file type option and trigger the FileType Event
filetype plugin on   " Load the plugin file for the file type, if any
filetype indent on   " Load the indent file for the file type, if any
set termguicolors
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
" ### FIM: Configurações Globais ###

" Set the *.blade.php file to be filetype of blade 
augroup BladeFiltypeRelated
  au BufNewFile,BufRead *.blade.php set ft=blade
augroup END

augroup web_indent
    autocmd!
    autocmd FileType vue,json,javascript,typescript,tsx,jsx,blade setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
augroup END

" ### INICIO: Treesitter pra laravel blade ###
lua <<EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.blade = {
  install_info = {
    url = "https://github.com/EmranMR/tree-sitter-blade",
    files = {"src/parser.c"},
    branch = "main",
  },
  filetype = "blade"
}
EOF
