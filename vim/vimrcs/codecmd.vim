set expandtab			" 设置tab键替换为tabstop规定的空格数
set tabstop=4
set shiftwidth=4		" 设置tab的间隔
set softtabstop=4
autocmd FileType asm,nasm,vim,sh,makefile set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

set showmatch			" 在输入括号时光标会短暂地跳到与之相匹配的括号处
set nowrap				" 设置自动折行

set textwidth=500		" 设置自动换行的长度
set lbr					" 设置自动换行
set foldmethod=syntax	" 设置按语法折叠代码
set nofoldenable		" 在打开文件时不要折叠

" 自动补全配置
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" 要求格式化之后的代码不要移动光标，并且不要删除换行符和空行，保留原来的视图
autocmd BufReadPost,BufWritePre *.html,*.vim,*.sh,*.py normal! g1G=G`"z<CR>
" 在保存时自动使用clang-format格式化代码
augroup FormatAutocmd
	autocmd!
	autocmd BufWritePre *.c,*.cpp,*.h :let save_cursor = getpos(".")
	autocmd BufWritePre *.c,*.cpp,*.h :normal! ggVG
	autocmd BufWritePre *.c,*.cpp,*.h :ClangFormat
	autocmd BufWritePost *.c,*.cpp,*.h :call setpos('.', save_cursor)
augroup END
" 定义ClangFormat命令
command! -nargs=0 ClangFormat :silent %!clang-format -style="{IndentWidth: 4}"
" 映射gg=G到ClangFormat
autocmd FileType c,h,cpp,hpp,cc nnoremap <buffer> gg=G :ClangFormat<CR>
" cmake使用cmake-format格式化
autocmd FileType cmake nnoremap <buffer> gg=G :silent !cmake-format % -i<CR><CR>L

" 新建.c/.cpp/.sh/.py文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh exec ":call SetTitle()"
func SetTitle()
	if &filetype == 'sh'
		call setline(1,"#!/bin/bash")
		call append(line("."),   "" )
		call append(line(".")+1, "\##########################################################################" )
		call append(line(".")+2, "\# File Name    : ".expand("%"))
		call append(line(".")+3, "\# Encoding     : utf-8")
		call append(line(".")+4, "\# Author       : We-unite")
		call append(line(".")+5, "\# Email        : weunite1848@gmail.com")
		call append(line(".")+6, "\# Created Time : ".strftime("%Y-%m-%d %H:%M:%S",localtime()))
		call append(line(".")+7, "\##########################################################################" )
		call append(line(".")+8, "")
	elseif &filetype =='py'
		call setline(1,"#!/usr/bin/env python")
		call append(line("."),   "" )
		call append(line(".")+1, "\##########################################################################" )
		call append(line(".")+2, "\# File Name    : ".expand("%"))
		call append(line(".")+3, "\# Encoding     : utf-8")
		call append(line(".")+4, "\# Author       : We-unite")
		call append(line(".")+5, "\# Email        : weunite1848@gmail.com")
		call append(line(".")+6, "\# Created Time : ".strftime("%Y-%m-%d %H:%M:%S",localtime()))
		call append(line(".")+7, "\##########################################################################" )
		call append(line(".")+8, "")
	else
		call setline(1, "/*************************************************************************")
		call append(line("."),   "  > File Name    : ".expand("%"))
		call append(line(".")+1, "  > Encoding     : utf-8")
		call append(line(".")+2, "  > Author       : We-unite")
		call append(line(".")+3, "  > Email        : weunite1848@gmail.com ")
		call append(line(".")+4, "  > Created Time : ".strftime("%Y-%m-%d %H:%M:%S",localtime()))
		call append(line(".")+5, " ************************************************************************/")
		call append(line(".")+6, "")
		if &filetype == 'cpp'
			call append(line(".")+7, "#include <iostream>")
			call append(line(".")+8, "using namespace std;")
			call append(line(".")+9, "")
		elseif &filetype == 'c'
			call append(line(".")+7, "#include <stdio.h>")
			call append(line(".")+8, "#include <stdlib.h>")
			call append(line(".")+9, "")
		endif
	endif
	" 光标移动到文件末尾
	normal G
endfunc

" C，C++编译运行
map <leader>r :call CompileRunGcc()<CR>
func CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!gcc -g -o %< %"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ -g -o %< %"
		exec "! ./%<"
	elseif &filetype == 'sh'
		:!./%
	elseif &filetype == 'python'
		exec "!python %"
	endif
endfunc

" C,C++调试
map <leader>d :call RunGdb()<CR>
func RunGdb()
	exec "w"
	exec "!gdb ./%<"
endfunc
