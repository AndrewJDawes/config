" COMPATIBILITY
set nocompatible " Use vim commands over vi commands on conflict

" ENCODING
set fileencoding=utf-8 " Used when writing to a file
set encoding=utf-8 " Used when reading a file

" SHELL
" set shellcmdflag=-ic  "Run any shell commands in interactive mode so .bashrc is sourced

" PATHOGEN
execute pathogen#infect()

" FILETYPES
filetype on " Recognize file types.
filetype indent on
filetype plugin on

" SYNTAX HIGHLIGHTING
syntax on
" set showmatch  "Highlight closing/opening brackets when cursor over

" PROCESS
" set noswapfile  "If you want to disable swapfile vim keeps in home directory

" INDENTATION
set autoindent
set smartindent     " Automatically indent lines as you type

" TABS/SPACES/WHITESPACE
"set list
set nolist " Do not display whitespace literals
set listchars=tab:▸\ ,eol:↵
set expandtab       " Turn TABs into spaces when you type
set softtabstop=4   " Sets the number of columns to be used when you hit the TAB key in INSERT mode
set shiftwidth=4    " Sets the number of columns to be used when you use the >> indent commands
set tabstop=4       " While reading, sets the width of any actual TAB characters

" BACKSPACE FIX
set backspace=indent,eol,start " Fix to allow you to backspace.

" LINE NUMBERS
set number

" WARNINGS
set visualbell " Disable any audible warning

" CURSOR
set cursorline

" WINDOW SIZING
" set winwidth=84
" set winheight=5
" set winminheight=5
" set winheight=999

" COLUMN HIGHLIGHTING
" set cc=80  "Highlights column 80

" SEARCH
set incsearch
silent set highlight " Highlight found searches. Running with silent because was requiring ENTER on opening vim.
" set ignorecase
" set smartcase  "Only case sensitive if you use a capital letter
" set gdefault  "Global replacement by default

" FOLDS
set foldmethod=syntax         " Enable syntax-based folding

" By default, all folds are closed.
" You cannot set foldlevelstart=0. This will error.
" set foldlevelstart=1 " Start file with all folds closed except first fold.
set foldlevelstart=99 " Start file with all folds open.

set foldcolumn=1 "defines 1 col at window left, to indicate folding

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

" LEADER CHARACTER
let mapleader=","

" MAPPING
"imap <Tab> <C-n>
"imap <S-Tab> <C-p>
