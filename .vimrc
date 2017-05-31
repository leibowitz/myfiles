set nocompatible
set backspace=indent,eol,start
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
let g:go_disable_autoinstall = 1
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Bundle 'Blackrush/vim-gocode'
Plugin 'vim-jp/vim-go-extra'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'

"autocmd FileType go autocmd BufWritePre <buffer> Fmt

call vundle#end()
filetype plugin indent on
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "gofmt"
"let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
set nu
"set autoindent
"set noexpandtab
"set smarttab
"set shiftwidth=4
"set tabstop=4
"set softtabstop=0
"set shiftround
"set autochdir
"set transp=15
"set autochdir
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
"let javascript_enable_domhtmlcss = 0
set autowrite
set tags=./.tags;/,$HOME/vimtags
"let g:easytags_dynamic_files = 2
set laststatus=2
"autocmd vimenter * NERDTree
autocmd BufReadPost * :DetectIndent 

"folding
"let php_folding=1
"set foldmethod=syntax

" show mode at the bottom
set showmode
" disable sound
set visualbell
" disable blinking cursor
set gcr=a:blinkon0
" display tab and trailing spaces
set list listchars=tab:\ \ ,trail:.
" highlight current line
"set cursorline  
" let edit mode go one character after the end
set virtualedit=onemore
" ruler on steroid
set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
" show search as typed
set incsearch
" and ignore case
set ignorecase
" unless uc specified
set smartcase
" highlight matches
"set showmatch
" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" highlight 80 characters limit
"let &colorcolumn=join(range(81,999),",")
"set textwidth=80
"set colorcolumn=+1
"search with ack plugin
"command Ack $arg web/js src AckER

syntax on
"execute pathogen#infect()
"call pathogen#infect()
"call pathogen#helptags()


highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=white
highlight DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black
highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=black
highlight DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black
"highlight DiffAdd cterm=NONE ctermfg=black ctermbg=Green gui=NONE guifg=bg guibg=Green
"highlight DiffDelete cterm=NONE ctermfg=white ctermbg=Red gui=NONE guifg=bg guibg=Red
"highlight DiffChange cterm=NONE ctermfg=white ctermbg=Yellow gui=NONE guifg=bg guibg=Yellow
"highlight DiffText cterm=NONE ctermfg=white ctermbg=Magenta gui=NONE guifg=bg guibg=Magenta

highlight ExtraWhitespace ctermbg=darkred guibg=darkred

"colorscheme delek
"colorscheme desert
colorscheme torte
"darkblue


hi DiffAdd      ctermfg=0 ctermbg=2 guibg='green'
hi DiffDelete   ctermfg=0 ctermbg=1 guibg='red'
hi DiffChange   ctermfg=0 ctermbg=3 guibg='yellow'


" Show trailing whitespace:
"match ExtraWhitespace /\s\+$/
" Show trailing whitespace and spaces before a tab:
"match ExtraWhitespace /\s\+$\| \+\ze\t/

" ignore white space in vimdiff
if &diff
    set diffopt+=iwhite
endif


"let loaded_netrw = 1
let g:netrw_menu = 0
let g:netrw_preview   = 1
let g:netrw_winsize   = 40
let g:netrw_liststyle = 3
let g:netrw_altv      = 1
let g:netrw_browse_split = 4
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

"let g:svndiff_autoupdate = 1

"let g:tagbar_type_javascript = {
"    \ 'ctagsbin' : 'jsctags'
"    \ }

" echo &filetype
"if &filetype == 'php'
"endif
"if &filetype == 'python'
"else
	" Show spaces used for indenting (so you use only tabs for indenting).
	"match ExtraWhitespace /^\t*\zs \+/
	" Show tabs that are not at the start of a line:
	"this regex is broken, doesnt do what it says

	"match ExtraWhitespace /[^\t]\zs\t\+/
"endif

" Gui Font
"set guifont=Consolas:h15
set guifont=Andale\ Mono:h14

" Switch off :match highlighting.
"match
au BufRead,BufNewFile *.twig set filetype=jinja
au BufRead,BufNewFile *.html.twig set filetype=htmljinja
au FileType json setlocal equalprg="python -m json.tool"

"autocmd BufWritePre * :%s/\s\+$//e
autocmd FileType js,php autocmd BufWritePre <buffer> :%s/\s\+$//e
" close NerdTREE if only buffer open
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" open bookmarks when starting
let NERDTreeShowBookmarks=1
" cd to bookmark directory
let NERDTreeChDirMode=2

" map keys for different stuff
"
" tagbar plugin
nmap <F8> :TagbarToggle<CR>

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction



function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()


autocmd FileType html setlocal tabstop=4
autocmd FileType html setlocal shiftwidth=4
autocmd FileType html setlocal softtabstop=4

autocmd FileType javascript setlocal tabstop=2
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType javascript setlocal softtabstop=2

autocmd FileType javascript setlocal tabstop=2
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType javascript setlocal softtabstop=2

autocmd FileType css setlocal tabstop=2
autocmd FileType css setlocal shiftwidth=2
autocmd FileType css setlocal softtabstop=2

autocmd FileType yaml setlocal tabstop=2
autocmd FileType yaml setlocal shiftwidth=2
autocmd FileType yaml setlocal softtabstop=2

autocmd FileType json setlocal tabstop=2
autocmd FileType json setlocal shiftwidth=2
autocmd FileType json setlocal softtabstop=2

autocmd FileType less setlocal tabstop=2
autocmd FileType less setlocal shiftwidth=2
autocmd FileType less setlocal softtabstop=2

autocmd FileType coffee setlocal tabstop=2
autocmd FileType coffee setlocal shiftwidth=2
autocmd FileType coffee setlocal softtabstop=2

autocmd FileType python setlocal tabstop=80
autocmd FileType python setlocal expandtab
autocmd FileType python setlocal smarttab
autocmd FileType python setlocal softtabstop=0
autocmd FileType python setlocal shiftwidth=4
