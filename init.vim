" (N)Vim Configuration File
" vim  : place in $HOME/.vimrc
" nvim : place in $HOME/.config/nvim/init.vim
" $ ln -s $HOME/.config/nvim/init.vim $HOME/.vimrc
" General settings
" https://learnvimscriptthehardway.stevelosh.com/
"
"
" download vim-plug
" git@github.com:junegunn/vim-plug
" symlink to this file 
" ~/.vimrc
" $HOME/.config/nvim/init.vim
" ---------------------------------------------------------------------------
" drop vi support - kept for vim compatibility but not needed for nvim
" Probably not needed with Vim 8+
"set nocompatible

" Search recursively downward from CWD; provides TAB completion for filenames
" e.g., `:find vim* <TAB>`
set path+=**

" number of lines at the beginning and end of files checked for file-specific vars
set modelines=0

" reload files changed outside of Vim not currently modified in Vim (needsbelow)
set autoread

"http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work#20418591
au FocusGained,BufEnter * :silent! !

" use Unicode
set encoding=utf-8

" errors flash screen rather than emit beep
set visualbell

" make Backspace work like Delete
set backspace=indent,eol,start

" don't create `filename~` backups
set nobackup

" don't create temp files
set noswapfile

" line numbers and distances
""set relativenumber 
""set number 

set nu
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" number of lines offset when jumping
set scrolloff=2

" Tab key enters 4 spaces
" To enter a TAB character when `expandtab` is in effect,
" CTRL-v-TAB
set expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Indent new line the same as the preceding line
set autoindent

" statusline indicates insert or normal mode
set showmode showcmd

" make scrolling and painting fast
" ttyfast kept for vim compatibility but not needed for nvim
set ttyfast lazyredraw

" highlight matching parens, braces, brackets, etc
set showmatch

" http://vim.wikia.com/wiki/Searching
set hlsearch incsearch ignorecase smartcase

" As opposed to `wrap`
"set nowrap

" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
" TODO disabled
"set autochdir

" open new buffers without saving current modifications (buffer remain sopen)
set hidden

"http://stackoverflow.com/questions/9511253/how-to-effectively-use-vim-wildmenu
set wildmenu wildmode=list:longest,full

" StatusLine always visible, display full path
" http://learnvimscriptthehardway.stevelosh.com/chapters/17.html
set laststatus=2 statusline=%F

" Use system clipboard
" http://vim.wikia.com/wiki/Accessing_the_system_clipboard
" for linux
"set clipboard=unnamedplus
" for macOS
set clipboard=unnamed

" Folding
" https://vim.fandom.com/wiki/Folding
" https://vim.fandom.com/wiki/All_folds_open_when_opening_a_file
"https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
set foldmethod=indent
set foldnestmax=1
set foldlevelstart=1

" netrw and vim-vinegar
let g:netrw_browse_split = 3

" Plugins, syntax, and colors
"
"---------------------------------------------------------------------------
" vim-plug
" https://github.com/junegunn/vim-plug
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure to use single quotes
" Install with `:PlugInstall`

" https://github.com/itchyny/lightline.vim
Plug 'itchyny/lightline.vim'

" https://github.com/tpope/vim-commentary
Plug 'tpope/vim-commentary'

" https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'

" https://github.com/tpope/vim-vinegar
""Plug 'tpope/vim-vinegar'

" https://github.com/APZelos/blamer.nvim
Plug 'APZelos/blamer.nvim'

" https://github.com/fenetikm/falcon/wiki/Installation
Plug 'fenetikm/falcon'

" https://github.com/macguirerintoul/night_owl_light.vim
Plug 'macguirerintoul/night_owl_light.vim'

"Plug 'scrooloose/nerdtree', {'on': 'NerdTreeToggle'}
Plug 'scrooloose/nerdtree'


"Plug 'jalvesaq/Nvim-R'
Plug 'ggandor/leap.nvim'

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


Plug 'junegunn/vim-easy-align'

Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile'}


" Initialize plugin system
call plug#end()

syntax enable
filetype plugin indent on

"" For fzf search
""nnoremap <silent> <C-f>     :Files<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>g :Rg<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

"Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"" coc settings from neoclide/coc.nvim
set updatetime=300
set signcolumn=yes



function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

if has('nvim')
    lua require('leap').add_default_mappings()
endif


" Neovim only
if has('nvim')
    set termguicolors
endif
" Light scheme
"colorscheme night_owl_light

" Dark scheme
colorscheme falcon
set background=dark

" Show character column
set colorcolumn=120

""""""""""""""""""" add custom
" Remove toolbar
set guioptions-=T

set history=10000

"set wildmenu
set wildignore=*.o,*.obj,*.exe,*.a

"font setup
"set guifont=Monospace\ 9

set autowrite
set nu
set mouse=a
set ruler

set list listchars=tab:\|_,trail:.


" Auto Bracket
"inoremap ( (<SPACE><SPACE>)<LEFT><LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap { {}<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

" Tip #271: easy (un)commenting out of source code
" Un/Comment using /* ... */
function! Komment()
if getline(".") =~ '\/\*'
let hls=@/
s/^\/\*//
s/*\/$//
let @/=hls
else
let hls=@/
s/^/\/*/
s/$/*\//
let @/=hls
endif
endfunction

map ,* :call Komment()<CR>:nohlsearch<CR>

" Un/Comment using //
function! KommentSlash()
if getline(".") =~ '\/\/'
let hls=@/
s/^\/\///
let @/=hls
else
let hls=@/
s/^/\/\//
let @/=hls
endif
endfunction

map ,/ :call KommentSlash()<CR>:nohlsearch<CR>

" Un/Comment using # - for perl
function! KommentPound()
if getline(".") =~ '\#'
let hls=@/
s/^\#//
let @/=hls
else
let hls=@/
s/^/\#/
let @/=hls
endif
endfunction

map ,# :call KommentPound()<CR>:nohlsearch<CR>

" Un/Comment using # - for perl
function! KommentSemiColon()
if getline(".") =~ '\;'
let hls=@/
s/^\;//
let @/=hls
else
let hls=@/
s/^/\;/
let @/=hls
endif
endfunction

map ,; :call KommentSemiColon()<CR>:nohlsearch<CR>

" Displays the name of the currently displayed function
map \func :let name = FunctionName()<CR> :echo name<CR>

" Highlighting whitespaces at end of line
"highlight WhitespaceEOL ctermbg=yellow guibg=yellow
"match WhitespaceEOL /\s\+$/

" Check for extra spaces instead of tabs at the front of the line
"match WhitespaceEOL /^\ \+/

" Highlight redundant whitespaces.
highlight RedundantSpaces ctermbg=white guibg=white
match RedundantSpaces /\s\+$\| \+\ze\t/





" nvim-R setup options
if has('nvim')
    let g:rout_follow_colorscheme=1
    let g:Rout_more_colors=1
    ""let g:R_assign=0
    let g:R_assign_map        = get(g:, "R_assign_map",      "__")

    let R_source_args = 'print.eval = TRUE, echo = TRUE, spaced = TRUE'
endif


" lightline config - add file 'absolutepath'
" Delete colorscheme line below if using Dark scheme

let g:lightline = {
      \ 'colorscheme': 'PaperColor_light',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'absolutepath', 'modified' ] ]
      \ }
      \ }

let g:blamer_enabled = 1
" %a is the day of week, in case it's  needed
let g:blamer_date_format = '%e %b %Y'
let g:blamer_prefix='                                                                         '
highlight Blamer guifg=yellow
