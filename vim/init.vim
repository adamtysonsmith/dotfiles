" vim: set fdm=marker fmr={{{,}}} foldlevel=0:

let g:configDir = $HOME . '/.config/nvim'

" {{{ Plugins
filetype off

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

call plug#begin(g:configDir.'/plugged')
    source $HOME/.dotfiles/vim/plugins.vimrc
    Plug 'neomake/neomake'
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
call plug#end()
" }}}

" {{{ Plugin Config
" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#deoplete_onmni_patterns = get(g:, 'deoplete#force_omni_input_patterns', {})
let g:deoplete#deoplete_onmni_patterns.javascript = '[^. \t]\.\w*'

" Neomake
let g:neomake_javascript_enabled_makers= ['eslint']
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" }}}

" {{{ Autocmds
augroup neovim
    autocmd BufWritePost * Neomake
augroup END
" }}}

" {{{ Settings
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" }}}

source $HOME/.dotfiles/vim/general.vimrc

" {{{ Keymaps
nnoremap <leader>e :<c-u>Unite -buffer-name=CurrentBufferDirectory -start-insert -auto-resize file_rec/neovim:<c-r>=expand('%:p:h')<cr><cr>
" nnoremap <leader>f :<C-u>Unite -buffer-name=WorkingDirectory -start-insert -auto-resize file_rec/neovim:.<cr>
nnoremap <leader>f :FZF<cr>
nnoremap <leader>rc :so  ~/.config/nvim/init.vim<cr>
" }}}
