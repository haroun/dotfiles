" NOTE: source https://github.com/Shougo/shougo-s-github/blob/b2fbd1820cf0e45d9cd79a8d62bbb8cbeb49175d/vim/rc/ddu.toml
"
nnoremap <buffer> <CR>
    \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
nnoremap <buffer> <Space>
    \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
nnoremap <buffer> *
    \ <Cmd>call ddu#ui#ff#do_action('toggleAllItems')<CR>
nnoremap <buffer> i
    \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
nnoremap <buffer> <C-l>
    \ <Cmd>call ddu#ui#ff#do_action('refreshItems')<CR>
nnoremap <buffer> p
    \ <Cmd>call ddu#ui#ff#do_action('previewPath')<CR>
nnoremap <buffer> P
    \ <Cmd>call ddu#ui#ff#do_action('preview')<CR>
nnoremap <buffer> q
    \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
nnoremap <buffer> <C-h>
    \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
nnoremap <buffer> a
    \ <Cmd>call ddu#ui#ff#do_action('chooseAction')<CR>
nnoremap <buffer> o
    \ <Cmd>call ddu#ui#ff#do_action('expandItem',
    \ #{ mode: 'toggle' })<CR>
nnoremap <buffer> c
    \ <Cmd>call ddu#ui#ff#multi_actions('itemAction',
    \ #{ name: 'cd' })<CR>
nnoremap <buffer> d
    \ <Cmd>call ddu#ui#ff#do_action('itemAction',
    \ b:ddu_ui_name ==# 'filer' ? #{ name: 'trash' } : #{ name: 'delete' })<CR>
nnoremap <buffer> e
    \ <Cmd>call ddu#ui#ff#do_action('itemAction',
    \ #{ name: 'edit' })<CR>
nnoremap <buffer> E
    \ <Cmd>call ddu#ui#ff#do_action('itemAction',
    \ #{ params: eval(input('params: ')) })<CR>
nnoremap <buffer> v
    \ <Cmd>call ddu#ui#ff#do_action('itemAction',
    \ #{ name: 'open', params: #{ command: 'vsplit' } })<CR>
nnoremap <buffer> N
    \ <Cmd>call ddu#ui#ff#do_action('itemAction', #{ name: 'new' })<CR>
nnoremap <buffer> r
    \ <Cmd>call ddu#ui#ff#do_action('itemAction', #{ name: 'quickfix' })<CR>
nnoremap <buffer> yy
    \ <Cmd>call ddu#ui#ff#do_action('itemAction', #{ name: 'yank' })<CR>
nnoremap <buffer> gr
    \ <Cmd>call ddu#ui#ff#do_action('itemAction', #{ name: 'grep' })<CR>
nnoremap <buffer> u
    \ <Cmd>call ddu#ui#ff#do_action('updateOptions', #{
    \   sourceOptions: #{
    \     _: #{
    \       matchers: [],
    \     },
    \   },
    \ })<CR>
xnoremap <silent><buffer> <Space>
    \ :call ddu#ui#ff#do_action('toggleSelectItem')<CR>
