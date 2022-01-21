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
set history=50
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

filetype plugin indent on
syntax on

if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let mapleader = "\<space>"

call plug#begin()

Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/neoclide/coc.nvim'
source ~/.config/nvim/plugins/coc.vim
Plug 'https://github.com/cpiger/NeoDebug', { 'for' : 'cpp' }
Plug 'https://github.com/bfrg/vim-cpp-modern', { 'for' : 'cpp' }
" Plug 'https://github.com/junegunn/fzf.vim'
" source ~/.confi/nvim/plugins/fzf.vim
Plug 'https://github.com/honza/vim-snippets'
Plug 'https://github.com/SirVer/ultisnips'
Plug 'nvim-lua/plenary.nvim'
Plug 'https://github.com/nvim-telescope/telescope.nvim'
Plug 'https://github.com/BurntSushi/ripgrep'
Plug 'google/vim-maktaba', { 'for' : 'cpp' }
Plug 'google/vim-codefmt', { 'for' : 'cpp' }
Plug 'google/vim-glaive', { 'for' : 'cpp' }

call plug#end()
  

" let g:snipMate = { 'snippet_version' : 1}
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


set encoding=UTF-8
colorscheme jellybeans

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

nmap <C-d> :NeoDebug<CR>
nmap <C-l> :DBGOpenLocals<CR>

inoremap ( ()<left>
inoremap [ []<left>
inoremap ' ''<left>
inoremap " ""<left>
inoremap { {}<left>

nmap <F9> :TagbarToggle<CR>

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" air-line
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" moving selected blocks
vnoremap < <gv
vnoremap > >gv

inoremap jj <ESC>:w<CR>

nmap <leader>sc :source ~/.config/nvim/init.vim<cr>
nmap <leader>es :edit ~/.config/nvim/init.vim<cr>
nmap <leader>pi :PlugInstall<cr>

" opens a file even if it does not exist
map gf :e <cfile><cr>

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

" mapped in buildProject folders
nmap <F8> :terminal! ./build.sh<CR>
nmap <F5> :!./compile.sh<CR>
set foldmethod=marker foldmarker={,} foldlevel=2
nnoremap <silent> <leader>fl m`zcVzCzo`
nmap <A-UP> <UP>ddp<UP>
nmap <A-DOWN> ddp

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
" nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
" nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
" nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
" nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
