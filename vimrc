" Set standard file encoding
set encoding=utf8

" No special per file vim override configs
set nomodeline

" Highlight current line
set cursorline

" Up and down more logical with g
nnoremap <silent> k gk
nnoremap <silent> j gj

" Adjust system undo levels
set undolevels=100

" Better search
set ignorecase
set smartcase

" Use system clipboard
set clipboard=unnamed

" Set tab width and convert tabs to spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Prevent vim from making loud dings
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
" nnoremap <Tab> :bnext!<CR>
" nnoremap <S-Tab> :bprev!<CR><Paste>

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
Plug 'arcticicestudio/nord-vim'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'mhinz/vim-grepper'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'cohama/lexima.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
call plug#end()

" Set color
let g:nord_italic = 1
let g:nord_underline = 1
colorscheme nord

" IndentLine settings
let g:indentLine_enabled = 1
let g:indentLine_char = "|"
let g:indentLine_conceallevel = 1

" Configure airline (bottom bar)
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
set laststatus=2

" CtrlP config
nnoremap <silent> <c-p> :CtrlP<CR>
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

" Shortcuts for Grepper
nnoremap <Leader>fp :Grepper<Space>-query<Space>
nnoremap <Leader>fb :Grepper<Space>-buffers<Space>-query<Space>-<Space>

" Sneak config (easier jumping through lines)
let g:sneak#s_next = 1
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

" JavaScript settings
augroup javascript_folding
  au!
  au FileType javascript setlocal foldmethod=syntax
  au FileType javascript setlocal conceallevel=1
augroup END

" Remove trailing whitespace
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Comment settings
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

" === Coc Config ===
set nobackup
set nowritebackup
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
