filetype plugin indent on

" Settings {{{
" debugging
" set verbose=9
" set verbosefile=/home/chad/Documents/vim-debug.txt

set autoindent
set backspace=indent,eol,start
set cmdheight=1
set completeopt-=preview
set expandtab
set foldlevelstart=99
set foldmethod=syntax
set foldnestmax=4
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set noshowmode
set nowrap
set nowritebackup
set number
set relativenumber
set ruler
set shiftwidth=4
set showmatch
set smartcase
set smarttab
set softtabstop=4
set tabstop=4
set textwidth=100
set viewoptions=cursor,folds,slash,unix
set wildignorecase
set wildmenu
set list
set listchars=tab:\|\
set fileformat=unix " Possible fix to lots of odd line endings showing up
" Decided to set these because of here:
" https://www.reddit.com/r/vim/comments/7fqpny/slow_vim_scrolling_and_cursor_moving_in_iterm_and/
set regexpengine=1
set synmaxcol=200

" backup/persistance settings
set backupskip=/tmp/*,/private/tmp/*"
set backup
set writebackup
set noswapfile

" persist (g)undo tree between sessions
set undofile
set history=100
set undolevels=100

" Colors
syntax on
set background=dark
set termguicolors
source $HOME/.dotfiles/vim/colors.vimrc
" }}}

" {{{ Key Bindings
let mapleader = " "

noremap X :bd<cr>
noremap <M-,> zAzz

" Insert
" inoremap jk <Esc>

" Normal
" nnoremap 0 ^
" nnoremap ^ 0
nnoremap - dd
nnoremap <cr> i<cr><Esc>==
nnoremap gd :bd<cr>
nnoremap gn :bn<cr>
nnoremap Y y$
nnoremap <M-l> :bn<cr>
nnoremap <M-h> :bp<cr>
map <C-n> :NERDTreeToggle<CR>
noremap <M-o> :OpenSession<cr>
nnoremap gp :bp<cr>
nnoremap ¬ <c-w>l
nnoremap ˙ <c-w>h
nnoremap ˚ <c-w>k
nnoremap ∆ <c-w>j
nmap gsib gsi{
nmap QQ :q<cr>
" nmap Q! :q!<cr>

nmap s <Plug>(easymotion-s)

" Command
" Expand w!! to write a file with sudo
cmap w!! w !sudo tee > /dev/null %
" Expand %% to the directory path of the current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Visual
vnoremap < <gv
vnoremap > >gv

" {{{ Leader
nnoremap <leader><cr> :noh<cr>
nnoremap <leader>a :Rg 
nnoremap <leader>bo :BufOnly<cr>
nnoremap <leader>cl :call ConsoleLog()<cr>
nnoremap <leader>ctw :ClearTrailingWhitespace<cr>:noh<cr>
" Run command in current buffer's directory
nnoremap <leader>e :!cd %:p:h;
" nnoremap <leader>f in specific configs
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gp :echo @%<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>is ceimport<esc>f=cf(from <esc>f)x0j
nnoremap <leader>ia ceimport * as<esc>f=cf(from <esc>f)x0j
nmap <silent> <leader>j <Plug>(ale_next_wrap)
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
 " <leader>l --- lint namespaced mappings
nnoremap <leader>ld :ALEDetail<cr>
nnoremap <leader>li :ALEInfo<cr>
nnoremap <leader>lf :call ToggleAleFix()<cr>
nnoremap <leader>lt :ALEToggle<cr>
 " /<leader>l
nnoremap <leader>n :NERDTreeFind<cr>
nnoremap <leader>p :PrettierAsync<cr>
nnoremap <leader>o :OpenSession<cr>
nnoremap <leader>Q :q!<cr>
" nnoremap <leader>rc in specific configs
" Change javascript function statement to ES6
nnoremap <leader>rf dt(f)a =><esc>
nnoremap <leader>rs <esc>:syntax sync fromstart<cr>
nnoremap <leader>rw :Rg <c-r><c-w><cr>
nnoremap <leader>si :SortImport<cr>
vnoremap <leader>su :call ChangeSqlCase()<cr><cr>
" Surround with spaces
" nnoremap <leader>s lbi <esc>lea <esc>b
 " <leader>t --- typescript namespaced mappings
nnoremap <leader>tb :TagbarToggle<cr>
nnoremap <leader>td :TSDef<cr>
nnoremap <leader>to :TSDoc<cr>
nnoremap <leader>tt :TSType<cr>
 " /<leader>t
nnoremap <leader>U :UltiSnipsEdit<cr>
nnoremap <leader>v :e  ~/.dotfiles/vim/general.vimrc<cr>
nnoremap <leader>w :w!<cr>

" Visual
vnoremap <leader>cl :call ConsoleLog()<cr>
" Delete surrounding characters
vnoremap <leader>ds <esc>`>lx`<hx
" Surround with spaces
vnoremap <leader>s <esc>`>a <esc>`<i <esc>l
" }}}
" }}}

" {{{ Commands and functions
" Clear trailing whitespace
command! ClearTrailingWhitespace %s /\s\+$//g

command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

let g:VimTodoListsCustomKeyMapper = 'VimTodoListsCustomMappings'

function! VimTodoListsCustomMappings()
  nnoremap <buffer> o :VimTodoListsCreateNewItemBelow<CR>
  nnoremap <buffer> O :VimTodoListsCreateNewItemAbove<CR>
  nnoremap <buffer> <leader>j ddp
  nnoremap <buffer> <leader>k ddkp
  nnoremap <buffer> j :VimTodoListsGoToNextItem<CR>
  nnoremap <buffer> k :VimTodoListsGoToPreviousItem<CR>
  nnoremap <buffer> <CR> :VimTodoListsToggleItem<CR>
  vnoremap <buffer> <CR> :VimTodoListsToggleItem<CR>
  inoremap <buffer> <CR> <CR><ESC>:VimTodoListsCreateNewItem<CR>
  noremap <buffer> <leader>e :silent call VimTodoListsSetNormalMode()<CR>
endfunction

" Surround word with console.log statement
function! ConsoleLog()
    normal! yiwoconsole.log(
    normal! pA)
endfunction

function! ProfileStart()
    profile start profile.log
    profile func *
    profile file *
endfunction

function! ProfileEnd()
    profile pause
    noautocmd qall!
endfunction

function! ToggleAleFix()
    if g:ale_fix_on_save
        let g:ale_fix_on_save = 0
        echo "Ale fix on save off"
    else
        let g:ale_fix_on_save = 1
        echo "Ale fix on save on"
    endif
endfunction

augroup mygroup
    autocmd!
    " Git tweaks
    autocmd Filetype gitcommit setlocal textwidth=72
    
    autocmd Filetype vim setlocal foldmethod=marker foldlevel=0

    " Set filetype to docker for anything that starts with Dockerfile
    autocmd BufNewFile,BufRead Dockerfile* set syntax=dockerfile

    autocmd bufreadpre *.md setlocal textwidth=80

    autocmd Filetype javascript,typescript setlocal ts=2 sts=2 sw=2

    " NERDTree stuff
    autocmd bufenter * if @% == '__doc__' | nnoremap <silent> <buffer> q :bd<cr> | endif

    " NERDTree stuff
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " Rename tmux window to vim working directory
    " autocmd BufReadPost,FileReadPost,FocusGained,BufNewFile * call system("tmux rename-window ' vim " . fnamemodify(getcwd(), ':t') . "'")
    " Rename the tmux window on leaving vim
    " autocmd VimLeave * call system("tmux setw automatic-rename") " Consider adding FocusLost to this?

    " Automatically update diff on save of either file
    autocmd BufWritePost * if &diff == 1 | diffupdate | endif

    " Set yaml folds to 2 space
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd BufNewFile,BufRead *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html nnoremap <buffer> <leader>w :PrettierAsync<cr>:w!<cr>
    " fzf hide statusline
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler 
augroup END

augroup filetype_help
    autocmd!
    autocmd BufWinEnter * if &l:buftype ==# 'help' | nnoremap <silent> <buffer> q :bd<cr> | endif
augroup END

augroup filetype_quickfix
    autocmd!
    autocmd BufWinEnter quickfix nnoremap <silent> <buffer> q :cclose<cr>:lclose<cr>
    autocmd BufWinEnter quickfix nnoremap <silent> <buffer> <cr> :.cc<cr>
    autocmd BufWinEnter quickfix nnoremap <silent> <buffer> o :.cc<cr>
augroup END
" }}}

" {{{ Plugin Config
" gruvbox
" let g:gruvbox_italic = 1
" let g:gruvbox_bold = 1
" let g:gruvbox_contrast_dark = 'soft'
" colorscheme gruvbox

" onedark
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
colorscheme onedark

" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
" colorscheme OceanicNext

" vim-prettier
let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" vim-jsx-pretty
let g:vim_jsx_pretty_colorful_config = 1

" json stuff
let g:vim_json_syntax_concealcursor = 0

" indentLine json stuff
let g:indentLine_concealcursor = ""

" buftabline
let g:buftabline_show = 1
let g:buftabline_indicators = 1

" closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx,*.tsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'

" FZF
" CTRL-A CTRL-Q to select all and build quickfix list
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --ignore-file ~/.rgignore --column --line-number --no-heading --color=always --smart-case --follow '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" tagbar
let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'e:enums',
  \ ]
\ }

" vim-sort-imports
let g:import_sort_auto = 0

" auto-pairs
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutJump = ''

" Vim-Session
let g:session_directory = g:configDir.'/session'
let g:session_autoload = "no"
let g:session_autosave = "yes"
let g:session_verbose_messages = 0
let g:session_lock_enabled = 0
let g:session_default_to_last = 0
let g:session_default_name = fnamemodify(getcwd(), ':t')
set sessionoptions=blank,buffers,curdir,folds

" hindent
let g:hindent_line_length = 80

" vim-devicons
let g:webdevicons_enable_nerdtree = 1

" NERDTree
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMapJumpNextSibling = ''
let g:NERDTreeMapJumpPrevSibling = ''
let g:NERDTreeMinimalUI = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden = 1

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" UltiSnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.dotfiles/vim-ultisnips']
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" pgsql.vim
let g:sql_type_default = 'pgsql'

" Lightline
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \           [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
  \ }

" Airline
" if !exists("g:airline_symbols")
"     let g:airline_symbols = {}
" endif
" let g:airline_theme="cobalt2"
" let g:airline_powerline_fonts=1
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline#extensions#branch#empty_message  =  "no .git"
" let g:airline#extensions#whitespace#enabled    =  0
" let g:airline#extensions#syntastic#enabled     =  1
" let g:airline#extensions#tabline#enabled       =  1
" let g:airline#extensions#tabline#show_buffers  =  1
" let g:airline#extensions#tabline#show_tabs     =  0
" let g:airline#extensions#tabline#tab_nr_type   =  1 " tab number
" let g:airline#extensions#tabline#fnamecollapse =  1 " /a/m/model.rb
" let g:airline#extensions#hunks#non_zero_only   =  1 " git gutter

" vim-javascript
let g:javascript_plugin_flow = 1

" vim-jsx
let g:jsx_ext_required = 0

" GitGutter
let g:gitgutter_enabled = 1
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" EasyMotion
let g:EasyMotion_smartcase = 1
" }}}

" {{{ BUG WORKAROUNDS
" realign buffers when iterm goes fullscreen
augroup FixProportionsOnResize
    au!
    au VimResized * exe "normal! \<c-w>="
augroup END

" macos vs linux clipboard
if has("mac")
    set clipboard+=unnamed
else
    set clipboard=unnamedplus
endif

" make C-a, C-x work properly
set nrformats=

" potential lag fix
let g:matchparen_insert_timeout=1
" }}}

" {{{ COOL HACKS
" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     execute 'normal! g`"zvzz' |
                \ endif
augroup END

function! InitBackupDir()
    let l:backup = g:configDir . '/backup/'
    let l:swap = g:configDir . '/swap/'
    let l:undo = g:configDir . '/undo/'
    if exists('*mkdir')
        if !isdirectory(g:configDir)
            call mkdir(g:configDir)
        endif
        if !isdirectory(l:backup)
            call mkdir(l:backup)
        endif
        if !isdirectory(l:swap)
            call mkdir(l:swap)
        endif
        if !isdirectory(l:undo)
            call mkdir(l:undo)
        endif
    endif
    let l:missing_dir = 0
    if isdirectory(l:backup)
        execute 'set backupdir=' . escape(l:backup, ' ') . '/,.'
    else
        let l:missing_dir = 1
    endif
    if isdirectory(l:swap)
        execute 'set directory=' . escape(l:swap, ' ') . '/,.'
    else
        let l:missing_dir = 1
    endif
    if isdirectory(l:undo)
        execute 'set undodir=' . escape(l:undo, ' ') . '/,.'
    else
        let l:missing_dir = 1
    endif
    if l:missing_dir
        echo 'Warning: Unable to create backup directories:' l:backup 'and' l:swap ' and' l:undo
        echo 'Try: mkdir -p' l:backup
        echo 'and: mkdir -p' l:swap
        echo 'and: mkdir -p' l:undo
        set backupdir=.
        set directory=.
        set undodir=.
    endif
endfunction
call InitBackupDir()

" Underline function from here: http://vim.wikia.com/wiki/Underline_using_dashes_automatically
" Use like this :Underline =
function! s:Underline(chars)
  let chars = empty(a:chars) ? '-' : a:chars
  let nr_columns = virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)
" }}}
