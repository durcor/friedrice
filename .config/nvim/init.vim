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
if empty(glob('$XDG_DATA_HOME'))
    let $XDG_DATA_HOME = glob('$HOME/.local/share')
endif
" auto-install plug.vim if it isn't installed
if empty(glob('$XDG_DATA_HOME/nvim/site/autoload/plug.vim'))
  silent !curl -fLo $XDG_DATA_HOME/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins via vim-plug
call plug#begin('$XDG_DATA_HOME/nvim/plug')

" Colorschemes
Plug 'deviantfero/wpgtk.vim'
Plug 'bluz71/vim-moonfly-colors'
Plug 'morhetz/gruvbox'
Plug 'dylanaraps/wal.vim'
Plug 'richtan/pywal.vim'

Plug 'github/copilot.vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" Language server
Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
" Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'gcmt/taboo.vim'

" Plug 'yggdroot/indentline'

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
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
Plug 'fladson/vim-kitty'
Plug 'mboughaba/i3config.vim'
Plug 'VebbNix/lf-vim'
Plug 'tridactyl/vim-tridactyl'
Plug 'durcor/arm-syntax-vim'
" Highlight matching parentheses
Plug 'luochen1990/rainbow'
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

" Plug 'andweeb/presence.nvim'

Plug 'dense-analysis/ale'
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
            \ '*': ['trim_whitespace'],
            \ 'rust': ['rustfmt'],
            \ 'go': ['gofmt'],
            \ 'c': ['clang-format'],
            \ 'cpp': ['clang-format'],
            \ 'sh': ['shfmt']
            \ }

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

let g:startify_custom_header = startify#pad(split(system('fortune -as | cowsay -f tux'), '\n'))
let g:startify_use_env = 1

" Because of airline symbol lazy loading
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
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_statusline_ontop = 0
let g:airline_highlighting_cache = 1
let g:airline_skip_empty_sections = 1
" Show absolute filepath instead of relative path
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
" let g:airline#extensions#cursormode#enabled = 1
"
" set termguicolors " truecolor support - breaks some colorschemes (pywal-related) ones :(
" colo wpgtk
" colorscheme wal
" colorscheme moonfly
" let g:moonflyTerminalColors = 1
colorscheme gruvbox
let g:gruvbox_termcolors = '16'

" Limelight
let g:limelight_conceal_ctermfg = '8'
" let g:airline_theme='wpgtk_alternate'
" let g:airline_theme='wal'
" let g:airline_theme='moonfly'
let g:airline_theme='gruvbox'


" Language server
" TODO: Add langs: vimscript, R, CSS
" set completeopt=menuone,noinsert,noselect
" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua << VIM_LUA

local on_attach = function(client)
  require'completion'.on_attach(client)
end
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- bashls
local S = {'clangd', 'pyright', 'sqls', 'texlab', 'rust_analyzer', 'bashls'}
for _, ls in ipairs(S) do require'lspconfig'[ls].setup{} end
-- require'lspsaga'.init_lsp_saga()
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
     }
}
VIM_LUA
" au BufEnter * lua require'completion'.on_attach()

let g:taboo_tab_format = "%f%m"
let g:taboo_renamed_tab_format = "%l"

let g:indentLine_setColors = 1
let g:indentLine_char = '-'

 " General options
 let g:presence_auto_update         = 1
 let g:presence_neovim_image_text   = "Neovim"
 let g:presence_main_image          = "neovim"
 let g:presence_debounce_timeout    = 10
 let g:presence_enable_line_number  = 0
 let g:presence_blacklist           = []
 let g:presence_buttons             = 1

 " Rich Presence text options
 let g:presence_editing_text        = "Editing %s"
 let g:presence_file_explorer_text  = "Browsing %s"
 let g:presence_git_commit_text     = "Committing changes"
 let g:presence_plugin_manager_text = "Managing plugins"
 let g:presence_reading_text        = "Reading %s"
 let g:presence_workspace_text      = "Working on %s"
 let g:presence_line_number_text    = "Line %s out of %s"

let g:mkdp_filetypes = ['markdown', 'vimwiki']

se nobackup " Save often :^)
se nowritebackup
se noswapfile " Swap files do literally nothing other than cause problems
se autochdir " Automatically change directory to dir of current file

se shortmess+=c
se virtualedit=block
se splitbelow
se pyx=3

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let $PAGER=''
se nocompatible
se hidden
se ttyfast
" Disable the timeout when non-modal keys (leader keys)
" are pressed (ie. c, f, custom leaders)
se notimeout

se lazyredraw " improve macro performance
se sessionoptions+=tabpages,globals
se shell=/bin/zsh
se foldcolumn=0 " Amount of empty space to the left of signcolumn/number line
se updatetime=250
" let base16colorspace=256
let mapleader ="\<Space>"

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" set signcolumn=number
se signcolumn=yes

