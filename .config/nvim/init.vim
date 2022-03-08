set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
source ~/.config/nvim/coc.vim

call plug#begin()
Plug 'junegunn/vim-plug'
Plug 'bogado/file-line'
Plug 'editorconfig/editorconfig-vim'
Plug 'google/vim-searchindex'
Plug 'igankevich/mesonic'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'jamessan/vim-gnupg'
Plug 'javier-lopez/sprunge.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'saltstack/salt-vim'
Plug 'sheerun/vim-polyglot'
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/git_patch_tags.vim'
Plug 'Yggdroot/indentLine'
call plug#end()