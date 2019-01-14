let mapleader = "\<Space>"
set nocompatible              " required
filetype off                  " required 
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

Plugin 'easymotion/vim-easymotion'



Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"Plugin 'shougo/deoplete.nvim'
" Use deoplete.
"let g:deoplete#enable_at_startup = 1
Plugin 'jnurmine/Zenburn'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8' " python auto format
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'tell-k/vim-autopep8'
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR> 
Plugin 'kchmck/vim-coffee-script'
Plugin 'w0rp/ale' " asyncronus lint engine
let g:ale_echo_cursor = 0 " ale hides the cursor on lines with errors??
Plugin 'rking/ag.vim'

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'rc' " project root or current file

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] " ignore everythin in git ignore

" easytags
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'

"Plugin 'rust-lang/rust.vim'
"Plugin 'wilsaj/chuck.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

colorscheme zenburn
syntax on
set nu
set ic " ignore case in search
set hls is "real time search hiligt
set autoindent
set smartindent "?
set nocp
filetype plugin indent on

" 2 spaces always
set expandtab
set shiftwidth=2
set softtabstop=2

" gems.tags is a tags file
set tags+=gems.tags

set undofile                " Save undos after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


map <Left> :bp <Return>
map <Right> :bn <Return>

map <Up> :cp <Return>
map <Down> :cn <Return>

" leave buffer without saving
set hidden

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
"nnoremap <space> za

au BufNewFile,BufRead *.py
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
    \ let python_highlight_all=1

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
set encoding=utf-8


"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF


" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

"call AutoHighlightToggle()

" grep for current word
au BufNewFile,BufRead *.rb
    \ nnoremap f/ :vimgrep <cword> **/* <cr>
" silver searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" wild menu
" http://vimdoc.sourceforge.net/htmldoc/options.html#'wildmenu'
set wildmenu
set wildignore+=.git,.node_modules,*/tmp/*,*.so,*.swp,*.zip
set wildmode=full

