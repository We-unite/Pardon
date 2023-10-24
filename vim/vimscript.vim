" 主要参考 http://www.cnblogs.com/ma6174/archive/2011/12/10/2283393.html
" 额外添加了 ctags， YouCompleteMe等
"  主要特点

"1.按F5可以直接编译并执行C、C++、java代码以及执行shell脚本，按“F8”可进行C、C++代码的调试
"2.自动插入文件头 ，新建C、C++源文件时自动插入表头：包括文件名、作者、联系方式、建立时间等，读者可根据需求自行更改
"3.映射“Ctrl + A”为全选并复制快捷键，方便复制代码
"4.按“F2”可以直接消除代码中的空行
"5.“F3”可列出当前目录文件，打开树状文件目录
"6. 支持鼠标选择、方向键移动
"7. 代码高亮，自动缩进，显示行号，显示状态行
"8. 按“Ctrl + P”可自动补全
"9. []、{}、()、""、‘ ‘等都自动补全   --- 如果需要{}做函数形式的补全（右括号自动换行，加一个空行，光标定位到空行，可以看下面的修改提示）
"10. 使用YouCompleteMe提供C++的自动补全提示，效果类似 Visual Studio那种，可以解析系统头文件


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" """""""""""""" Suzzz  """""""""""""""""""""
"https://github.com/gmarik/Vundle.vim#about

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" let Vundle manage Vundle, required
Plugin "gmarik/Vundle.vim"
" plugin on GitHub repo    添加github上的vimn插件，形式非常简单
Plugin "tpope/vim-fugitive"
"语法检查
Plugin "scrooloose/syntastic"
"让 syntastic忽略 python 文件
let g:syntastic_ignore_files=[".*\.py$"]
"补全 python
Plugin "davidhalter/jedi"
Plugin "rstacruz/sparkup", {"rtp": "vim/"}
"  YouCompleteMe插件，很好的智能提示，基本达到 IDE 级别
Plugin "Valloric/YouCompleteMe"

call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
" YouCompleteMe 通过这个cm_global_ycm_extra_conf来获得补全规则，可以如下指定，也可以每次放置在工作目录
let g:ycm_global_ycm_extra_conf=‘~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py‘
"让YouCompleteMe同时利用原来的ctags
let g:ycm_collect_identifiers_from_tag_files = 1  

"  """"""""""""" By  ma6174  """""""""""""""""""""
" 显示相关  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
autocmd InsertEnter * se cul    " 用浅色高亮当前行  
"set ruler           " 显示标尺  
set showcmd         " 输入的命令显示出来，看的清楚些  
"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  
"set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离  
set novisualbell    " 不要闪烁(不明白)  
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  
set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)  
"set foldenable      " 允许折叠  
"set foldmethod=manual   " 手动折叠  
"set background=dark "背景使用黑色 
" 显示中文帮助
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif

set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8

"键盘命令

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"map <C-A> ggVGY
"map! <C-A> <Esc>ggVGY
"map <F12> gg=G
""去空行  
"nnoremap <F2> :g/^\s*$/d<CR> 

"比较文件  
nnoremap <C-F2> :vert diffsplit 

"列出当前目录文件  
map <F3> :tabnew .<CR>  

"打开树状文件目录  
map <C-F3> \be  

"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>

func! CompileRunGcc()

    exec "w"
    if &filetype == ‘c‘
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == ‘cpp‘
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == ‘java‘ 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == ‘sh‘
        :!./%
    endif
endfunc

"C,C++的调试

map <F8> :call Rungdb()<CR>

func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""实用设置

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 设置当文件被改动时自动载入
set autoread

" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>

"代码补全 
set completeopt=preview,menu 

"允许插件  
filetype plugin on

"共享剪贴板  
set clipboard+=unnamed 

"从不备份  
"set nobackup

"make 运行
:set makeprg=g++\ -Wall\ \ %

"自动保存
set autowrite

set ruler                   " 打开状态栏标尺
set cursorline              " 突出显示当前行
set magic                   " 设置魔术
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
" 设置在状态行显示的信息
"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\

"set foldcolumn=0
"set foldmethod=indent 
"set foldlevel=3 
"set foldenable              " 开始折叠

" 去掉输入错误的提示声音
set noeb

" 在处理未保存或只读文件的时候，弹出确认
set confirm

" 自动缩进
"set autoindent
"set cindent

" 在行和段开始处使用制表符
set smarttab

" 历史记录数
set history=1000

"禁止生成临时文件
set noswapfile

"搜索忽略大小写
set ignorecase

"搜索逐字符高亮
set hlsearch
set incsearch

"行内替换
set gdefault

"语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn

" 我的状态行显示的内容（包括文件类型和解码）
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]

" 总是显示状态行
set laststatus=2

" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

set selection=exclusive
set selectmode=mouse,key

" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0

" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3

" 为C程序提供自动缩进

" 高亮显示普通txt文件（需要txt.vim脚本）

au BufRead,BufNewFile *  setfiletype txt

"自动补全
"by Suzzz：  原作者这种设置，输入{会自动补全，并且中间插入一个空行，将光标定位到空行。这对于函数是OK的，但是使用花括号初始化数组、vector时就不方便了。所以改为现在这种。只是补全，然后光标在左右括号中间。
":inoremap { {<CR>}<ESC>O
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(‘)‘)<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair(‘}‘)<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(‘]‘)<CR>
:inoremap " ""<ESC>i
:inoremap ‘ ‘‘<ESC>i

function! ClosePair(char)
    if getline(‘.‘)[col(‘.‘) - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

set completeopt=longest,menu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" CTags的设定  

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let Tlist_Sort_Type = "name"    " 按照名称排序  
let Tlist_Use_Right_Window = 1  " 在右侧显示窗口  
let Tlist_Compart_Format = 1    " 压缩方式  
let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer  
let Tlist_File_Fold_Auto_Close = 0  " 不要关闭其他文件的tags  
let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树  
autocmd FileType java set tags+=D:\tools\java\tags  
"autocmd FileType h,cpp,cc,c set tags+=D:\tools\cpp\tags  
"let Tlist_Show_One_File=1            "不同时显示多个文件的tag，只显示当前文件的
"设置tags  
set tags=tags  
"set autochdir 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"其他东东

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"默认打开Taglist 
let Tlist_Auto_Open=1 

"""""""""""""""""""""""""""""" 

" Tag list (ctags) 

"""""""""""""""""""""""""""""""" 

let Tlist_Ctags_Cmd = ‘/usr/bin/ctags‘ 
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的 
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim 
let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
" minibufexpl插件的一般设置
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
