" ~/.config/nvim/init.vim
" vi:ft=vim
"
" auto-install plug.vim if it isn't installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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
Plug 'tpope/vim-obsession'
" more language support
Plug 'sheerun/vim-polyglot'
" git integration
" Plug 'tpope/vim-fugitive'
" git commit info
Plug 'rhysd/committia.vim'
Plug 'VebbNix/lf-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'dixonary/vimty'
Plug 'neomake/neomake'
" completion
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" let g:deoplete#enable_at_startup = 1
Plug 'rhysd/vim-grammarous'
Plug 'dpelle/vim-LanguageTool'
let g:languagetool_jar='$HOME/.local/share/nvim/plug/vim-grammarous/misc/LanguageTool-4.1/languagetool-commandline.jar'
" Plug 'DanManN/vim-razer'
" Better vim markdown integration
Plug 'vimwiki/vimwiki'
" Plug 'jceb/vim-orgmode'
Plug 'KabbAmine/vCoolor.vim'
" Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'luochen1990/rainbow',
Plug 'tpope/vim-commentary'
" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:rainbow_active = 1
" Plug 'preservim/nerdtree'
" Plug 'jaxbot/semantic-highlight.vim'
call plug#end()

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep=''
let g:airline_left_alt_sep='/'
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_symbols.readonly=''
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.branch = ''
" Buffer tab line customization
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''

let g:airline_powerline_fonts = 1
let g:airline_statusline_ontop = 0
let g:airline_highlighting_cache = 1
let g:airline_skip_empty_sections = 0

let g:airline#extensions#coc#enabled = 1

let g:airline_theme='wpgtk_alternate'

let g:Hexokinase_highlighters = [
"\   'virtual',
"\   'sign_column',
"\   'background',
\   'backgroundfull',
"\   'foreground',
"\   'foregroundfull'
\ ]

" run neomake on file save
call neomake#configure#automake('w')
" call deoplete#custom#option({
"                         \ 'auto_complete_delay': 0,
"                         \ })

" se termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

color wpgtk
" color pywal

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let $PAGER=''
se nocompatible
se ttyfast
" improve macro performance
se lazyredraw
se shell=/bin/zsh
se background=dark
" add a litte margin on the left
se foldcolumn=1
let base16colorspace=256
let mapleader ="\<Space>"

" line number
se nu

se cmdheight=1
se wildmenu
se ruler
" scrolloff
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

" spell checking for LaTeX, markdown, plaintext, and git commits
autocmd FileType tex,markdown,gitcommit,text setlocal spell spelllang=en_us,es

" Goyo's width will be the line limit in mutt.
" autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80

" Enable Goyo by default for mutt writting
" autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

map <leader>u :!tmux splitw -v -p 40 urlscan %<cr>
map <leader><leader> :w<cr>
map <leader>s :setlocal spell! spelllang=en_us,es<cr>
map <leader>/ :Files<cr>
map <leader>k :r!pwgen<cr>

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
map <leader>f :'<,'>w !wc -w<cr>

" Document compiling
map <leader>ch :!tmux splitw -vd -p 20 pandoc % -o %.html<cr><cr>
map <leader>ct :!tmux splitw -vd -p 20 pdflatex %<cr><cr>
map <leader>cp :!tmux splitw -vd -p 20 pandoc % -o %.pdf<cr><cr>
map <leader>cm :!tmux splitw -vd -p 20 make<cr><cr>

map <leader>l :Goyo<cr>:Limelight!!<cr>
map <leader>g :GrammarousCheck<cr>

" Remap q to \ so that q can be used for quitting
noremap \ q
map q :q<cr>
" Replace the useless (sorry) ex-mode keybind
" with quick file exiting
map Q :wq<cr>
map <C-Q> :q!<cr>

map ZW :w<cr>

" remove white space at end of lines
" autocmd BufWritePre * %s/\s\+$//e

se cursorline
hi CursorLine term=bold ctermbg=8

" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" se cursorcolumn
" hi CursorColumn ctermbg=8

" function Vimty()
"         source ~/.local/share/nvim/plug/vimty/vimty.vim
" endfunction

" set statusline=%M%h%y %t %F %p%% %l/%L %=[%{&ff},%{&ft}] [a=%03.3b] [h=%02.2B] [%l,%v]
" set title titlelen=150 titlestring=%( %M%)%( (%{expand("%:p:h")})%)%( %a%) - %{v:servername}
" statusline
" se stl=
" se stl+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
" se stl+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
" se stl+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
" se stl+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
" se stl+=%#CursorIM#     " colour
" se stl+=%R
" se stl+=%#PmenuSel#
" se stl+=%#LineNr#
" se stl+=\ %f
" se stl+=\ %m
" se stl+=%=
" se stl+=%#Visual#       " colour
" se stl+=%{&paste?'\ PASTE\ ':''}
" se stl+=%{&spell?'\ SPELL\ ':''}
" se stl+=%#CursorColumn#
" se stl+=\ %y
" se stl+=\ %p%%
" se stl+=\ %l:%c
" se stl+=\ 
