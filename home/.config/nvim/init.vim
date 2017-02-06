" Vim-Plug plugin configuration
" https://github.com/junegunn/vim-plug#usage
call plug#begin('~/.config/nvim/plugged')

" File browser
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Fast file searching
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-scripts/ag.vim'

" File switching
Plug 'tpope/vim-projectionist'

" Code completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Colors
Plug 'altercation/vim-colors-solarized'

" Powerline clone
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Languages
Plug 'kchmck/vim-coffee-script'
Plug 'elixir-lang/vim-elixir'
Plug 'elmcast/elm-vim'
Plug 'tpope/vim-rails'
Plug 'slim-template/vim-slim'
Plug 'rodjek/vim-puppet'
Plug 'pangloss/vim-javascript'

" Testing
Plug 'janko-m/vim-test'
Plug 'scrooloose/syntastic'

" Formatting
Plug 'godlygeek/tabular'
Plug 'jgdavey/vim-blockle'
Plug 'scrooloose/nerdcommenter'

call plug#end()

" Disable Ex mode
nnoremap Q <nop>

" Enable line numbers
set number

" Automatically go to insert mode when switching to a terminal buffer
autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif

" Use ESC also in terminal to exit insert mode
tnoremap <Esc> <C-\><C-n>

" indent & tab stuff
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set expandtab
set list

" Spacing
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype slim setlocal ts=4 sts=4 sw=4
autocmd Filetype yml setlocal ts=4 sts=4 sw=4

" Folding
setlocal foldmethod=syntax

" Python
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" NERDTree
" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
	let explicitDirectory = isdirectory(a:directory)
	let directory = explicitDirectory || empty(a:directory)

	if explicitDirectory
		exe "cd " . fnameescape(a:directory)
	endif
	if strlen(a:directory) == 0
		return
	endif

	if directory
		NERDTree
		wincmd p
		bd
	endif

	if explicitDirectory
		wincmd p
	endif
endfunction

augroup AuNERDTreeCmd
autocmd AuNERDTreeCmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))

" Nvimux configuration
"
" Use ctr+a as fake tmux binding
" let g:nvimux_prefix='<C-a>'

" NERDtree
nmap <leader>n :NERDTreeToggle<CR>
let g:NERDTreeChDirMode=2

" CtrlP
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn)$|vendor\/bundle|bower_components|node_modules|tmp|_build',
			\ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.beam$\|\.class$\|\.o$\|\~$\',
			\ }

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.elm = '\.'
" tab for cycling through options
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" enter closes options if present and inserts linebreak
" apparently this has to be that complicated
inoremap <silent> <CR> <C-r>=<SID>close_and_linebreak()<CR>
function! s:close_and_linebreak()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

" Solarized
syntax enable
set background=dark
colorscheme solarized

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme= 'solarized'
let g:airline#extensions#tabline#enabled = 1

" Vim Test
function! SplitStrategy(cmd)
  botright new | call termopen(a:cmd) | startinsert
endfunction
let g:test#custom_strategies = {'terminal_split': function('SplitStrategy')}
let g:test#strategy = 'terminal_split'

function! test#ruby#rspec#executable()
  return 'docker-compose run app rspec'
endfunction

" Leader
" let mapleader="\"

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

" Elm-vim
let g:elm_format_autosave = 1
let g:elm_syntastic_show_warnings = 1
