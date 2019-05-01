let g:configDir = $HOME . '/.vim'

if (has("termguicolors"))
 set termguicolors
endif

syntax enable

colorscheme mysticaltutor
colorscheme OceanicNext
colorscheme OceanicNextLight

" {{{ Plugins
filetype off

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

call plug#begin(g:configDir.'/plugged')
    source $HOME/.dotfiles/vim/plugins.vimrc
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'w0rp/ale'
    Plug 'wokalski/autocomplete-flow'
call plug#end()
" }}}

" {{{ Plugin Config
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 0

" autocomplete-flow
let g:autocomplete_flow#insert_paren_after_function = 0

" ALE
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fix_on_save = 1
let g:ale_linters = {
    \ 'haskell': ['hlint', 'hdevtools', 'hfmt'],
    \ 'javascript': ['eslint', 'flow'],
    \ 'typescript': ['tslint']
    \}
" }}}

" {{{ Settings
set mouse=a
" }}}

source $HOME/.dotfiles/vim/general.vimrc

" {{{ Keymaps
nnoremap <leader>f :FZF<cr>
nnoremap <leader>rc :so  ~/.vimrc<cr>
" }}}
