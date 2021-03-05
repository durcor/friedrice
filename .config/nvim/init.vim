" ~/.config/nvim/init.vim
"
"            -q*                      .h'
"          'K@@WG.                    .ggZ`
"        'G@@@@NN&~                   .gggg]'
"      _qg@@@@@N##0*                  .ggggggZ'
"     Gg@@@@@@@#0000X.                .ggggggggZ'
"  'jR gggggggg000000D:               .gggggggggWZ'
" aNWNB ggggggg0BBBBBBBs              .WWWWWWWWWWWW2
" mWWWW0 WgggggBBBBBBBBBh.             WWWWWWWWWWWW0
" ANNNNN#R ggggBBBBBBBBBBm.            WWWWWWWWWWWWB
" O#######8 WggB&&&&&&&&&&&s           NWWWWWWWWWWWB
" K00000000BD g8&&&&&&&&&&&&].         0NNNNNNNNNNN8
" KBBBBBBBBBBD R&&&&&&&&&&&&RA:        B00000000000&
" qBBBBBBBBBBBR PRRRRRRRRRRRRRR\       800000000000R
" q888888888888  *DDDDDDDDDDDDDD2.     RBBBBBBBBBBBR
" G&&&&&&&&&&&&   "mDDDDDDDDDDDDDq:    D88888888888D
" PRRRRRRRRRRRR    `hDDDDDDDDDDDDDm>   m&&&&&&&&&&&D
" kDDDDDDDDDDDD      *mmmmmmmmmmmmmma. mRRRRRRRRRRRD
" XDDDDDDDDDDDD       "OmmmmmmmmmmmmmP_ODDDDDDDDDDDm
" hDDDDDDDDDDDD        `]AAAAAAAAAAAAAORmmmmmmmmmmmm
" Zmmmmmmmmmmmm          LOOOOOOOOOOOOOBBmmmmmmmmmmA
" Zmmmmmmmmmmmm           !qOOOOOOOOOOOB0BmAAAAAAAAO
" ]AAAAAAAAAAAA            .}KKKKKKKKKK8BBBDOOOOOOOK
" ]OOOOOOOOOOOO              lKKKKKKKKKR8888DOKKKKKK
" \KOOOOOOOOOOO               !PqqqqqqqR&&&&&ROqqqq1
"  .lKKKKKKKKKK                .aqqqqqqDRRRRRRRmGT'
"    .\Gqqqqqqq                  \GGGGGDDDDDDDD2-
"      .\PqqqqG                   ~hPPPmDDDDD3:
"        .>XGGG                    .1PPmmmm1-
"          .>hP                      \XOm1'
"            .r                       ~T'
"
" auto-install plug.vim if it isn't installed
if empty(glob('$XDG_DATA_HOME/nvim/site/autoload/plug.vim'))
  silent !curl -fLo $XDG_DATA_HOME/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins via vim-plug
call plug#begin('$XDG_DATA_HOME/nvim/plug')

" Colorschemes
Plug 'deviantfero/wpgtk.vim'
Plug 'bluz71/vim-moonfly-colors'
Plug 'morhetz/gruvbox'
" Plug 'dylanaraps/wal.vim'
" Plug 'richtan/pywal.vim'

" Language server
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'jackguo380/vim-lsp-cxx-highlight'

Plug 'gcmt/taboo.vim'

" Plug 'yggdroot/indentline'

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'ARM9/arm-syntax-vim'

" FZF
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

"" Vanity features
" distraction-free reading+writing
Plug 'junegunn/goyo.vim'
" highlight selected paragraph of text
Plug 'junegunn/limelight.vim'
" Plug 'DanManN/vim-razer'
" Plug 'dixonary/vimty'

" save vim sessions
" Plug 'tpope/vim-obsession'

" Better terminal integration
Plug 'fabi1cazenave/termopen.vim'

"" Syntax Highlighting
" more language support
Plug 'sheerun/vim-polyglot'
Plug 'VebbNix/lf-vim'
Plug 'tridactyl/vim-tridactyl'
Plug 'octol/vim-cpp-enhanced-highlight'
" Highlight matching parentheses
Plug 'luochen1990/rainbow',
let g:rainbow_active = 1

"" Git
" git integration
Plug 'tpope/vim-fugitive'
" git commit info
" Plug 'rhysd/committia.vim'
Plug 'airblade/vim-gitgutter'

