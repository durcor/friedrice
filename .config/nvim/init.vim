" ~/.config/nvim/init.vim
"
" auto-install plug.vim if it isn't installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.local/share/nvim/plug')
Plug 'deviantfero/wpgtk.vim'
" Plug 'dylanaraps/wal.vim'
" Plug 'richtan/pywal.vim'
Plug 'jamessan/vim-gnupg'
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'junegunn/fzf', { 'dir': '~/prg/fzf', 'do': './install -all' }
Plug 'junegunn/fzf.vim'
" distraction-free reading+writing
Plug 'junegunn/goyo.vim'
" highlight selected paragraph of text
Plug 'junegunn/limelight.vim'
" save vim sessions
" Plug 'tpope/vim-obsession'
" more language support
Plug 'sheerun/vim-polyglot'
" git integration
Plug 'tpope/vim-fugitive'
" git commit info
Plug 'rhysd/committia.vim'
Plug 'VebbNix/lf-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
" Plug 'dixonary/vimty'
Plug 'neomake/neomake'
Plug 'rhysd/vim-grammarous'
Plug 'dpelle/vim-LanguageTool'
let g:languagetool_jar='$HOME/.local/share/nvim/plug/vim-grammarous/misc/LanguageTool-4.8/languagetool-commandline.jar'
" Plug 'DanManN/vim-razer'
" Better vim markdown integration
Plug 'vimwiki/vimwiki'
" Plug 'KabbAmine/vCoolor.vim'
" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'luochen1990/rainbow',
Plug 'tpope/vim-commentary'
" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tridactyl/vim-tridactyl'
Plug 'airblade/vim-gitgutter'
Plug 'unblevable/quick-scope'
Plug 'mhinz/vim-startify'
let g:rainbow_active = 1
" Plug 'preservim/nerdtree'
call plug#end()

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Startify
let g:startify_custom_header =
        \ startify#pad(split(system('fortune -a | cowsay -f tux'), '\n'))
let g:startify_use_env = 1

" Plugin configuration
"" Airline
let g:airline_left_sep=''
let g:airline_left_alt_sep='/'
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_symbols.readonly=''
" let g:airline_symbols.spell = 'Ꞩ'
" Buffer tab line customization
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tagbar#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_statusline_ontop = 0
let g:airline_highlighting_cache = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#coc#enabled = 1
" Show absolute filepath instead of relative path
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
" let g:airline#extensions#cursormode#enabled = 1
" Limelight
let g:limelight_conceal_ctermfg = '8'

highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

"let g:Hexokinase_highlighters = [
""\   'virtual',
""\   'sign_column',
""\   'background',
"\   'backgroundfull',
""\   'foreground',
""\   'foregroundfull'
"\ ]

" run neomake on file save
call neomake#configure#automake('w')
" call deoplete#custom#option({
"                         \ 'auto_complete_delay': 0,
"                         \ })

let g:coc_global_extensions = "coc-sh,coc-json,coc-tsserver,coc-discord,coc-clangd,coc-texlab"

" Themes
" se termguicolors
" color blue
color wpgtk
let g:airline_theme='wpgtk_alternate'

set nobackup
set nowritebackup

set virtualedit=block

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let $PAGER=''
se nocompatible
se ttyfast

" improve macro performance
se lazyredraw
se shell=/bin/sh
se background=dark
" Decide the amount of empty space to the left
se foldcolumn=0
set updatetime=300
let base16colorspace=256
let mapleader ="\<Space>"

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" TODO: Map // to remove hlsearch

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" line number
se nu
" Don't wrap lines if they extend off the screen
se nowrap
se smartcase
se undodir=~/.local/share/nvim/undo
se undofile

se cmdheight=1
se wildmenu
se ruler
" Keep the cursor in the center of the vim buffer
se so=200

" auto indent
se ai

" set smart indent
se si

" regex magic
se magic

se noshowmode
se showcmd
se mouse=a
se expandtab
se ts=4
se sw=4
se smarttab
se ffs=unix,dos,mac
se relativenumber

"highlight search
se hlsearch

se encoding=utf8
syntax on
filetype on
filetype indent on

" case-insensitive search
se ignorecase

se incsearch

"allow nvim to utilize global clipboard
se clipboard+=unnamedplus

"autocmd SwapExists * let v:swapchoice = "o"

" set calcurse note files to be markdown
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.hex set filetype=c
autocmd BufRead,BufNewFile *.conf,*.cfg set filetype=dosini
" Better systemd file syntax highlighting
autocmd BufRead,BufNewFile *.service*,*.timer* set filetype=dosini
autocmd BufRead,BufNewFile *.css.* set filetype=css

" use ls syntax highlighting for vimv buffers
autocmd BufRead,BufNewFile /tmp/vimv.* set filetype=ls
" jump straight to the file name in vimv if you are given the ability to edit
" the entire path (such as when called inside of lf)
autocmd BufRead,BufNewFile /tmp/vimv.* normal $T/
" " Edit extension of current file in vimv
" autocmd BufRead,BufNewFile /tmp/vimv.ext* normal $T.C

" spell checking for LaTeX, markdown, plaintext, and git commits
autocmd FileType tex,markdown,gitcommit,text setlocal spell spelllang=en_us,es

" Goyo's width will be the line limit in mutt.
" autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80

" Enable Goyo by default for mutt writting
" autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

map <leader>u :!tmux splitw -v -p 40 urlscan %<cr>
map <leader><leader> :w<cr>
map <leader>s :setlocal spell! spelllang=en_us,es<cr>
map <leader>f :Files<cr>
map <leader>k :r!pwgen<cr>
map <leader>/ :noh<cr>

" Plugin manager bindings
map <leader>pu :PlugUpdate<cr>
map <leader>py :PlugUpgrade<cr>
map <leader>pc :PlugClean<cr>
map <leader>ps :PlugStatus<cr>
map <leader>pd :PlugDiff<cr>

map <leader>w :w<cr>
map <leader>W :wq<cr>
map <leader>q :q<cr>
map <leader>Q :q!<cr>
map <leader>r :source ~/.config/nvim/init.vim<cr>
map <leader>F :'<,'>w !wc -w<cr>

" Document compiling
map <leader>ch :!pandoc % -o %.html<cr><cr>
map <leader>ct :!pdflatex %<cr><cr>
map <leader>cp :!pandoc % -o %.pdf<cr><cr>
map <leader>cm :!make<cr><cr>

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
map <leader>l :Goyo<cr>
map <leader>g :GrammarousCheck<cr>

" Remap q to \ so that q can be used for quitting
noremap \ q
map q :q<cr>
" Replace the useless (sorry) ex-mode keybind
" with quick file exiting
map Q :wq<cr>
map <C-Q> :q!<cr>

map ZW :w<cr>

se cursorline
hi CursorLine term=bold ctermbg=8

" GoTo code navigation via coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" se cursorcolumn
" hi CursorColumn ctermbg=8

" function Vimty()
"         source ~/.local/share/nvim/plug/vimty/vimty.vim
" endfunction
