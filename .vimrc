" Set the title of the window to 'titlestring' (filename by default)
set title

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set background=dark

" UTF-8 by default
set encoding=utf-8

" Tabs should be 2 spaces, always
set tabstop=2
set expandtab
set shiftwidth=2
set smarttab

" When inserting a bracket, quickly flash the matching one
set showmatch

" Show command info in the last line of the screen, e.g. the number of selected
" lines. Note this can cause some slowdown in terminal rendering
" <https://github.com/tpope/vim-sensible/issues/49>.
set showcmd

" Wrap at 78 characters
set textwidth=78
" Format options (see :help fo-table for full description):
" * c: Wrap comments at textwidth, inserting the comment leader
" * r: Insert comment leader when pressing enter in insert mode
" * o: Insert comment leader when pressing o in insert mode
" * q: Allow formatting of comments with gq
" * l: Lines that were already long aren't automatically reformatted in insert
"      mode
" * j: Remove a comment leader when joining lines
" See fo-table for a full description.
set formatoptions=croqlj

" Keep all matches for a search pattern highlighted
set hlsearch
" Show matches for a search pattern as it is typed
set incsearch
" Setting ignorecase+smartcase means searches are case-insensitive unless an
" upper case character is explicitly used.
set ignorecase
set smartcase

" Enable syntax highlighting
syntax enable

" Enable filetype detection and loading for filetype-specific plugins or
" indent files.
filetype on
filetype indent on
filetype plugin on

" When switching tabs, jump to the first open window or tab that contains the
" specified buffer.
set switchbuf=usetab

" Show possible command-line completion matches in a menu
set wildmenu
" When completing, first complete until the longest common string. Then display
" a list of all matches
set wildmode=longest,list

" Set buffers to hidden when abandoning them, rather than unloading
set hidden

" Enable use of the mouse in all modes
set mouse=a

" Navigate buffers using left and right arrows
nnoremap <silent> <Right> :bnext<CR>
nnoremap <silent> <Left> :bprev<CR>

" TODO: want a mapping to insert a non-expanded tab

" Always display a status line (useful for buftabs)
set laststatus=2

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

autocmd FileType markdown setlocal autoindent

" Ensure built-in shell syntax highlighting assumes a posix shell syntax.
let g:is_posix=1

" Shortcuts for moving lines up and down
nnoremap J :m+<CR>==
nnoremap K :m-2<CR>==
vnoremap J :m'>+<CR>gv=gv
vnoremap K :m-2<CR>gv=gv

" Shortcut for saving the current buffer
map <Esc><Esc> :w<CR>

noremap <silent> <C-j> :join<CR>

" My preferred colorscheme requires 256 colour support
if &t_Co >= 256
  colorscheme inkpot
endif

" Plugin-specific config:

" Configure fzf to use colours from my vim colorscheme.
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_layout = { 'up': '~40%' }

let mapleader=","
let $FZF_DEFAULT_OPTS="--reverse --inline-info --bind=tab:down,btab:up"

map <Leader>e :Files<CR>
map <Leader>b :Buffers<CR>
command! -bang Directories
  \ call fzf#run(fzf#wrap({'source': 'find * -type d'}))
map <Leader>d :Directories<CR>
map <Leader>l :BLines<CR>

" Prefer symmetric encryption for new .gpg files.
let g:GPGPreferSymmetric = 1

" Don't fold markdown documents by default.
let g:vim_markdown_folding_disabled = 1

let g:task_paper_date_format="%Y-%m-%d %H:%M"