"" Functionality
" Change surrounding characters of a text object
Plug 'tpope/vim-surround'
" Better comment management
Plug 'tpope/vim-commentary'
" Plug 'unblevable/quick-scope'
" Decrypt GPG files
Plug 'jamessan/vim-gnupg'
" Plug 'preservim/nerdtree'
Plug 'matze/vim-move'

" Plug 'neomake/neomake'
Plug 'dense-analysis/ale'

"" Grammar checking
" Plug 'rhysd/vim-grammarous'
" Plug 'dpelle/vim-LanguageTool'

" Better vim markdown integration
Plug 'vimwiki/vimwiki'

" Plug 'KabbAmine/vCoolor.vim'
" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Start page
Plug 'mhinz/vim-startify'
call plug#end()

"let g:Hexokinase_highlighters = [
""\   'virtual',
""\   'sign_column',
""\   'background',
"\   'backgroundfull',
""\   'foreground',
""\   'foregroundfull'
"\ ]
"
" run neomake on file save
" call neomake#configure#automake('w')
" call deoplete#custom#option({
"                         \ 'auto_complete_delay': 0,
"                         \ })

" let g:languagetool_jar='$HOME/.local/share/nvim/plug/vim-grammarous/misc/LanguageTool-4.8/languagetool-commandline.jar'
" highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
" highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
let g:termopen_autoinsert = 0

let g:startify_custom_header =
        \ startify#pad(split(system('fortune -as | cowsay -f tux'), '\n'))
let g:startify_use_env = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep=''
let g:airline_left_alt_sep='/'
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_symbols.readonly=''
" let g:airline_symbols.spell = 'Ꞩ'
" Buffer tab line customization
let g:airline#extensions#tabline#enabled = 1
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

let g:coc_global_extensions = "coc-sh,coc-json,coc-tsserver,coc-clangd,coc-texlab"

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

let g:taboo_tab_format = "%f%m"
let g:taboo_renamed_tab_format = "%l"

let g:indentLine_setColors = 1
let g:indentLine_char = '-'

