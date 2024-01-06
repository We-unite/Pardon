"各类符号自动匹配
inoremap { {<CR>}<ESC>O
" :inoremap { {}<ESC>i
" :inoremap } <c-r>=ClosePair('}')<CR>
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "<Right>"
    else
        return a:char
    endif
endfunction
