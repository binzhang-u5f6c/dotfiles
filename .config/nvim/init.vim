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
"tag bar
Plug 'liuchengxu/vista.vim'
"git wrapper
Plug 'tpope/vim-fugitive'
"markdown display
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install'}
call plug#end()

"Basic setting
"file format
set fileformat=unix
"enable filetype
filetype on
filetype indent on

"Hotkey
"jump between buffers
nnoremap <silent> gb :bprevious<CR>
nnoremap <silent> gB :bnext<CR>
"rerender screen and erase search highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
"open explorer
nnoremap <silent> <C-e> :CocCommand explorer<CR>
"open coc list
nnoremap <silent> <C-p> :<C-u>CocList<CR>
"open tag bar
nnoremap <silent> <C-y> :Vista<CR>

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

"Code
"indent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=79
"fold
set foldmethod=indent
set foldlevel=99
"search setting
set ignorecase

"Plugin setting
"easy motion
nmap gs <Plug>(easymotion-overwin-f2)
"coc
set updatetime=300
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
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
"snippet
imap <C-j> <Plug>(coc-snippets-expand-jump)
"navigate diagnostics
nmap <silent> ]g <Plug>(coc-diagnostic-prev)
nmap <silent> [g <Plug>(coc-diagnostic-next)
"goto
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
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
"highlight current symbol
autocmd CursorHold * silent call CocActionAsync('highlight')
"rename
nmap <leader>rn <Plug>(coc-rename)
"format
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
"vista
let g:vista_default_executive='coc'
let g:vista_icon_indent=["╰─▸ ","├─▸ "]
let g:vist#renderer#enable_icon=1
let g:vista#renderer#icons={
            \ "function": "\uf794",
            \ "variable": "\uf71b",
            \ }
"markdown display
let g:mkdp_auto_start=1
let g:mkdp_auto_close=1
