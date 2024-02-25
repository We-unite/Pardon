map - dd
map H 0
map J :<C-u>exe "normal! ".v:count1*10."j"<CR>
map K :<C-u>exe "normal! ".v:count1*10."k"<CR>
map L $
nmap <leader>c <c-w><c-o>          "关闭除当前窗口的所有页面
nmap <c-s> :w !sudo tee %<cr>L<cr>
nmap <leader>p <c-x><c-f>          "补全路径
" nmap <C-tab> :tabn<CR>
nmap <tab> :tabp<CR>
" nmap <alt-tab> :tabnew<CR>
" map <space>= <buffer><esc>:vertical resize +5<cr>
" map <space>- <esc>:vertical resize -5<cr>

nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
nnoremap <M-6> 6gt
nnoremap <M-7> 7gt
nnoremap <M-8> 8gt
nnoremap <M-9> 9gt
nnoremap <M-0> :tablast<CR>

" 光标在页面间切换
nnoremap <space>h <C-w><C-h>
nnoremap <space>j <C-w><C-j>
nnoremap <space>k <C-w><C-k>
nnoremap <space>l <C-w><C-l>

" 复制粘贴
vnoremap <C-y> "+y
nnoremap <C-p> "+p
