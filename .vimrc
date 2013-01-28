""""" General Vim settings

" Make Vim behave in a more useful way.
set nocompatible

" Use visual bell instead of beeping
set visualbell

" Change directory to place swap files in
set dir=~/.vim/swp

""""" Text Formatting

" Allow backspacing over everything
set backspace=indent,eol,start

" Vim Tip #1274 - Highlight trailing whitespace characters
set list

set listchars=tab:->,trail:·

""""" Searching

" Incremental search, shows the nearest match while typing a search command.
set incsearch

"
set hlsearch

" Searches don't wrap around the end of the file
set nowrapscan

""""" Editing area

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=3

" The minimal number of screen columns to keep to the left and to the right of
" the cursor
set sidescrolloff=5

""""" Vim appearance

" Enable syntax highlighting with 256 color support so we
" can use nicer color schemes.
set t_Co=256

" Color scheme
colorscheme desert

" Show (partial) command in the last line of the screen.
set showcmd

" Show the line and column number of the cursor position, separated by a
" comma.
set ruler

" The last window will always have a status line.
set laststatus=2

" Smoother redraws
set ttyfast

" Do not redraw while running macros
set lazyredraw

""""" Syntax highlighting

" Switches on syntax highlighting.
syntax enable

" Autoload Doxygen highlighting
let g:load_doxygen_syntax=1

""""" File type detection

" Enable file type detection
filetype on

" Enable loading the plugin files for specific file types.
filetype plugin on

" Enable loading the indent file for specific file types.
filetype indent on

let c_syntax_for_h=""

""""" Cmdline completion

set suffixes-=.h
set suffixes+=.svn,.d
"
set wildmenu

"Complete longest common string, then each full match
set wildmode=longest:full,list:full

""""" Cscope integration
set nocscopetag

if has("cscope")
    set nocscopeverbose
    " add any database in current directory
    if filereadable("cscope.out")
        cscope add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cscope add $CSCOPE_DB
    endif
    set cscopeverbose
endif

"grepprg=grep -n $* /dev/null
set grepprg=grep\ --exclude-dir=\".svn\"\ -nH\ $*\ /dev/null
