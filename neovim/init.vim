" ==============================================================================
" CONFIGURACIÓN OPTIMIZADA DE NEOVIM (init.vim)
" ==============================================================================
" Instalación automática de vim-plug si no está presente:
" - Linux/macOS:
"   sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" - Windows (PowerShell):
"   iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
" ==============================================================================

" ==============================================================================
" 1. TECLA LÍDER (LEADER KEY)
" ==============================================================================
" Mapea la tecla Espacio como <leader> (debe ir antes de cualquier atajo)
" let mapleader = " "
" let maplocalleader = " "


" ==============================================================================
" 2. ADMINISTRADOR DE PLUGINS (vim-plug)
" ==============================================================================
call plug#begin()

" Autocompletado, LSP y motor de extensiones
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Tema de color de la interfaz
Plug 'dracula/vim', { 'as': 'dracula' }

" Barra de estado ligera y personalizable
Plug 'itchyny/lightline.vim'

Plug 'jiangmiao/auto-pairs'

call plug#end()


" ==============================================================================
" 3. APARIENCIA E INTERFAZ DE USUARIO (UI)
" ==============================================================================
set termguicolors                            " Habilita colores de 24-bits (True Color) en la terminal
colorscheme dracula                          " Aplica el esquema de colores Dracula
let g:lightline = {'colorscheme': 'dracula'} " Sincroniza la barra de estado con Dracula

set number                    " Muestra el número de línea actual
set relativenumber            " Muestra números de línea relativos para saltos ágiles
set cursorline                " Resalta visualmente la línea actual donde está el cursor
set signcolumn=yes            " Reserva siempre la columna izquierda para diagnósticos de CoC/Git
set laststatus=2              " Muestra siempre la barra de estado inferior
set scrolloff=8               " Mantiene un margen de 8 líneas visibles arriba/abajo al desplazar
set sidescrolloff=8           " Mantiene un margen de 8 columnas a la izquierda/derecha
set nowrap                " Desactiva el ajuste automático de líneas largas


" ==============================================================================
" 4. SISTEMA Y COMPORTAMIENTO
" ==============================================================================
set clipboard=unnamedplus     " Sincroniza el portapapeles de Neovim con el del sistema operativo
set mouse=a                   " Permite la interacción con ratón en todos los modos (Normal, Visual, etc.)
set updatetime=300            " Reduce el tiempo de inactividad (ms) para mostrar diagnósticos de CoC
set timeoutlen=500            " Tiempo de espera (ms) para completar secuencias de atajos
set splitbelow                " Las nuevas divisiones horizontales se abren hacia abajo
set splitright                " Las nuevas divisiones verticales se abren hacia la derecha

" Gestión de archivos temporales y persisencia:
set nobackup                  " Desactiva la creación de archivos de respaldo (~filename)
set nowritebackup             " Evita respaldos temporales antes de guardar el archivo
set noswapfile                " Desactiva la creación de archivos .swp para evitar bloqueos
set undofile                  " Mantiene el historial de deshacer (undo) entre sesiones


" ==============================================================================
" 5. INDENTACIÓN Y TABULACIONES
" ==============================================================================
set tabstop=4                 " Define que un carácter <Tab> equivalga visualmente a 4 espacios
set shiftwidth=4              " Número de espacios aplicados con los comandos de sangría ('>>', '<<')
set softtabstop=4             " Número de espacios insertados/eliminados al presionar <Tab> o <BS>
set expandtab                 " Convierte automáticamente las tabulaciones en espacios reales
set autoindent                " Copia la sangría de la línea anterior al crear una nueva
set smartindent               " Aplica reglas de sangría inteligente según la sintaxis del lenguaje


" ==============================================================================
" 6. BÚSQUEDA Y REEMPLAZO
" ==============================================================================
set ignorecase                " Ignora mayúsculas/minúsculas al realizar búsquedas
set smartcase                 " Respeta mayúsculas si la búsqueda incluye explícitamente una
set incsearch                 " Resalta y salta a las coincidencias a medida que se escribe
set hlsearch                  " Resalta permanentemente todas las coincidencias encontradas

" Desactiva el resaltado de búsqueda actual al presionar <Esc>
nnoremap <silent> <Esc> :nohlsearch<CR>


" ==============================================================================
" 7. CONFIGURACIÓN Y EXTENSIONES DE COC.NVIM
" ==============================================================================
" Lista de extensiones que CoC instalará/mantendrá automáticamente
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-tsserver',
\ 'coc-pyright',
\ 'coc-clangd',
\ 'coc-html',
\ 'coc-css',
\ 'coc-prettier',
\ '@yaegassy/coc-intelephense',
\ 'coc-go'
\ ]

" Muestra los avisos y estado de CoC en la barra de estado
set statusline^=%{coc#status()}


" ==============================================================================
" 8. AUTOCOMPLETADO CON TAB Y ENTER (CoC)
" ==============================================================================
" Función auxiliar que verifica si el cursor está tras un espacio en blanco
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Navegar hacia abajo en el menú de sugerencias con <TAB> o iniciar autocompletado
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" Navegar hacia arriba en el menú de sugerencias con <S-TAB> (Shift+Tab)
inoremap <expr> <S-TAB>
      \ coc#pum#visible() ?
      \ coc#pum#prev(1) :
      \ "\<C-h>"

" Confirmar la selección del autocompletado presionado <CR> (Enter)
inoremap <silent><expr> <CR>
      \ coc#pum#visible() ?
      \ coc#pum#confirm() :
      \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" ==============================================================================
" 9. ATAJOS DE NAVEGACIÓN LSP Y EDICIÓN (CoC)
" ==============================================================================
" Navegación entre errores/diagnósticos
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Ir a definiciones y referencias
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Acciones de refactorización y formato
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>f :call CocActionAsync('format')<CR>
nmap <silent> ga <Plug>(coc-codeaction-cursor)

" Muestra documentación/información del símbolo bajo el cursor (Hover)
nmap <silent> K :call CocActionAsync('doHover')<CR>
nnoremap <silent> <M-i> :<C-U>call CocActionAsync('doHover')<CR>