" set termguicolors " truecolor support - breaks some colorschemes (pywal-related) ones :(
colorscheme wpgtk
" colorscheme moonfly
" colorscheme gruvbox
let g:moonflyTerminalColors = 1
let g:gruvbox_termcolors = '16'

" Limelight
let g:limelight_conceal_ctermfg = '8'
let g:airline_theme='wpgtk_alternate'
" let g:airline_theme='moonfly'
" let g:airline_theme='gruvbox'

set nobackup " Save often :^)
set nowritebackup
set noswapfile " Swap files do literally nothing other than cause problems
set autochdir " Automatically change directory to dir of current file

set shortmess+=c
set virtualedit=block
set splitbelow
set pyx=3

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let $PAGER=''
set nocompatible
set hidden
set ttyfast
" Disable the timeout when non-modal keys (leader keys)
" are pressed (ie. c,f,custom leaders)
set notimeout

set lazyredraw " improve macro performance
set sessionoptions+=tabpages,globals
set shell=/bin/zsh
set background=dark
set foldcolumn=0 " Amount of empty space to the left of signcolumn/number line
set updatetime=250
" let base16colorspace=256
let mapleader ="\<Space>"

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" set signcolumn=number
set signcolumn=yes

" let $GIT_EDITOR = 'nvr -cc split --remote-wait'

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

set wrap " Wrapping lines if they extend off the screen
set smartcase " Searches case-insensitively unless capitals are in the query
set undofile " Save undo history
set undodir=$XDG_DATA_HOME/nvim/undo

set cmdheight=1
set wildmenu
set wildmode=longest,full
set ruler
set scrolloff=200 " Keep the cursor in the center of the vim buffer
set scrollback=100000 " Terminal scrollback

set autoindent
set smartindent

" regex magic
set magic

set noshowmode
set showcmd
set mouse=a
" Tab Stop
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0
set nosmarttab
"
set autoread
set ffs=unix,dos,mac
" Show current line number
set number
" Show other line numbers as indices separated from current line
se relativenumber

"highlight search
se hlsearch

se encoding=utf-8
filetype on
filetype indent on

" case-insensitive search
set ignorecase

set incsearch

"allow nvim to utilize global clipboard
set clipboard+=unnamedplus

"autocmd SwapExists * let v:swapchoice = "o"

" File-type specific configuration
" set calcurse note files to be markdown
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.hex set filetype=c
" Better systemd/config file syntax highlighting
autocmd BufRead,BufNewFile *.conf,*.cfg,*.service*,*.timer* set filetype=dosini
autocmd BufRead,BufNewFile *.css.* set filetype=css
autocmd BufRead,BufNewFile *.log set filetype=log
autocmd BufRead,BufNewFile *.*patch set filetype=gitsendemail

" use ls syntax highlighting for vimv buffers
autocmd BufRead,BufNewFile /tmp/vimv.* set filetype=ls | normal $T/
" jump straight to the file name in vimv if you are given the ability to edit
" the entire path (such as when called inside of lf)
" " Edit extension of current file in vimv
" autocmd BufRead,BufNewFile /tmp/vimv.ext* normal $T.C

" spell checking for LaTeX, markdown, plaintext, and git commits
autocmd FileType tex,markdown,gitcommit,text setlocal spell spelllang=en_us,es
" set spell spelllang=en_us,es

" Goyo's width will be the line limit in mutt.
" autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80

" Enable Goyo by default for mutt writting
" autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

" Don't show linenumber when in the vim terminal
" autocmd TermOpen term://* set nonumber norelativenumber
" autocmd TermClose term://* set number relativenumber

tnoremap <F12> <C-\><C-N>

" Adding tmux-like functionality to nvim
map <F12>o :call TermOpen(&shell,'t')<cr><F12><F12>
map <F12>h <C-w>h<F12>
map <F12>j <C-w>j<F12>
map <F12>k <C-w>k<F12>
map <F12>l <C-w>l<F12>

map <F12>H :vertical resize +1<cr><F12>
map <F12>L :vertical resize -1<cr><F12>
map <F12>J :resize -1<cr><F12>
map <F12>K :resize +1<cr><F12>

map <F12>0 :tabfirst<cr><F12>
map <F12>w :tabnext<cr><F12>
map <F12>b :tabprevious<cr><F12>
map <F12>$ :tablast<cr><F12>
map <F12>- :call TermOpen()<cr><F12><F12>
map <F12>\ :call TermOpen(&shell,'v')<cr><F12><F12>
map <F12>x :bdelete!<cr><F12>
map <F12>i <Esc>
map gb :Buffers<cr>

map <leader>u :!urlscan %<cr>
map <leader><leader> :w<cr>
map <leader>s :setlocal spell! spelllang=en_us,es<cr>
map <leader>f :Files<cr>
map <leader>F :call TermOpenRanger('lf')<cr>
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
map <leader>r :source $MYVIMRC<cr>
map <leader><C-w> :'<,'>w !wc -w<cr>

map <leader>h :Startify<cr>

" Compiling within vim
map <leader>ch :!pandoc % -o %.html<cr><cr>
map <leader>ct :!pdflatex %<cr><cr>
map <leader>cp :!pandoc --highlight-style=breezedark % -o %.pdf<cr><cr>
map <leader>cm :!make<cr><cr>
map <leader>cM :!./test*.sh<cr><cr>

" Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
map <leader>l :Goyo<cr>
map <leader>G :GrammarousCheck<cr>
map <leader>e :CocCommand explorer<cr>

" Git Integration
map <leader>gg :G<cr>
map <leader>gc :Gco<cr>
map <leader>gs :GitGutterStageHunk<cr>
map <leader>gu :GitGutterUndoHunk<cr>
map <leader>gn :GitGutterNextHunk<cr><leader>g
map <leader>gN :GitGutterPrevHunk<cr><leader>g
"" GitGutter
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_sign_allow_clobber = 1
let g:gitgutter_set_sign_backgrounds = 1
highlight GitGutterAdd ctermbg=Green ctermfg=0
highlight GitGutterAddLineNr ctermbg=Green ctermfg=0

highlight GitGutterChange ctermbg=Yellow ctermfg=0
highlight GitGutterChangeLineNr ctermbg=Yellow ctermfg=0

highlight GitGutterDelete ctermbg=Red ctermfg=0
highlight GitGutterDeleteLineNr ctermbg=Red ctermfg=0

highlight GitGutterChangeDelete ctermbg=Yellow ctermfg=0
highlight GitGutterChangeDeleteLineNr ctermbg=Yellow ctermfg=0

" Remap q to \ so that q can be used for quitting
noremap \ q
map q :bdelete!<cr>
" Replace the useless (sorry) ex-mode keybind
" with quick file exiting
map Q :q<cr>
map <C-Q> :q!<cr>

map ZW :w<cr>

map cd :call TermOpenRanger('lf')<cr>

set cursorline
highlight CursorLine term=bold ctermbg=8

" GoTo code navigation via coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" se cursorcolumn
" hi CursorColumn ctermbg=8

" function Vimty()
"         source $XDG_DATA_HOME/nvim/plug/vimty/vimty.vim
" endfunction
