" Pathogen
execute pathogen#infect()

" ALE
let g:ale_fixers = { 'javascript': ['eslint'], }
let g:ale_fix_on_save = 1
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '>>'
" Integrate with vim-airline
let g:airline#extensions#ale#enabled = 1
" colors: ALEErrorSign ALEWarningSign
let g:ale_echo_msg_error_str = 'error'
let g:ale_echo_msg_warning_str = 'warn'
let g:ale_echo_msg_format = '%severity%: %s [%linter%]'

" ack
" [options] {pattern} {directories}
nnoremap <leader>a :Ack

" Indent guides
let g:indent_guides_enable_on_vim_startup = 1

" Nerd tree
autocmd vimenter * NERDTree
map <C-\> :NERDTreeToogle<CR>

" TagBar
nmap <F8> :TagbarToggle<CR>

" Syntax
syntax on
set tabstop=2
set softtabstop=2
set expandtab " tabs are spaces

" UI
set number
set cursorline " higlight current line
set wildmenu " visual autocomplete for command menu
set lazyredraw " enhacement
set showmatch " highlight matching [ { (

" Search
set incsearch " type as you search
set hlsearch " hihglight matches
nnoremap <leader><space> :nohlsearch<CR> " turn off search highlight: ,<space>

" Folding
set foldenable
set foldlevelstart=4
set foldnestmax=10
nnoremap <space> za " space open/closes folds
" Run :help foldmethod

" Movement
nnoremap j gj
nnoremap k gk

" Leader
let mapleader=','


filetype plugin indent on
