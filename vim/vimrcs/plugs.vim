" Vundle插件管理器配置
set nocompatible	" 去除VIM一致性，必须
filetype off		" 必须

" 设置包括vundle和初始化相关的运行时路径"
set rtp+=/home/player/useful/bundle/Vundle.vim
call vundle#begin('/home/player/useful/bundle')

Plugin 'VundleVim/Vundle.vim'			" 启用vundle管理插件，必须
Plugin 'Valloric/YouCompleteMe'			" 代码补全插件
Plugin 'preservim/nerdtree'				" 文件目录树插件
Plugin 'Xuyuanp/nerdtree-git-plugin'	" nerdtree git支持
Plugin 'skywind3000/vim-terminal-help'	" vim-terminal-help插件
Plugin 'scrooloose/syntastic'			" 语法检查插件
Plugin 'github/copilot.vim'				" GitHub Copilot插件
Plugin 'voldikss/vim-translator'		" 翻译插件
Plugin 'yegappan/taglist'				" taglist插件
" Plugin 'Lokaltog/powerline',{'rtp':'powerline/bindings/vim/'}                " 状态栏信息插件
" Plugin 'neoclide/coc.nvim'            " coc.nvim插件

call vundle#end()
filetype plugin indent on				" 加载vim自带和插件相应的语法和文件类型相关脚本，必须

" YouCompleteMe
let g:ycm_global_ycm_extra_conf='/home/player/useful/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<C-c>'
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
highlight PMenu ctermfg=34 ctermbg=21 guifg=darkred guibg=darkblue
highlight PMenuSel ctermfg=21 ctermbg=34 guifg=darkblue guibg=darkred
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>gf :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
let g:ycm_min_num_of_chars_for_completion=3

" NERDTree
" autocmd vimenter * NERDTree "进入vim自动打开nerdtree
" 当nerdtree为当前标签页剩余唯一窗口时自动关闭
autocmd bufenter * if(winnr('$') ==1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | quit | endif 
" F2键开关文件目录树，注意shift+i切换是否显示隐藏文件
nmap <F2> :NERDTreeToggle<CR>
nmap T :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable  = '+'
let g:NERDTreeDirArrowCollapsible = '-'		" 修改树的显示图标
let g:NERDTreeWinPos='left'					" 窗口位置
let g:NERDTreeSize=10						" 窗口尺寸
let g:NERDTreeShowLineNumbers=1				" 窗口是否显示行号
let NERDTreeShowHidden=1                                                       " 显示隐藏文件
let NERDTreeIgnore = ['\.pyc$', '\.swp', '\.swo', '\.vscode', '__pycache__']   " 过滤: 所有指定文件和文件夹不显示
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif " 在每个标签页打开相同的文件树


" nerdtree-git-plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
			\ 'Dirty'     :'Dty',
			\ 'Modified'  :'M',
			\ 'Staged'    :'Sta',
			\ 'Untracked' :'U',
			\ 'Renamed'   :'R',
			\ 'Unmerged'  :'Umg',
			\ 'Deleted'   :'X',
			\ 'Ignored'   :'Ign',
			\ 'Clean'     :'Cl',
			\ 'Unknown'   :'?',
			\ }
let g:NERDTreeGitStatusShowIgnored = 1              " a heavy feature may cost much more time. default: 0
let g:NERDTreeGitStatusUntrackedFilesMode = 'all'   " a heavy feature too. default: normal

" vim-terminal-help
" set termwinsize=10*106
" let g:terminal_key = ''
" 设置光标在终端与编辑器间切换的快捷键

" syntastic
" YouCompleteMe插件对该插件支持过于优秀，一般不再需要配置，故废弃
let g:syntastic_python_checkers=['pylint']
let g:syntastic_python_pylint_args=['--disable=C0111,R0903,C0301']
" GNU as汇编语言语法检查，需要安装as86和ld86
let g:syntastic_asm_checkers=['as86']
" syntastic end

" powerline
let laststatus=2
let g:airlinr_powerline_fonts=1 " 使用官方打过补丁的字体
let g:Powerline_symbols='fancy'

" vim-translator
let g:translator_target_lang = 'zh'
let g:translator_source_lang = 'auto'
let g:translator_default_engines = ['google', 'youdao', 'bing', 'haici']
let g:translator_history_enable = v:true
let g:translator_window_type = 'popup' " 可选值为 'popup' 和 'preview'，默认为 'popup'
" Echo translation in the cmdline
nmap <silent> <Leader>t <Plug>Translate
vmap <silent> <Leader>t <Plug>TranslateV
" Display translation in a window
nmap <silent> <Leader>w <Plug>TranslateW
vmap <silent> <Leader>w <Plug>TranslateWV
" Close the translation window
nmap <silent> <Leader>c <Plug>TranslateC
" Replace the text with translation
nmap <silent> <Leader>r <Plug>TranslateR
vmap <silent> <Leader>r <Plug>TranslateRV
" Translate the text in clipboard
nmap <silent> <Leader>x <Plug>TranslateX


" 进行Taglist的设置
map <F3> :TlistToggle<CR>
map <F3> :silent Tlist<CR>					" 按下F3就可以呼出了
map <space>tl :silent Tlist<CR>				" 按下<space>tl就可以呼出了
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'	" 因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=1				" 让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=0					" 让taglist可以同时展示多个文件的函数列表
let Tlist_File_Fold_Auto_Close=0			" 非当前文件列表折叠隐藏
let Tlist_Exit_OnlyWindow=1					" 当taglist是最后一个分割窗口时，自动推出vim
let Tlist_Process_File_Always=1				" 是否一直处理tags.1:处理;0:不处理
let Tlist_Inc_Winwidth=1					" 不是一直实时更新tags，因为没有必要
" 每隔多少秒更新一次tags，如果为0则不更新
let Tlist_Update_Time=5
" 在每个标签页打开相同的函数列表
autocmd BufWinEnter * if getcmdwintype() == '' | silent TlistUpdate | endif
" 打开新标签页时自动打开函数列表
autocmd BufWinEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.IsTabTree()) | silent TlistToggle | endif
