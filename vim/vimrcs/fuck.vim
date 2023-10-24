set guitablabel=%{ShortTabLabel()}
function ShortTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
    let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction

set tabline=%!MyTabLine()
function MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " 选择高亮
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        " 设置标签页号 (用于鼠标点击)
        let s .= '%' . (i + 1) . 'T'
        " MyTabLabel() 提供完整路径标签 MyShortTabLabel 提供文件名标签
        let s .= ' %{MyShortTabLabel(' . (i + 1) . ')} '
    endfor
    " 最后一个标签页之后用 TabLineFill 填充并复位标签页号
    let s .= '%#TabLineFill#%T'
    " 右对齐用于关闭当前标签页的标签
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999Xclose'
    endif
    return s
endfunction
" 文件名标签
function MyShortTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let label = bufname (buflist[tabpagewinnr (a:n) -1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction
"完整路径标签
function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return bufname(buflist[winnr - 1])
endfunction

" 状态栏显示git分支函数
function! GitBranch()
    " 获取当前所在分支名，注意不要保留开头的*和行末的空符号
    let s:branch = system("git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \\(.*\\)/\\1/' | tr -d '\n' | tr -d ' '")
    return strlen(s:branch) ? 'b: '.s:branch.'> ' : ''
endfunction

set laststatus=2 "显示状态栏(默认值为 1，无法显示状态栏)
set statusline=%f%m%r%h%w\ >\ %{GitBranch()}%=\ <\ %{&ff}\ <\ %y\ <\ %l,%v\ <\ %p%%\ <\ lines=%L

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

"标签样式
"  TabLineFill  tab pages line, where there are no labels
hi TabLineFill term=none
hi TabLineFill ctermfg=DarkGrey
hi TabLineFill guifg=#777777
"  TabLineSel   tab pages line, active tab page label
hi TabLineSel term=inverse
hi TabLineSel cterm=none ctermfg=yellow ctermbg=Black
hi TabLineSel gui=none guifg=yellow guibg=Black
