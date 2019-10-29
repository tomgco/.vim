call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe', { 'do': '(./install.py --rust-completer --go-completer --js-completer && sh -c ''cd third_party/ycmd/third_party/tern_runtime && yarn install --production'')' }
Plug 'airblade/vim-gitgutter'
function FixupBase16(info)
    !sed -i '/Base16hi/\! s/a:\(attr\|guisp\)/l:\1/g' ~/.vim/plugged/base16-vim/colors/*.vim
endfunction
Plug 'chriskempson/base16-vim', { 'do': function('FixupBase16') }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'moll/vim-node'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'vim-scripts/JavaScript-Indent'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
" Plug 'scrooloose/syntastic'
Plug 'timcharper/textile.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tsaleh/vim-align'
Plug 'stephpy/vim-yaml'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'hashivim/vim-terraform'
Plug 'dense-analysis/ale'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'peitalin/vim-jsx-typescript'

call plug#end()

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
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
" let g:syntastic_javascript_checkers = ['jshint', 'eslint']
"let g:syntastic_javascript_checkers = ['semistandard']
"let g:syntastic_check_on_open = 0
" let g:syntastic_debug = 3
"let g:syntastic_javascript_eslint_conf = '$HOME/.eslintrc'
"

" ale
" \   'javascript': ['prettier'],
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'json': ['prettier'],
\   'typescript': ['eslint'],
\}
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tsserver', 'eslint'],
\}
let g:ale_typescript_tslint_use_global = 0
let g:ale_typescript_tslint_config_path = ''
let g:ale_linters_ignore = {'typescript': ['tslint']}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_lint_delay = 200
let g:ale_sign_error = '✖' " looks nicer than the default >>
let g:ale_sign_warning = '⚑'
let g:ale_lint_on_insert_leave = 1
let g:ale_set_highlights = 0


let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|public$|log\|tmp\|target$\|coverage\|node_modules$',
    \ 'file': '\.so$\|\.dat$|\.DS_Store$|\.log$|\.tar.gz$|.zip$|.swp$|\.lock$'
    \ }

set emoji
set laststatus=2
set statusline=
set statusline+=%n\ %f\ %2*%m\ %1*%h
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%r%=[%{&encoding}\ %{&fileformat}\ %{strlen(&ft)?&ft:'none'}]\ %12.(%c:%l/%L%)

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" add c++ highlighting to arduino projects
au BufNewFile,BufRead *.pde set ft=arduino

autocmd! FileType javascript nmap <leader>m :!node --debug %<cr>
autocmd! FileType vim nmap <c-m>:source %<cr>
autocmd! BufWrite *.php,*.js,*.coffee :%s/\s\+$//e
autocmd! BufWrite *.jade :%s/^\s\+$//e

" Buffer navigation
map <leader>l :ls<cr>:b<space>
map <leader>q :bd!<cr>
map <leader>] :bn<cr>
map <leader>[ :bp<cr>

" Highlight tailing whitespace
highlight ExtraWhitespace guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Switch off folding
"set nofoldenable

" NERDTree
let NERDTreeShowHidden=1
let g:NERDTreeShowHidden=1
let g:NERDTreeDirArrows=0

" Command-/ to toggle comments
map <C-/> <plug>NERDCommenterToggle
imap <C-/> <Esc><plug>NERDCommenterToggle<CR>i

syntax enable
" set background=dark
" colorscheme base16-eighties

filetype plugin on
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1,
      \ 'dos' : 1,
      \}

" When vimrc is edited, reload it
autocmd! BufWritePost vimrc source ~/.vim/vimrc

"Indent Fixes issues with utf-8 buffer errors on chrome book.
let g:indentLine_char = '|'
set autoindent
set tabstop=2 "Usually 2 but TSL
set shiftwidth=2 "Usually 2 but TSL
set synmaxcol=200

" Handle formatting for GO lang
autocmd Filetype go setlocal ts=2 sts=2 sw=2 noexpandtab
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype json setlocal ts=2 sts=2 sw=2 expandtab

" set foldmethod=syntax
" set foldnestmax=4
" set foldminlines=3
" set foldlevel=1

set ruler
set number
set relativenumber
set colorcolumn=80
set textwidth=0 " Do not wrap lines.
set nowrap
set expandtab
set clipboard=unnamed
set list
set listchars=tab:▸\ ,eol:$
" set spell
set linespace=1
set visualbell
set nobackup
set mouse=a
" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase


" Open NERDTree on open
autocmd VimEnter * NERDTree | wincmd p
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction
