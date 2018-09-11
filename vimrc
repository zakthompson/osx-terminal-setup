" Set standard file encoding
set encoding=utf8

" No special per file vim override configs
set nomodeline

" Stop word wrapping
set nowrap

" Except... on Markdown. That's good stuff.
autocmd FileType markdown setlocal wrap

" Adjust system undo levels
set undolevels=100

" Use system clipboard
set clipboard=unnamed

" Set tab width and convert tabs to spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Don't let Vim hide characters or make loud dings
set conceallevel=1
set noerrorbells

" Number gutter
set number

" Use search highlighting
set hlsearch

" Space above/beside cursor from screen edges
set scrolloff=1
set sidescrolloff=5

" Disable mouse support
set mouse=r
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Resize panes with arrow keys
nnoremap <Left> :vertical resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Up> :resize -1<CR>
nnoremap <Down> :resize +1<CR>

" Disable arrow keys completely in Insert Mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Double leader to switch to previous buffer
nmap <Leader><Leader> <c-^>

" Use tab to naturally switch between buffers
nnoremap <Tab> :bnext!<CR>
nnoremap <S-Tab> :bprev!<CR><Paste>

" Highlight matching parentheses
highlight MatchParen ctermbg=4

" Create blank newlines and stay in normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Split navigation
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'shougo/denite.nvim'
Plug 'tpope/vim-repeat'
Plug 'dracula/vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'mhinz/vim-grepper'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'w0rp/ale'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
call plug#end()

" Set color
color Dracula

" Configure airline (bottom bar)
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
set laststatus=2

" CtrlP config
nnoremap <silent> <c-p> :CtrlP<CR>

" Shortcuts for Grepper
nnoremap <Leader>fp :Grepper<Space>-query<Space>
nnoremap <Leader>fb :Grepper<Space>-buffers<Space>-query<Space>-<Space>

" Configure deoplete (autocompletion)
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Sneak config (easier jumping through lines)
let g:sneak#s_next = 1
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

" Ale config (linting)
let g:ale_linters={
\ 'javascript': ['eslint'],
\}
let g:ale_linters_explicit=1

" JavaScript settings
augroup javascript_folding
  au!
  au FileType javascript setlocal foldmethod=syntax
  au FileType javascript setlocal conceallevel=1
augroup END

" Remove trailing whitespace
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
