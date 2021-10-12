set nocompatible              " be iMproved, required
filetype off                  " required
set exrc  										" Allows project specific .vimrc
set autoread                  " reload files 
set encoding=UTF-8

" mouse supprt
set mouse=a

" fzf insralled trought homeBrew
set rtp+=/usr/local/opt/fzf

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Plugins
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/bundle')
Plug 'arcticicestudio/nord-vim'

Plug 'vim-airline/vim-airline'

Plug 'ryanoasis/vim-devicons'

Plug 'liuchengxu/vim-clap'

Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive' "Git tools

Plug 'metakirby5/codi.vim'

Plug 'OmniSharp/omnisharp-vim'

" Mappings, code-actions available flag and statusline integration
Plug 'nickspoons/vim-sharpenup'

" Linting/error highlighting
Plug 'dense-analysis/ale'

Plug 'idanarye/vim-merginal'

" Autocompletion
Plug 'prabirshrestha/asyncomplete.vim'
call plug#end()

syntax on
set number

set encoding=utf-8
scriptencoding utf-8

set completeopt=menuone,noinsert,noselect,popuphidden
set completepopup=highlight:Pmenu,border:off

set backspace=indent,eol,start
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Core Functionality (general settings, keyboard shortcuts)
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deal with swps and backups here
" create backups
set backup
" tell vim where to put its backup files
set backupdir=/tmp
" tell vim where to put swap files
set dir=/tmp
set timeoutlen=1000        " speed vim up
set ttimeoutlen=0          " https://stackoverflow.com/questions/37644682/why-is-vim-so-slow/37645334
set ttyfast                " Rendering
set tw=500
" Disable Autocommenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" map jk to esc
:imap jk <Esc>

" save with zz
nnoremap zz :update<cr>

" set clipboard to easily copy from vim and paste into OSx
set clipboard=unnamed

" remap Ctrl-p for finding files run Fzf :Files command
nnoremap <C-p> :Files<Cr>

let g:airline_powerline_fonts = 1

filetype plugin indent on 

" NerdTree Setup
" key bindings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Show hidden files
let NERDTreeShowHidden=1

" Coloer Scheme
colorscheme nord

" Asyncomplete: {{{
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
" }}}

" Omnisharp Stuff C# baby
let g:OmniSharp_server_stdio = 1
inoremap <expr> <Tab> pumvisible() ? '<C-n>' :
\ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'

let g:OmniSharp_selector_findusages = 'clap'
let g:OmniSharp_selector_ui = 'clap'   " Use vim-clap


" ALE: {{{
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_info = '·'
let g:ale_sign_style_error = '·'
let g:ale_sign_style_warning = '·'

let g:ale_linters = { 'cs': ['OmniSharp'] }
" }}}

" Sharpenup: {{{
" All sharpenup mappings will begin with `<Space>os`, e.g. `<Space>osgd` for
" :OmniSharpGotoDefinition
let g:sharpenup_map_prefix = '<Space>os'

let g:sharpenup_statusline_opts = { 'Text': '%s (%p/%P)' }
let g:sharpenup_statusline_opts.Highlight = 0

augroup OmniSharpIntegrations
  autocmd!
augroup END
" }}}