" let $GIT_EDITOR = 'nvr -cc split --remote-wait'

" TODO: Map // to remove hlsearch

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

se wrap " Wrapping lines if they extend off the screen
se smartcase " Searches case-insensitively unless capitals are in the query
se undofile " Save undo history
se undodir=$XDG_DATA_HOME/nvim/undo

se cmdheight=1
se wildmenu
se wildmode=longest,full
se ruler
se scrolloff=200 " Keep the cursor in the center of the vim buffer
se scrollback=100000 " Terminal scrollback

se autoindent
se smartindent

" regex magic
se magic

se noshowmode
se showcmd
se mouse=a
" Use spaces for tabs
se expandtab
se tabstop=4
se shiftwidth=4
se softtabstop=0
se nosmarttab
"
se autoread
se ffs=unix,dos,mac
" Show current line number
se number
" Show other line numbers as indices separated from current line
se relativenumber

"highlight search
se hlsearch

se encoding=utf-8
filetype on
filetype indent on

" case-insensitive search
se ignorecase

se incsearch

"allow nvim to utilize global clipboard
se clipboard+=unnamedplus

"au SwapExists * let v:swapchoice = "o"

" File-type specific configuration
au BufRead,BufNewFile *.hex se ft=c
" Better systemd/config file syntax highlighting
au BufRead,BufNewFile *.conf,*.cfg,*.service*,*.timer*,*.godot,config,*rc,*.info,*.cir,*.CIR,*.cmp se ft=dosini
au BufRead,BufNewFile *.s,*lst se ft=arm
" I need syntax highlighting for my natural joins
let g:sql_type_default = 'pgsql'
au BufRead,BufNewFile *.css.* se ft=css
au BufRead,BufNewFile *.log*,*.txt se ft=log
au BufRead,BufNewFile CMakeLists.txt se ft=cmake
au BufRead,BufNewFile README,LICENSE,TODO,NEWS,FAQ,LEGACY se ft=markdown
au BufRead,BufNewFile *.*patch,*.diff se ft=gitsendemail
au BufRead,BufNewFile .gitattributes se ft=gitignore
au BufRead,BufNewFile *.rasi se ft=yaml
au BufRead,BufNewFile *.fut se ft=ocaml
au BufRead,BufNewFile *.python* se ft=python
au BufRead,BufNewFile *.reg se ft=registry
au BufRead,BufNewFile *.mesh se ft=glsl
au BufRead,BufNewFile *.rbxm se ft=xml
au BufRead,BufNewFile *.vcf se ft=ls

" use ls syntax highlighting for vimv buffers
au BufRead,BufNewFile /tmp/vimv.* se ft=ls | normal $T/
" jump straight to the file name in vimv if you are given the ability to edit
" the entire path (such as when called inside of lf)
" " Edit extension of current file in vimv
" au BufRead,BufNewFile /tmp/vimv.ext* normal $T.C

" spell checking for LaTeX, markdown, plaintext, and git commits
au FileType tex,markdown,gitcommit,vimwiki,text setlocal spell spelllang=en_us,es
" set spell spelllang=en_us,es

" Goyo's width will be the line limit in mutt.
" au BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80

" Enable Goyo by default for mutt writting
" au BufRead,BufNewFile /tmp/neomutt* :Goyo

" Don't show linenumber when in the vim terminal
" au TermOpen term://* set nonumber norelativenumber
" au TermClose term://* set number relativenumber

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
map <F12>_ :call TermOpen('lf')<cr><F12><F12>
map <F12>\ :call TermOpen(&shell,'v')<cr><F12><F12>
map <F12>\| :call TermOpen('lf','v')<cr><F12><F12>
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
map <leader>ch :!pandoc % -o $(rev <<< % \| cut -d'.' -f2- \| rev).html<cr><cr>
map <leader>cT :!pdflatex %<cr><cr>
map <leader>ct :!pandoc % -o $(rev <<< % \| cut -d'.' -f2- \| rev).txt<cr><cr>
map <leader>cp :!pandoc --highlight-style=breezedark % -o $(rev <<< % \| cut -d'.' -f2- \| rev).pdf<cr><cr>
map <leader>cm :!make<cr><cr>
map <leader>cM :!./test*.sh<cr><cr>

" Goyo
au! User GoyoEnter Limelight
au! User GoyoLeave Limelight!
map <leader>l :Goyo<cr>
map <leader>G :GrammarousCheck<cr>
" map <leader>e :CocCommand explorer<cr>

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
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" se cursorcolumn
" hi CursorColumn ctermbg=8

" function Vimty()
"         source $XDG_DATA_HOME/nvim/plug/vimty/vimty.vim
" endfunction
