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
"snippets
Plug 'honza/vim-snippets'
"git wrapper
Plug 'tpope/vim-fugitive'
"auto pairs
Plug 'jiangmiao/auto-pairs'
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
"open explorer
nnoremap <silent> <leader>e :<C-u>Explore<CR>
"easy motion
nmap <leader>s <Plug>(easymotion-overwin-f2)
"coc
"use <tab> for trigger completion and navigate to the next item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
"rename
nmap <leader>r <Plug>(coc-rename)
"open coc list
nnoremap <leader>p :<C-u>CocList<CR>
nnoremap <leader>d :<C-u>CocList --normal diagnostics<CR>
nnoremap <leader>t :<C-u>CocList --normal outline<CR>
nnoremap <leader>a :<C-u>CocList --normal actions<CR>
nnoremap <leader>b :<C-u>CocList buffers<CR>
nnoremap <leader>f :<C-u>CocList files<CR>
nnoremap <leader>g :<C-u>CocList grep<CR>
nnoremap <leader>y :<C-u>CocList -A --normal yank<CR>
nnoremap mm :<C-u>CocCommand bookmark.toggle<CR>
nnoremap mi :<C-u>CocCommand bookmark.annotate<CR>
nnoremap [m :<C-u>CocCommand bookmark.prev<CR>
nnoremap ]m :<C-u>CocCommand bookmark.next<CR>
nnoremap ma :<C-u>CocList --normal bookmark<CR>

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
let g:coc_global_extensions=[
    \ "coc-snippets",
    \ "coc-tabnine",
    \ "coc-yank",
    \ "coc-lists",
    \ "coc-bookmark",
    \ "coc-git",
    \ "coc-highlight",
    \ "coc-json",
    \ "coc-yaml",
    \ "coc-markdownlint",
    \ "coc-sh",
    \ "coc-html",
    \ "coc-css",
    \ "coc-tsserver"]
