"Plugin management
call plug#begin('~/.config/nvim/plugins')
"color scheme
Plug 'altercation/vim-colors-solarized'
"status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"quick motion
Plug 'easymotion/vim-easymotion'
"auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"bookmarks
Plug 'MattesGroeger/vim-bookmarks'
"git wrapper
Plug 'tpope/vim-fugitive'
"auto pairs
Plug 'jiangmiao/auto-pairs'
"markdown preview
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}
call plug#end()

"Basic setting
"file format
set fileformat=unix
"tabstop
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
"fold
set foldmethod=indent
set foldlevel=99
"search setting
set ignorecase
"text width
set textwidth=80

"Appearance
"color
set termguicolors
syntax enable
set background=light
colorscheme solarized
"layout
set number
set cursorline
set cursorcolumn
set nowrap
set signcolumn=yes
"multiple windows
set splitright
set splitbelow

"Hotkey
"jump between buffers and tabs
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>
"rerender screen and erase search highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
"easy motion
nmap <leader>s <Plug>(easymotion-overwin-f2)
"coc
"use <tab> for trigger completion and navigate to the next item
function! CheckBackSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction
inoremap <silent><expr> <Tab>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackSpace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#comfirm()
    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"snippet expand
imap <C-j> <Plug>(coc-snippets-expand-jump)
"navigate diagnostics
nmap <silent> ]d <Plug>(coc-diagnostic-prev)
nmap <silent> [d <Plug>(coc-diagnostic-next)
"goto
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"show documentation
function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction
nnoremap <silent> K :call ShowDocumentation()<CR>
"rename
nmap <leader>r <Plug>(coc-rename)
"open coc list
nnoremap <leader>d :<C-u>CocList --normal diagnostics<CR>
nnoremap <leader>t :<C-u>CocList --normal outline<CR>
nnoremap <leader>a :<C-u>CocList --normal actions<CR>
nnoremap <leader>b :<C-u>CocList buffers<CR>
nnoremap <leader>f :<C-u>CocList files<CR>
nnoremap <leader>p :<C-u>CocList grep<CR>
nnoremap <leader>y :<C-u>CocList -A --normal yank<CR>

"Command
"highlight current symbol
autocmd CursorHold * silent call CocActionAsync('highlight')
"format
command! -nargs=0 Format :call CocAction('format')

"Plugin setting
"coc
set hidden
set nobackup
set nowritebackup
set updatetime=300
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
let g:coc_global_extensions = [
            \   "coc-snippets",
            \   "coc-tabnine",
            \   "coc-yank",
            \   "coc-lists",
            \   "coc-highlight",
            \   "coc-git"
            \ ]
