set nocompatible
filetype off
syntax enable

set expandtab
set shiftwidth=4
set mouse=a
set modifiable
set softtabstop=4
set norelativenumber
set nu rnu
"set ruler
set cursorline
set showcmd

:imap jk <Esc>
set clipboard^=unnamed,unnamedplus

" tab
imap <C-t> <ESC>:tabnew<cr>
nmap <C-t> <ESC>:tabnew<cr>
map <C-t> <ESC>:tabnew<cr>
" tab

" nerd tree conf
let g:NERDTreeShowLineNumbers=1
autocmd BufEnter NERD_* setlocal rnu
map <C-n> :NERDTreeToggle<CR>
autocmd BufEnter * silent! lcd %:p:h
let g:NERDTreeShowHidden=1
" nerd tree conf

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
" 
" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
call plug#end()


" coc
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=auto
" if has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif


" fuzzy finder 
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

imap <C-p> <ESC>:ProjectFiles<cr>
nmap <C-p> <ESC>:ProjectFiles<cr>
map <C-p> <ESC>:ProjectFiles<cr>

let g:ag_working_path_mode="r"
" fuzzy finder

" Git
nmap <leader>gs :G<CR>
nmap <leader>gd :Gdiffsplit<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gl :diffget //2<CR>
" Git

set statusline+=%=
set statusline+=%#warningmsg#
set statusline+=\ %{LinterStatus()}
set statusline+=%*
set statusline+=%{FugitiveStatusline()}
" status line
set background=dark
set t_Co=256
