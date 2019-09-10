let g:configDir = $HOME . '/.config/nvim'


" {{{ Plugins and config
filetype off

call plug#begin(g:configDir.'/plugged')
    source $HOME/.dotfiles/vim/plugins.vimrc
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-ultisnips'
    " Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax'
    Plug 'w0rp/ale'
    " Plug 'wokalski/autocomplete-flow'
    Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
call plug#end()

" nvim-typescript
let g:nvim_typescript#diagnostics_enable=0

" ncm2
augroup ncm
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END
set completeopt=noinsert,menuone,noselect

" autocomplete-flow
let g:autocomplete_flow#insert_paren_after_function = 0

" ALE
let g:ale_fixers = {}
let g:ale_fixers['sh'] = ['shfmt', 'trim_whitespace']
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 1000
let g:ale_lint_on_text_changed = 'always'
" let g:ale_linters_ignore = {
" \ 'typescript': ['eslint'],
" \}
let g:ale_linters = {
    \ 'haskell': ['hlint', 'hdevtools', 'hfmt'],
    \ 'javascript': ['eslint'],
    \ 'typescript': ['eslint', 'tsserver'],
    \}
let g:ale_pattern_options = {
    \ 'node_modules': {'ale_linters': [], 'ale_fixers': []},
    \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
    \}
" \ 'lib': {'ale_linters': [], 'ale_fixers': []},
" }}}

" {{{ Settings
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set mouse=a
" }}}

source $HOME/.dotfiles/vim/general.vimrc

" {{{ Keymaps
imap <silent> <c-x><c-o> <Plug>(ncm2_manual_trigger)
nnoremap <leader>f :Files<cr>
nnoremap <leader>rc :so  ~/.config/nvim/init.vim<cr>
" }}}

" {{{ Hacks
if exists('g:gui_oni')
    " Statements here
     " overwrite oni mapping
    function! Unmap_gd(timer)
      nnoremap gd :bd<cr>
    endfunction
    call timer_start(1, 'Unmap_gd')
endif

try
  source ~/.vimrc.local
catch
  " No such file? No problem; just ignore it.
endtry
" }}}
