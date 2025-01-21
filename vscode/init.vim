" Definir tecla leader
let mapleader = " "

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

" Shortcuts for split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Remap delete to black hole register
nnoremap D "_dd

" Redo
nnoremap U <C-R>
