
""      Vim rc file.
""      Date: 26th October 2017

" Pre-plugin Settings
" ===================

" Evim Switch {{{

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" }}}
" Basic Settings {{{

set nocompatible                    " no compatibility with vi.
runtime! debian                     " for Debian-based systems.
filetype plugin indent on
syntax enable

" File Specific formatting
augroup textformatting
    autocmd FileType text  setlocal textwidth=78
    autocmd FileType latex setlocal textwidth=120 tabstop=2 expandtab
    autocmd FileType r     setlocal textwidth=80 tabstop=2 expandtab
    autocmd FileType html  setlocal textwidth=120 tabstop=2 expandtab
    autocmd FileType xml   setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
    autocmd FileType xml   setlocal tabstop=2 expandtab
augroup END

" Options
set ambiwidth=double                " double width characters.
set autoindent                      " enable autoindenting.
set autoread                        " autoupdate changes for file.
set background=dark                 " set background to dark.
set backspace=indent,eol,start      " allow backspace over these.
set breakindent                     " visually indent wrapped text.
set cursorline                      " highlight the line with the cursor.
set display="lastline"              " display lastline completely.
set encoding=utf-8                  " use utf-8 by default.
set foldlevelstart=4                " enable folding after four levels.
set foldmethod=syntax               " fold on syntactical structures.
set formatoptions="tcroqj"          " text formatting.
set guifont=Iosevka\ 10             " font for gvim.
set guiheadroom=0                   " fix extra white space.
set guioptions=aci"                 " options for the gui.
set hidden                          " enable hidden buffers.
set history=10000                   " lots of history.
set hlsearch                        " highlight search.
set incsearch                       " search as you type.
set langnoremap                     " something to do with menus.
set laststatus=2                    " always show status.
set linespace=1                     " line spacing for the gui.
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
                                    " characters to split lists.
set mouse=a                         " enable mouse use.
set nrformats="bin,hex"             " number formats.
set number                          " line numbers.
set ruler                           " show row and column in status.
set scrolloff=2                     " lines below and above the cursor.
set shiftwidth=0                    " use tabstop value for indenting.
set showcmd                         " show partial command.
set sidescrolloff=5                 " cols on the sides of the cursor
set smarttab                        " use shiftwidth for tabs.
set tabpagemax=50                   " number of tab pages.
set tags="./tags;,tags"             " (no idea what this does yet.)
set tabstop=4                       " width of a tab.
set termguicolors                   " more colors.
set ttyfast                         " I do talk fast.
set viminfo=!,'100,<50,s10,h        " stuff to save and restore.
set wildmenu                        " better command-line completion.

let &showbreak="> "                 " indicator for wrapped lines.
let g:tex_flavor = "latex"          " default assume latex.

" Setting path since pip and npm packages go into .local.
set path+=$HOME/.local/bin
set path+=$HOME/.bin

" Cursor copied from the sample showed in help.
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

" Load matchit.vim, but only if isn't a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" }}}


" Plugin Settings
" ===============

" vim-plug {{{

call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-plug'                    " For help and stuff.

" File management.
Plug 'scrooloose/nerdtree'                  " tree explorer.
Plug 'Xuyuanp/nerdtree-git-plugin'          " shows git status in NERDtree.
Plug 'ctrlpvim/ctrlp.vim'                   " fuzzy path finder.

" Git
Plug 'tpope/vim-fugitive'                   " git wrapper. (:G<git command>)
Plug 'airblade/vim-gitgutter'               " git status in gutter.

" Aesthetics
Plug 'vim-airline/vim-airline'              " status line for vim.
Plug 'vim-airline/vim-airline-themes'       " themes for airline.
Plug 'MaxSt/FlatColor'                      " awesome color theme.
Plug 'mhartington/oceanic-next'             " oceanic next color theme.
Plug 'rafi/awesome-vim-colorschemes'        " color schemes for the brave.

" Editing
Plug 'majutsushi/tagbar'                    " a tab with all tags (Woah!)
Plug 'simnalamburt/vim-mundo'               " display the vim undo tree.
Plug 'junegunn/goyo.vim'                    " distraction free mode.
Plug 'scrooloose/nerdcommenter'             " comment multiple lines.
Plug 'mileszs/ack.vim'                      " grep like search. (using ag)
Plug 'w0rp/ale'                             " asynchronous linting.
Plug 'cohama/lexima.vim'                    " auto-complete braces, etc. (Laziness 2.0)
Plug 'ajh17/VimCompletesMe'                 " light completion engine.

" Language specific.
Plug 'python-mode/python-mode'              " Python
Plug 'lervag/vimtex'                        " LaTeX
Plug 'octol/vim-cpp-enhanced-highlight'     " C++: improved colors through static file.
Plug 'pangloss/vim-javascript'              " JavaScript: improved indenting.
Plug 'sukima/xmledit'                       " XML

