" set guifont=Monospace
set guifont=:b:h16
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,GB18030,cp936,big5,euc-jp,euc-kr,latin1
set fileformat=unix
set helplang=cn			" 帮助中文支持
set mouse=a				" 设置鼠标
set noeb				" 去掉输入错误的提示声音
set confirm				" 在处理未保存或只读文件的时候，弹出确认
set langmenu=zh_CN.UTF-8
set scrolloff=3			" 光标移动到buffer的顶部和底部时保持3行距离

set rnu " 设置相对行号
set nu  " 设置绝对行号
" Set cursor shape and color
if &term =~ "xterm"
	" INSERT mode
	let &t_SI = "\<Esc>[6 q" . "\<Esc>]12;blue\x7"
	" REPLACE mode
	let &t_SR = "\<Esc>[3 q" . "\<Esc>]12;black\x7"
	" NORMAL mode
	let &t_EI = "\<Esc>[2 q" . "\<Esc>]12;green\x7"
endif
" 1 -> blinking block  闪烁的方块
" 2 -> solid block  不闪烁的方块
" 3 -> blinking underscore  闪烁的下划线
" 4 -> solid underscore  不闪烁的下划线
" 5 -> blinking vertical bar  闪烁的竖线
" 6 -> solid vertical bar  不闪烁的竖线

syntax on
set cul
set cuc
set list						" 显示tab和空格
set listchars=tab:>-,trail:-	" 设置tab和空格的显示
colorscheme industry			" 设置颜色主题
autocmd VimEnter * hi CursorLine cterm=NONE ctermbg=darkblue ctermfg=NONE guibg=darkblue guifg=NONE
autocmd VimEnter * hi CursorColumn cterm=NONE ctermbg=darkblue ctermfg=NONE guibg=darkblue guifg=NONE
