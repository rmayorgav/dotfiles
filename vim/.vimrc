" Linux:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Windows
" iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni $HOME/vimfiles/autoload/plug.vim -Force

call plug#begin()
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'ghifarit53/tokyonight-vim'
	Plug 'itchyny/lightline.vim'
	Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

set number

set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

set cursorline

set mouse=a

set noswapfile

set termguicolors
colorscheme dracula
set guifont=Consolas:h11
let g:lightline = {'colorscheme': 'dracula'}
set laststatus=2

let g:coc_global_extensions = ['coc-json', 'coc-clangd', 'coc-pyright', 'coc-html', 'coc-css', 'coc-prettier', '@yaegassy/coc-intelephense']

inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"

" Formatear código
nmap <leader>f :call CocActionAsync('format')<CR>
