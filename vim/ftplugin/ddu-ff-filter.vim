" NOTE: source https://github.com/Shougo/shougo-s-github/blob/b2fbd1820cf0e45d9cd79a8d62bbb8cbeb49175d/vim/rc/ddu.toml
"
noremap <buffer> <CR>
    \ <Esc><Cmd>call ddu#ui#ff#close()<CR>
nnoremap <buffer> <CR>
    \ <Cmd>call ddu#ui#ff#close()<CR>
