" 
" ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
" ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
" ██║   ██║██║██╔████╔██║██████╔╝██║     
" ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"  ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"   ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"                                        
" VIM Config File by Arfan Zubi


" Encoding UTF8
set encoding=UTF-8

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable clipboard between VIM instances
set clipboard=unnamed

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax enable

" Add numbers to each line on the left-hand side.
set number

" Set relative line numbers
set relativenumber

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
set cursorcolumn

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
" set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Enable mouse support
set mouse=a

" Theme for airline statusbar
let g:airline_theme='everforest'

" Enabling symbols in airline statusbar
let g:airline_powerline_fonts = 1

" Adjusting the update time for GitGutter
set updatetime=100

" Set GUI Font
"set guifont=MesloLGS\ NF:h13

" Open new split panes to right and below
set splitright
set splitbelow


" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.
call plug#begin('~/.vim/plugged')

    " Tools
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'airblade/vim-rooter'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
    Plug 'voldikss/vim-floaterm'
    Plug 'francoiscabrol/ranger.vim'
    Plug 'rbgrouleff/bclose.vim'
    Plug 'chrisbra/Colorizer'

    " Themes
    Plug 'sainnhe/everforest'
    Plug 'joshdick/onedark.vim'
    Plug 'morhetz/gruvbox'

    " Status bar
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Language support & auto completion
    Plug 'dense-analysis/ale'
    Plug 'rust-lang/rust.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'

    " Search
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

call plug#end()
" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.
" Set the comma as the leader key.
let mapleader = ","

" Press ,, to jump back to the last cursor position.
nnoremap <leader>, ``

" Type jj to exit insert mode quickly.
" inoremap jj <Esc>

" Press the space bar to type the : character in command mode.
nnoremap <space> :

" Automatic closing of brackets and brackets
inoremap (; (<CR>);<C-c>O
inoremap (, (<CR>),<C-c>O
inoremap {; {<CR>};<C-c>O
inoremap {, {<CR>},<C-c>O
inoremap [; [<CR>];<C-c>O
inoremap [, [<CR>],<C-c>O

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" UP, DOWN, RIGHT, LEFT arrow keys
noremap <up> <c-w>+
noremap <down> <c-w>-
noremap <right> <c-w>>
noremap <left> <c-w><

" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
nnoremap <leader>nt :NERDTreeToggle<cr>

" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" Remap <cr> to make it confirms completion
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Run xrdb after writing .Xresources
autocmd BufWritePost ~/.Xresources !xrdb %

" Settings for colorscheme
    if has('termguicolors')
        " Turns on 24-bit RGB color support
        set termguicolors
    endif
    
    " For dark version.
    set background=dark

    " For light version.
    " set background=light
    
    " Everforest theme settings
        " This configuration option should be placed before `colorscheme everforest`.
        " Available values: 'hard', 'medium'(default), 'soft'
        let g:everforest_background='medium'

        " For better performance
        let g:everforest_better_performance=1

    " One Dark theme settings
        " Set to 1 if you want to hide end-of-buffer filler lines (~) for a cleaner look
        let g:onedark_hide_endofbuffer=1

        " Set to 256 for 256-color terminals (the default), or set to 16 to use your terminal emulator's native 16 colors
        let g:onedark_termcolors=1

        " Set to 1 if your terminal emulator supports italics; 0 otherwise (the default).
        let g:onedark_terminal_italics=1

    " Embark theme settings
        " Set to 1 if your terminal emulator supports italics; 0 otherwise (the default).
        let g:embark_terminal_italics = 1
        
    colorscheme everforest

" Fixing issues displaying italic text and comments in terminal
highlight Comment cterm=italic

" Hide end of buffer symbol (~)
highlight EndOfBuffer ctermfg=bg

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p

" Show hidden files in NerdTree by default
let NERDTreeShowHidden=1

" Settings for Rust auto-completion
let g:LanguageClient_serverCommands = {
\ 'rust': ['rust-analyzer'],
\ }

" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"FZF preview window fix
" This is the default option:
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" - Note that this array is passed as arguments to fzf#vim#with_preview function.
" - To learn more about preview window options, see `--preview-window` section of `man fzf`.
let g:fzf_preview_window = ['right,50%', 'ctrl-/']

" Preview window is hidden by default. You can toggle it with ctrl-/.
" It will show on the right with 50% width, but if the width is smaller
" than 70 columns, it will show above the candidate list
" let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']

" Empty value to disable preview window altogether
" let g:fzf_preview_window = []
" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.
" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2
" }}}

