" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Map ; to run PHP parser check
noremap ; :w!<CR>:!php -l %<CR>:!phpcs %<CR>

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.

highlight diffAdded guifg=#00bf00
highlight diffRemoved guifg=#bf0000

set lazyredraw

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

if has("iconv")
   autocmd FileType php call EditUTF8()
   autocmd FileType htm call EditUTF8()
   autocmd FileType html call EditUTF8()
   autocmd FileType xhtml call EditUTF8()
   autocmd FileType javascript call EditUTF8()
   autocmd FileType css call EditUTF8()
   autocmd FileType perl call EditUTF8()
   autocmd FileType xml call EditUTF8()
   autocmd FileType smarty call EditUTF8()
endif

function EditUTF8()
  set encoding=utf-8
  set enc=utf-8
  set termencoding=utf-8
  set fileencoding=utf-8
endfunction

function EditBig5()
  set encoding=latin1
  set termencoding=
  set fileencoding=
endfunction

set background=dark

set sw=4 
set ts=4 
set sts=4
set expandtab

map <F8> :cprev<return>
map <F11> :call EditUTF8()<return>
map <F12> :call EditBig5()<return>

map <F3> oecho "<pre>";print_r($);exit;<ESC>F$a
