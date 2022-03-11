autocmd BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl,*.shader_test set syntax=glsl

autocmd BufNewFile,BufRead /home/mattst88/projects/mesa/* set expandtab tabstop=8 softtabstop=3 shiftwidth=3
autocmd BufNewFile,BufRead /home/mattst88/projects/piglit/* set noexpandtab tabstop=8 softtabstop=8 shiftwidth=8
autocmd BufNewFile,BufRead Makefile* set noexpandtab tabstop=8 softtabstop=8 shiftwidth=8
autocmd BufNewFile,BufRead *.mk set noexpandtab tabstop=8 softtabstop=8 shiftwidth=8

autocmd BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80 smarttab expandtab

set bg=dark
set modeline
set number relativenumber
set colorcolumn=+0
