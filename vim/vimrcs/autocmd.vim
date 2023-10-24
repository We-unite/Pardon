autocmd BufReadPost,BufWritePre *.html,*.c,*.cpp,*.vim normal gg=G
"autocmd FileType * :normal gg=G<c-o><c-o>
autocmd Filetype c,cpp map <buffer><C-d> 0xx<esc>ta
autocmd Filetype python map <buffer><C-d> 0xx<esc>ta

"新建.c,.h,.sh,.java文件，自动插入文件头 
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
        call append(line(".")+6, "\# Created Time : ".strftime("%Y-%m-%d",localtime()))    
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
        call append(line(".")+6, "\# Created Time : ".strftime("%Y-%m-%d",localtime()))    
        call append(line(".")+7, "\##########################################################################" )
        call append(line(".")+8, "")
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."),   "  > File Name    : ".expand("%")) 
        call append(line(".")+1, "  > Encoding     : utf-8")
        call append(line(".")+2, "  > Author       : We-unite") 
        call append(line(".")+3, "  > Email        : weunite1848@gmail.com ") 
        call append(line(".")+4, "  > Created Time : ".strftime("%Y-%m-%d-%H:%M:%S",localtime()))
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

"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>

func CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!gcc -g -o %< %"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ -g -o %< %"
        exec "! ./%<"
        "elseif &filetype == 'java' 
    "    exec "!javac %" 
    "    exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    elseif &filetype == 'python'
        exec "!python %"
    endif
endfunc

"C,C++的调试
map <F8> :call RunGdb()<CR>

func RunGdb()
    exec "w"
    exec "!gdb ./%<"
endfunc
