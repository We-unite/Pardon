这里是我自己用的一些小零件的暂存。

```plaintext
.
├── mypath                   # 个人使用内容
│   ├── ast.sh               # 使用clang打印c/cpp的ast树
│   ├── clang-tidy-check.sh  # 使用clang-tidy的指定规则检查代码
│   ├── compile.sh           # 使用ohos ndk进行cmake交叉编译
│   ├── compile-tiny.sh      # 使用ohos ndk对单个c/cpp文件交叉编译
│   ├── dif.sh               # 使用diff工具对比两个文件的差别
│   ├── exe.sh               # 对本路径下的脚本创建无后缀文件，方便日常使用
│   ├── gitadd.sh            # （在服务器上）快速添加一个远程库
│   ├── gui.py               # 在Linux下绘制ohos机器人得到的地图
│   ├── md2html.sh           # 使用pandoc将md文件转换为html文件
│   ├── search.sh            # 在当前路径下所有文件中查找指定内容
│   └── tokei                # 使用tokei统计代码行数
├── README.md
├── tools
│   ├── compile_vim.sh       # 自己编译vim
│   └── .clang-format        # clang-format配置文件
└── vim
    ├── vimrc                # vim配置文件，放置在/etc/vim/目录下
    └── vimrcs
        ├── codecmd.vim
        ├── keybind.vim
        ├── match.vim
        ├── myset.vim
        ├── plugs.vim
        └── statusline.vim
```
