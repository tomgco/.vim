set nocompatible
execute pathogen#infect()

let base16colorspace=256
set t_Co=256

"Omni stuff
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Ternjs
let g:tern_show_argument_hints='on_hold'
let g:tern_show_signature_in_pum=1

" Linting
 " let g:syntastic_javascript_checkers = ['jshint', 'jscs', 'eslint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_check_on_open = 1
let g:syntastic_javascript_eslint_conf = '$HOME/.eslintrc'

"NERDTree
let g:NERDTreeShowHidden=1

set laststatus=2

set statusline=
set statusline+=%n\ %f\ %2*%m\ %1*%h
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%r%=[%{&encoding}\ %{&fileformat}\ %{strlen(&ft)?&ft:'none'}]\ %12.(%c:%l/%L%)

set tabstop=2
set shiftwidth=2
set autoindent
set expandtab


set ruler
set number
set relativenumber
set colorcolumn=80

set list
set spell
set linespace=1
set visualbell
set nobackup
set mouse=a
" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" With a map leader it's possible to do extra key combinations
let mapleader = ","
let g:mapleader = ","

set listchars=tab:▸\ ,trail:☠

" Fast saving
nmap <leader>w :w!<cr>

" Taglist toggle
" nmap <leader>n :TlistToggle<cr>

" Remove mixed line endings
" nmap <leader>= :%s/\s*$//e<cr>:nohl<cr>


" Git shortcuts
"nmap <leader>l :Glog<cr>
"nmap <leader>b :Gblame<cr>
"nmap <leader>a :Gwrite<cr>
"nmap <leader>c :Gcommit<cr>
"nmap <leader>d :Gdiff<cr>
"nmap <leader>s :Gstatus<cr>
"nmap <leader>f :!open .<cr><cr>

nmap <leader>o :edit <c-r>=expand("%:p:h")<cr><cr>

"set undofile
"set undodir=~/.vim.undo
"set undolevels=1000
"set undoreload=10000


" Fast editing for config files
map <leader>e :tabedit! ~/.vim/vimrc<cr>
map <leader>z :tabedit! ~/.zshrc<cr>

" add json syntax highlighting
"au BufNewFile,BufRead *.json set ft=javascript

" add c++ highlighting to arduino projects
au BufNewFile,BufRead *.pde set ft=arduino

autocmd! FileType javascript nmap <leader>m :!node --debug %<cr>
autocmd! FileType vim nmap <c-m>:source %<cr>
autocmd! BufWrite *.php,*.js,*.coffee :%s/\s\+$//e
autocmd! BufWrite *.jade :%s/^\s\+$//e

"set hidden

" Buffer navigation
map <leader>l :ls<cr>:b<space>
map <leader>q :bd!<cr>
map <leader>] :bn<cr>
map <leader>[ :bp<cr>

" Git 
" map <leader>c :Gwrite<cr>:Gcommit<cr>

" Stop arrow keys
" nmap <up> <nop>
" nmap <right> <nop>
" nmap <left> <nop>
" nmap <down> <nop>

" Moving lines up and down
"
" Bubble single lines
nmap <c-k> ddkP
nmap <c-j> ddp
" Bubble multiple lines
vmap <c-j> xkP`[V`]
vmap <c-k> xp`[V`]

" Highlight tailing whitespace
highlight ExtraWhitespace guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Switch off folding
"set nofoldenable

map <C-\> :tnext<CR>

let NERDTreeShowHidden=1

" Command-/ to toggle comments
map <C-/> <plug>NERDCommenterToggle
imap <C-/> <Esc><plug>NERDCommenterToggle<CR>i

syntax enable
set background=dark
colorscheme base16-eighties

filetype plugin on

" When vimrc is edited, reload it
autocmd! BufWritePost vimrc source ~/.vim/vimrc
