" ~/.config/nvim/init.vim
" vi:ft=vim
"
" install plug.vim w/
"	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.local/share/nvim/plugged')
Plug 'deviantfero/wpgtk.vim'
"Plug 'itchyny/lightline.vim'
"let g:lightline = {
"	\ 'colorscheme': 'nord',
"	\ }
Plug 'jamessan/vim-gnupg'
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
" zig syntax support
Plug 'ziglang/zig.vim', { 'for': 'zig' }
" git integration
" Plug 'tpope/vim-fugitive'
" git commit info
Plug 'rhysd/committia.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'neomake/neomake'
" completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
"Plug 'DanManN/vim-razer'
"Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}
call plug#end()

" run neomake on file save
call neomake#configure#automake('w')
call deoplete#custom#option({
                        \ 'auto_complete_delay': 0,
                        \ })

" wpgtk colorscheme
colorscheme wpgtk

let $PAGER=''
se nocompatible
se ttyfast
"se termguicolors
" add a litte margin on the left
se foldcolumn=1
let base16colorspace=256
let mapleader ="\<Space>"

" line number
se nu

se wildmenu
se ruler
se scrolloff=3

" auto indent
se ai

" set smart indent
se si

se noshowmode
se showcmd
se mouse=a
se expandtab
se ts=4
se sw=8
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

autocmd SwapExists * let v:swapchoice = "o"

" set calcurse note files to be markdown
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown

" spell checking for LaTeX, markdown, and git commits
autocmd FileType tex,markdown,gitcommit setlocal spell spelllang=en_us,es

" Goyo's width will be the line limit in mutt.
autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80

" Enable Goyo by default for mutt writting
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

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

" Document compiling
map <leader>ch :!tmux splitw -vd -p 20 pandoc % -o %.html<cr><cr>
map <leader>ct :!tmux splitw -vd -p 20 pdflatex %<cr><cr>
map <leader>cp :!tmux splitw -vd -p 20 pandoc % -o %.pdf<cr><cr>
map <leader>cm :!tmux splitw -vd -p 20 make<cr><cr>

map <leader>l :Goyo<cr>:Limelight!!<cr>
map ZW :w<cr>

" remove white space at end of lines
" autocmd BufWritePre * %s/\s\+$//e

se cursorline

" set statusline=%M%h%y %t %F %p%% %l/%L %=[%{&ff},%{&ft}] [a=%03.3b] [h=%02.2B] [%l,%v]
" set title titlelen=150 titlestring=%( %M%)%( (%{expand("%:p:h")})%)%( %a%) - %{v:servername}
" statusline
se stl=
se stl+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
se stl+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
se stl+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
se stl+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
se stl+=%#CursorIM#     " colour
se stl+=%R
se stl+=%#PmenuSel#
se stl+=%#LineNr#
se stl+=\ %f
se stl+=\ %m
se stl+=%=
se stl+=%#Visual#       " colour
se stl+=%{&paste?'\ PASTE\ ':''}
se stl+=%{&spell?'\ SPELL\ ':''}
se stl+=%#CursorColumn#
se stl+=\ %y
se stl+=\ %p%%
se stl+=\ %l:%c
se stl+=\ 
