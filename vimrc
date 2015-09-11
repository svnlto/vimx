set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

" Editing
Plugin 'matchit.zip'
Plugin 'repeat.vim'
Plugin 'surround.vim'
Plugin 'vim-indent-object'
Plugin 'scrooloose/syntastic'

" File explore
Plugin 'The-NERD-Commenter'
Plugin 'The-NERD-tree'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'

" Auto complete
Plugin 'ervandew/supertab'

" Colorscheme
Plugin 'svnlto/vim-svnlto'

" Syntax Highlight
Plugin 'colorizer'

" Programming
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'

" Others
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'sjl/vitality.vim'
Plugin 'jordwalke/VimSplitBalancer'
Plugin 'matze/vim-move'
Plugin 'mxw/vim-jsx'
Plugin 'moll/vim-node'
Plugin 'editorconfig-vim'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'flazz/vim-colorschemes'
Plugin 'chriskempson/base16-vim'
Plugin 'godlygeek/csapprox'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'ack.vim'
Plugin 'matchparenpp'
Plugin 'tpope/vim-surround'
Plugin 'Townk/vim-autoclose'
Plugin 'isRuslan/vim-es6'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'


filetype plugin indent on     " required!
"
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install (update) bundles
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.

syntax on
syntax enable
set so=10
set ruler
set number
set hidden
set nowrap
set autoread
set clipboard=unnamed
set wildignore=*.o,*~,*.pyc
set backspace=eol,start,indent
set iskeyword+=-
set encoding=utf8
set ffs=unix,dos,mac
set laststatus=2
set colorcolumn=80
behave mswin

" Turn backup off, since most stuff is in SVN, git etc.
set nowb
set nobackup
set noswapfile

" No annoying sound on errors
set noerrorbells
set visualbell
set t_vb=
set tm=500

set ignorecase
set smartcase
set hlsearch
set incsearch
let loaded_matchparen = 1 " disable math parenthiese

set expandtab
set smarttab
set smartindent
set shiftwidth=2
set tabstop=2

noremap ; :
noremap 0 ^
noremap <space> $
noremap Y y$

" Treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk

" Smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Smart way to manage tabs
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>
nnoremap tm :tabmove<CR>
nnoremap to :tabonly<CR>

let mapleader = ","
nnoremap <leader>hs :noh<CR>

" edit and reload vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

autocmd! bufwritepost vimrc source %
map <leader>pp :setlocal paste!<cr>
map <leader>ss :setlocal spell!<cr>

set guifont=Hack:h11
set t_Co=256
set background=dark
colorscheme svnlto


" plugin settings
let g:NERDTreeChDirMode=2
map tt :NERDTreeToggle<CR>
map ff :NERDTreeFind<CR>

autocmd VimEnter * call StartUp()
autocmd VimEnter * wincmd p

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'tmp$\|\.git$\|\.hg$\|\.svn$\|\.rvm$\|vendor$'
let g:ctrlp_tabpage_position = 'a'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_files = 0

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_javascript_checkers = ['eslint', 'standard']
let g:syntastic_check_on_wq = 0

" remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

behave mswin

nmap <leader>l :set list!<CR>

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction


if has("gui_running") " all this for gui use
  " ugly MacVim Cruft
  set guioptions-=r "remove scrollbars
  set guioptions-=R "remove scrollbars
  set guioptions-=l "remove scrollbars
  set guioptions-=L "remove scrollbars
  set guioptions-=T " Remove toolbars

  "========== Mac OS X ==================================
  " Pro Tips:
  " Make sure to turn off anti-aliasing in general preferences panel.
  if has("gui_macvim")
    " Don't remove tabs on MacVim because VimGUITabs plugin makes them get out
    " of the way when we want them to get out of the way (in full screen mode).
    " set guioptions-=e
    " set guifont=Menlo:h12.00
    " like A CSS Reset:
    let macvim_skip_colorscheme = 1
    set transparency=0
    set fuoptions=maxvert,maxhorz
  endif
endif

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

function! StartUp()
  execute 'NERDTree' getcwd()
endfunction


" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>
" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

