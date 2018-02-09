" vim: set fdm=marker fmr={{{,}}} foldlevel=0:

filetype plugin indent on

" Settings {{{
set autoindent
set backspace=indent,eol,start
set cmdheight=1
set completeopt-=preview
set expandtab
set foldlevelstart=99
set foldmethod=manual
set foldnestmax=4
set hidden
set hls
set ignorecase
set incsearch
set ls=2
set noshowmode
set nowrap
set nowritebackup
set number
set relativenumber
set ruler
" set shell=/bin/bash
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

" backup/persistance settings
set backupskip=/tmp/*,/private/tmp/*"
set backup
set writebackup
set noswapfile

" persist (g)undo tree between sessions
set undofile
set history=100
set undolevels=100

syntax on
set background=dark
colorscheme gruvbox
" }}}

" {{{ Key Bindings
let mapleader = " "

" noremap ; :
" noremap : ;
noremap X :bd<cr>
noremap <M-,> zazz
" This mapping is taken care of by vim-easyclip
" map Y y$

" Normal
nnoremap 0 ^
" nnoremap , zazz
nnoremap <cr> i<cr><Esc>==
" nnoremap gd :BD<cr>
nnoremap gd :bd<cr>
nnoremap gn :bn<cr>
nnoremap Y y$
nnoremap <M-l> :bn<cr>
noremap <M-o> :OpenSession<cr>
" Remap gm to m because of vim-easyclip
nnoremap gm m
nnoremap gp :bp<cr>
nnoremap <M-h> :bp<cr>
nnoremap ¬ <c-w>l
nnoremap ˙ <c-w>h
nnoremap ˚ <c-w>k
nnoremap ∆ <c-w>j
nmap QQ :q<cr>
nmap Q! :q!<cr>

nmap s <Plug>(easymotion-s)

" Command
" Expand w!! to write a file with sudo
cmap w!! w !sudo tee > /dev/null %
" Expand %% to the directory path of the current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Visual
vnoremap < <gv
vnoremap > >gv

" Macros
let @e = 'cs(}$ireturn l%lkw=%'
let @s = 'ysa"}wcs"`'
let @o = 'o.do(console.log.bind(console=='


" {{{ Leader
nnoremap <leader>1 :tabp<return>
nnoremap <leader>2 :tabn<return>
nnoremap <leader>3 :tabm -1<return>
nnoremap <leader>4 :tabm +1<return>
nnoremap <leader><cr> :noh<cr>
nnoremap <leader>a :Ack!
nnoremap <leader>bo :BufOnly<cr>
nnoremap <leader>cl :call ConsoleLog()<cr>
nnoremap <leader>ctw :ClearTrailingWhitespace<cr>:noh<cr>
" nnoremap <leader>e in specific configs
" nnoremap <leader>f in specific configs
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gp :echo @%<cr>
nnoremap <leader>gd :Gdiff<cr>
nmap     <leader>j <Plug>(ale_next_wrap)
nmap     <leader>k <Plug>(ale_previous_wrap)
" nmap     <leader>k <Plug>(easymotion-k)
" nmap     <leader>j <Plug>(easymotion-j)
" nmap     <leader>k <Plug>(easymotion-k)
" nnoremap <leader>l :<c-u>Unite line<cr>
nnoremap <leader>p p=`]
nnoremap <leader>o :OpenSession<cr>
nnoremap <leader>Q :q!<cr>
" Replace word under cursor with word in register
nnoremap <leader>ra :%s/<c-r><c-w>/<c-r>"/g
" nnoremap <leader>rc in specific configs
" Change javascript function statement to ES6
nnoremap <leader>rf dt(f)a =><esc>
nnoremap <leader>S :%S /
nnoremap <leader>s lbi <esc>lea <esc>b
nnoremap <leader>U :UltiSnipsEdit<cr>
nnoremap <leader>v :e  ~/.dotfiles/vim/general.vimrc<cr>
nnoremap <leader>w :w!<cr>
" nnoremap <leader>y :<c-u>Unite history/yank<cr>

" Visual
vnoremap <leader>/ /\v
vnoremap <leader>// :S /
vnoremap <leader>cl :call ConsoleLog()<cr>
vnoremap <leader>ds <esc>`>lx`<hx
vnoremap <leader>S :%S /
vnoremap <leader>s <esc>`>a <esc>`<i <esc>l
" }}}
" }}}

" {{{ Commands and functions
" Clear trailing whitespace
command! ClearTrailingWhitespace %s /\s\+$//g

" Surround word with console.log statement
function! ConsoleLog()
    normal! yiwoconsole.log(
    normal! pA)
endfunction

augroup mygroup
    autocmd!
    " Git tweaks
    autocmd Filetype gitcommit setlocal textwidth=72
    " autocmd FileType javascript,jsx,javascript.jsx setlocal omnifunc=tern#Complete

    " Get rid of <cr> mapping in quickfix list
    " autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
    " Get rid of <cr> mapping in quickfix list for futitive's Ggrep command
    " autocmd QuickFixCmdPost *grep* cwindow | nnoremap <buffer> <CR> <CR>

    autocmd bufreadpre *.md setlocal textwidth=80

    " Prevent folds from opening beneath the cursor in insert mode
    " autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    " autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

    " NERDTree stuff
    " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " Rename tmux window to vim working directory
    autocmd BufReadPost,FileReadPost,FocusGained,BufNewFile * call system("tmux rename-window ' vim " . fnamemodify(getcwd(), ':t') . "'")
    " Rename the tmux window on leaving vim
    autocmd VimLeave * call system("tmux setw automatic-rename") " Consider adding FocusLost to this?

    " Automatically update diff on save of either file
    autocmd BufWritePost * if &diff == 1 | diffupdate | endif
augroup END
" }}}

" {{{ Plugin Config
" netrw
let g:netrw_liststyle=0         " thin (change to 3 for tree)
let g:netrw_banner=0            " no banner
let g:netrw_altv=1              " open files on right
let g:netrw_preview=1           " open previews vertically

" vim-foldtext
" let g:Foldtext_enable = 1

" vim-easyclip
" let g:EasyClipUseSubstituteDefaults = 1

" Vim-Session
let g:session_directory = g:configDir.'/session'
let g:session_autoload = "no"
let g:session_autosave = "yes"
let g:session_verbose_messages = 0
let g:session_lock_enabled = 0
let g:session_default_to_last = 0
" let g:session_command_aliases = 1
let g:session_default_name = fnamemodify(getcwd(), ':t')
set sessionoptions=blank,buffers,curdir,folds
" set sessionoptions=folds
" set sessionoptions+=curdir
" set sessionoptions+=buffers
" set sessionoptions+=tabpages

" hindent
let g:hindent_line_length = 80

" NERDTree
" let g:NERDTreeWinSize = 24
" let g:NERDTreeMinimalUI = 1
" let g:NERDTreeMapJumpNextSibling = ''
" let g:NERDTreeShowHidden = 1
" let g:NERDTreeShowLineNumbers = 1
" let g:NERDTreeIgnore=['node_modules$[[dir]]','.git$[[dir]]','build$[[dir]]','.sass-cache$[[dir]]','\.DS_Store$']

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" UltiSnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.dotfiles/vim-ultisnips']
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" Airline
if !exists("g:airline_symbols")
    let g:airline_symbols = {}
endif
let g:airline_theme="powerlineish"
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#empty_message  =  "no .git"
let g:airline#extensions#whitespace#enabled    =  0
let g:airline#extensions#syntastic#enabled     =  1
let g:airline#extensions#tabline#enabled       =  1
let g:airline#extensions#tabline#show_buffers  =  1
let g:airline#extensions#tabline#show_tabs     =  0
let g:airline#extensions#tabline#tab_nr_type   =  1 " tab number
let g:airline#extensions#tabline#fnamecollapse =  1 " /a/m/model.rb
let g:airline#extensions#hunks#non_zero_only   =  1 " git gutter

" Unite
" let g:unite_data_directory = g:configDir.'/.cache/unite'
" let g:unite_source_history_yank_enable=1
" let g:unite_source_rec_async_command =['ag', '--follow', '--nocolor', '--nogroup','--hidden', '-g']
" call unite#custom#profile('default', 'context', {
"             \     'start_insert': 1,
"             \     'prompt': '>> ',
"             \     'direction': 'botright'
"             \ })

" Polyglot
" let g:polyglot_disabled=['javascript.jsx', 'javascript']
" let g:jsx_ext_required = 0 " jsx highlighting in all js files and
" let g:used_javascript_libs = 'react' " enable react syntax

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

" Ack
if executable('ag')
  let g:ackprg = 'ag --hidden --vimgrep'
endif

" Startify
" let g:startify_bookmarks = [ {'y': '~/Sites/yaguara'}, {'d': '~/.dotfiles'} ]
" let g:startify_change_to_vcs_root = 1
" let g:startify_list_order = [
"             \ ['   Bookmarks:'],
"             \ 'bookmarks',
"             \ ['   My most recently used files'],
"             \ 'files',
"             \ ['   My most recently used files in the current directory:'],
"             \ 'dir',
"             \ ['   These are my sessions:'],
"             \ 'sessions',
"             \ ['   These are my commands:'],
"             \ 'commands',
"             \ ]
" }}}

" {{{ BUG WORKAROUNDS
" realign buffers when iterm goes fullscreen
augroup FixProportionsOnResize
    au!
    au VimResized * exe "normal! \<c-w>="
augroup END

" vim mode-switch lag fix
" if ! has("gui_running")
    "set ttimeoutlen=10
    "augroup FastEscape
    "    autocmd!
    "    au InsertEnter * set timeoutlen=10
    "    au InsertLeave * set timeoutlen=1000
    "augroup END
" endif

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

" fix bufexplorer bug with hidden
let g:bufExplorerFindActive=0
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

" Make search results appear in the middle of the screen
nnoremap <silent> <F4> :call <SID>SearchMode()<cr>
function! s:SearchMode()
    if !exists('s:searchmode') || s:searchmode == 0
        echo 'Search next: scroll hit to middle if not on same page'
        nnoremap <silent> n n:call <SID>MaybeMiddle()<cr>
        nnoremap <silent> N N:call <SID>MaybeMiddle()<cr>
        let s:searchmode = 1
    elseif s:searchmode == 1
        echo 'Search next: scroll hit to middle'
        nnoremap n nzz
        nnoremap N Nzz
        let s:searchmode = 2
    else
        echo 'Search next: normal'
        nunmap n
        nunmap N
        let s:searchmode = 0
    endif
endfunction

" If cursor is in first or last line of window, scroll to middle line.
function! s:MaybeMiddle()
    if winline() == 1 || winline() == winheight(0)
        normal! zz
    endif
endfunction

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
function! s:Underline(chars)
  let chars = empty(a:chars) ? '-' : a:chars
  let nr_columns = virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)
" }}}
