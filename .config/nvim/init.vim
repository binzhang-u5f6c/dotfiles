"Plugin management
call plug#begin('~/.config/nvim/plugins')
"color scheme
Plug 'altercation/vim-colors-solarized'
"status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"quick motion
Plug 'easymotion/vim-easymotion'
"bookmarks
Plug 'MattesGroeger/vim-bookmarks'
"git integration
Plug 'tpope/vim-fugitive'
"auto pairs
Plug 'jiangmiao/auto-pairs'
"auto complete
Plug 'neoclide/coc.nvim', {'commit': '2c7e7156f739e61b99c53662a968bb9213badbc4'}
call plug#end()

"Edit setting
"file format
set fileformats=unix,dos,mac
"indents and tabs
set expandtab
set softtabstop=4
set shiftwidth=4
"text width
set textwidth=79
"long lines
set nowrap
set sidescroll=20
"search setting
set ignorecase
set nowrapscan
"fold
set foldmethod=syntax
set foldlevel=99

"Appearance
"color
set termguicolors
set background=light
colorscheme solarized
"view
set number
set cursorline
set cursorcolumn
set signcolumn=yes
"tab visible
set list
set listchars=tab:\\u21E4-\\u21E5
"multiple windows
set splitright
set splitbelow

"Key mapping
"jump between buffers and tabs
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>
"rerender screen and erase search highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
"easy motion
nnoremap <leader>s <Plug>(easymotion-overwin-f2)
"completion
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
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
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
