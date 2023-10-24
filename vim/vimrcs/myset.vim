set expandtab            "设置tab键替换为tabstop规定的空格数
set tabstop=4
set shiftwidth=4         "设置tab的间隔
                         "set softtabstop=4
set sts=4
set showmatch            "在输入括号时光标会短暂地跳到与之相匹配的括号处
set wrap                 "设置自动折行
set textwidth=80         "设置自动换行的长度
set lbr
"set autoindent          "设置自动缩进
"set smartindent         "设置智能缩进
"set foldmethod=indent   "设置按缩进折叠代码
set foldmethod=syntax    "设置按语法折叠代码
"set foldlevel=99        "折叠层级
"nnoremap <space> za


"set guifont=Monospace
set guifont=:b:h16
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,GB18030,cp936,big5,euc-jp,euc-kr,latin1
set fileformat=unix
set helplang=cn          "帮助中文支持
set mouse=a              " 设置鼠标
set noeb                 " 去掉输入错误的提示声音
set confirm              " 在处理未保存或只读文件的时候，弹出确认
set langmenu=zh_CN.UTF-8
set scrolloff=3          " 光标移动到buffer的顶部和底部时保持3行距离

"自动补全配置
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

set rnu "设置相对行号
set nu "设置绝对行号
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
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
colorscheme industry "设置颜色主题
""set lines=35 columns=118
"set list "显示tab和空格
"set listchars=tab:>-,trail:. "设置tab和空格的显示 
"hi SpecialKey ctermfg=red guifg=red
