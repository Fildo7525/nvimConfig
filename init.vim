set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
set incsearch
set ignorecase
set hls
set backup
set history=50
set whichwrap=b,s,<,>,[,]
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

filetype plugin indent on
syntax on

if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let mapleader = "\<space>"
" nmap <F2> :set listchars=tab:>-,trail:-<CR>		" marks trailing spaces and tabs
set iskeyword+=-

" let g:ycm_clangd_binary_path = "/usr/bin/clangd"

call plug#begin()

Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

Plug 'https://github.com/bfrg/vim-cpp-modern', { 'for' : 'cpp' }
" Plug 'junegunn/fzf' { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/BurntSushi/ripgrep'
Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/honza/vim-snippets'
Plug 'nvim-lua/plenary.nvim'
Plug 'https://github.com/nvim-telescope/telescope.nvim'
Plug 'https://github.com/sharkdp/fd'
Plug 'google/vim-maktaba', { 'for' : 'cpp' }
Plug 'google/vim-codefmt', { 'for' : 'cpp' }
Plug 'google/vim-glaive', { 'for' : 'cpp' }
Plug 'ghifarit53/tokyonight-vim'
Plug 'https://github.com/goolord/alpha-nvim'

Plug 'drewtempelmeyer/palenight.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'gosukiwi/vim-atom-dark'

call plug#end()

set termguicolors

let g:tokyonight_style = 'night' " available: night, storm
  
set encoding=UTF-8
colorscheme tokyonight " atom-dark dracula sonokai onedark palenight jellybeans

source ~/.config/nvim/plugin/coc.vim
source ~/.config/nvim/plugin/fzf.vim
source ~/.config/nvim/plugin/nerdtree.vim
source ~/.config/nvim/plugin/ultisnip.vim
source ~/.config/nvim/plugin/airline.vim
source ~/.config/nvim/plugin/terminal.vim
source ~/.config/nvim/plugin/telescope.vim
source ~/.config/nvim/plugin/debugger.vim
" source ~/.config/nvim/plugins/dashboard.vim
" source ~/.config/nvim/plugins/alphavim.vim

" nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

inoremap ( ()<left>
inoremap [ []<left>
inoremap ' ''<left>
inoremap " ""<left>
inoremap { {}<left>

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" moving selected blocks
vnoremap < <gv
vnoremap > >gv
vnoremap <leader>y :!clip.exe<CR>u

" moving lines of code
nmap <A-UP> <UP>ddp<UP>
nmap <A-DOWN> ddp

" Moving chunks of code -> not working
" vnoremap <A-UP> d<UP>pv
" vnoremap <A-DOWN> d<DOWN>pv

" escape and save
inoremap jj <ESC>:w<CR>

nmap <leader>sc :source ~/.config/nvim/init.vim<cr>
nmap <leader>es :edit ~/.config/nvim/init.vim<cr>
nmap <leader>pi :PlugInstall<cr>

" opens a file even if it does not exist
map gf :e <cfile><cr>
nmap <leader>jc :!touch <cfile>.java<cr>

" moving between buffers
nmap <C-LEFt> :bprevious<CR>
nmap <C-RIGHT> :bnext<CR>
nmap <C-UP> :bfirst<CR>
nmap <C-DOWN> :blast<CR>

" buffer files quitting and writing
nmap <leader>bw :bw<CR>
nmap <leader>bd :bd<CR>
nmap <leader>bb :bd!<CR>
nmap <leader>w :w<CR>
nmap <leader>qq :wq<CR>

nmap <F9> :TagbarToggle<CR>

" text folding in brackets
set foldmethod=marker foldmarker={,} foldlevel=2
nnoremap <silent> <leader>fl m`zcVzCzo`

" nnoremap z= <Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>

" Maximizer
nmap <leader>m :MaximizerToggle<CR>

" let g:vimspector_enable_mappings = 'HUMAN'