" Misc
Plug 'xolox/vim-misc'                       " for his other plugins.
Plug 'xolox/vim-notes'                      " note taking support.
Plug 'milkypostman/vim-togglelist'          " toggle location- and quickfix-list.

call plug#end()

" }}}
" Ack {{{

" Use the Silver Searcher instead of ack.
let g:ackprg = 'ag --vimgrep'
for command in ['Ack', 'AckAdd', 'AckFromSearch', 'LAck', 'LAckAdd', 'AckFile', 'AckHelp', 'LAckHelp', 'AckWindow', 'LAckWindow']
  exe 'command ' . substitute(command, 'Ack', 'Ag', "") . ' ' . command
endfor

" }}}
" Ale {{{
" Change the default messages to something more concise.
let g:ale_echo_msg_error_str = "[Err]"
let g:ale_echo_msg_info_str = "[Info]"
let g:ale_echo_msg_warning_str = "[Warn]"
let g:ale_echo_msg_format = "%severity% {%linter%} %code: %%s"
let g:ale_linters = {'python': ['flake8']}
let g:ale_set_highlights = 0
" }}}
" Awesome Vim Colorschemes {{{
colorscheme hybrid
" }}}
" CtrlP {{{

let g:ctrlp_switch_buffer = 'e'     " Switch to files only in this tab.
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" }}}
" Goyo {{{
let g:goyo_width = 120
let g:goyo_height = "90%"
let g:goyo_linenr = 1
" }}}
" NERD Commenter {{{

let g:NERDSpaceDelims = 1               " spaces after comment delim.
let g:NERDCompactSexyComs = 1           " compact prettified multi-line comments.
let g:NERDDefaultAlign = 'left'         " comment delims flush.
let g:NERDAltDelims_java = 1            " use alternate delims by default.
let g:NERDCommentEmptyLines = 1         " allow commenting empty lines.
let g:NERDTrimTrailingWhitespace = 1    " trim trailing whitespace for comments.

" Custom delimiters.
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" }}}
" NERD Tree {{{

" Autocommands in order:
"   1. Open NERDTree automatically starts up if no files are specified.
"   2. Open NERDTree automatically when vim starts up on opening a directory.
"   3. Close NERDTree if only window opened is NERDTree.
augroup nerdtree
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" NERDTree with Git.
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "⊙",
    \ "Staged"    : "✚",
    \ "Untracked" : "★",
    \ "Renamed"   : "↹",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Ignored"   : "⍘",
    \ "Unknown"   : "?"
    \ }

" }}}
" PyMode {{{

let g:pymode_python = 'python3'
let g:pymode_folding = 0
let g:pymode_rope_completion = 0

" }}}
" VimNotes {{{

let g:notes_suffix = '.note'
let g:notes_directories = ['~/Documents/Notes/Vim-Notes']

" }}}
" YouCompleteMe {{{

let g:ycm_python_binary_path = 'python'
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_max_num_candidates = 6
let g:ycm_max_num_identifier_candidates = 6
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_key_list_select_completion = ['<TAB>']

" }}}


" Post-Plugin Keys
" ================

" KeyRemaps {{{

" Change the <leader> to ,
let mapleader=","

" Use a vertically split help window.
cabbrev h vert h

map         <C-n>               :NERDTreeToggle<CR>
nmap        <C-t>               :TagbarToggle<CR>
nmap        <C-space>           :AirlineToggleWhitespace<CR>
nnoremap    <leader><space>     :nohlsearch<CR>
nnoremap    <leader>u           :MundoToggle<CR>
nnoremap    <leader>a           :Ag
nnoremap    <leader>y           :let g:ycm_auto_trigger=0<CR>
nnoremap    <leader>Y           :let g:ycm_auto_trigger=1<CR>

" Moving Windows.
nnoremap    <A-Left>                <C-w>h
nnoremap    <A-Down>                <C-w>j
nnoremap    <A-Up>                  <C-w>k
nnoremap    <A-Right>               <C-w>l

" }}}
" Misc {{{

" Italicize comments.
highlight Comment gui=italic cterm=italic
packadd matchit

" }}}


" License
" =======

" License {{{

"" Copyright (c) 2017 Abhijit J. Theophilus
""
"" Permission is hereby granted, free of charge, to any person obtaining a copy
"" of this software and associated documentation files (the "Software"), to deal
"" in the Software without restriction, including without limitation the rights
"" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
"" copies of the Software, and to permit persons to whom the Software is
"" furnished to do so, subject to the following conditions:
""
"" The above copyright notice and this permission notice shall be included in all
"" copies or substantial portions of the Software.
""
"" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
"" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
"" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
"" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
"" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
"" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
"" SOFTWARE.

" }}}

" vim:foldmethod=marker:foldlevel=0:set ts=4 sw=4:
