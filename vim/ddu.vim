" NOTE: source https://github.com/Shougo/shougo-s-github/blob/b2fbd1820cf0e45d9cd79a8d62bbb8cbeb49175d/vim/rc/ddu.toml
"
nnoremap s<Space> <Cmd>Ddu
    \ -name=files file
    \ -source-option-path='`fnamemodify($MYVIMRC, ':p:h').'/rc'`'
    \ <CR>
nnoremap ss
    \ <Cmd>Ddu -name=files file_point file_old
    \ `finddir('.git', ';') != '' ? 'file_external' : 'file'`
    \ file -source-param-new
    \ -volatile -sync
    \ -ui-param-displaySourceName=short
    \ <CR>
nnoremap / <Cmd>Ddu
    \ -name=search line -resume=v:false
    \ -ui-param-startFilter
    \ <CR>
nnoremap * <Cmd>Ddu
    \ -name=search line -resume=v:false
    \ -input=`expand('<cword>')`
    \ -ui-param-startFilter=v:false
    \ <CR>
nnoremap ;g <Cmd>Ddu
    \ -name=search rg -resume=v:false
    \ -ui-param-ignoreEmpty
    \ -source-param-input=`input('Pattern: ', expand('<cword>'))`
    \ <CR>
nnoremap ;f <Cmd>Ddu
    \ -name=search rg -resume=v:false
    \ -ui-param-ignoreEmpty
    \ -source-param-input=`input('Pattern: ', expand('<cword>'))`
    \ -source-param-path=`input('Directory: ', '', 'dir')`
    \ <CR>
nnoremap n <Cmd>Ddu
    \ -name=search -resume
    \ -ui-param-startFilter=v:false
    \ <CR>
nnoremap ;r <Cmd>Ddu
    \ -name=register register
    \ -source-option-defaultAction=`col('.') == 1 ? 'insert' : 'append'`
    \ -ui-param-autoResize
    \ <CR>
nnoremap ;d <Cmd>Ddu
    \ -name=outline markdown
    \ -ui-param-ignoreEmpty -ui-param-displayTree
    \ <CR>
xnoremap <expr> ;r (mode() ==# 'V' ? '"_R<Esc>' : '"_d') .
    \ '<Cmd>Ddu -name=register register
    \ -source-option-defaultAction=insert
    \ -ui-param-autoResize<CR>'
nnoremap [Space]<Space> <Cmd>Ddu
    \ -name=search line -resume=v:false
    \ -source-param-range=window
    \ -ui-param-startFilter
    \ <CR>
" inoremap <C-q> <Cmd>Ddu
"     \ -name=register register
"     \ -source-option-defaultAction=append
"     \ -source-param-range=window
"     \ -ui-param-startFilter=v:false
"     \ <CR>
inoremap <C-q> <Cmd>call ddu#start(#{
    \   name: 'file',
    \   ui: 'ff',
    \   input: matchstr(getline('.')[: col('.') - 1], '\f*$'),
    \   sources: [
    \     #{ name: 'file', options: #{ defaultAction: 'feedkeys' } },
    \   ],
    \   uiParams: #{
    \     ff: #{
    \       startFilter: v:true,
    \       replaceCol: match(getline('.')[: col('.') - 1], '\f*$') + 1,
    \     },
    \   },
    \ })<CR>
" cnoremap <C-q> <Cmd>Ddu
"     \ -name=register register
"     \ -source-option-defaultAction=feedkeys
"     \ -source-param-range=window
"     \ -ui-param-startFilter=v:false
"     \ <CR><Cmd>call setcmdline('')<CR><CR>
cnoremap <C-q> <Cmd>call ddu#start(#{
    \   name: 'file',
    \   ui: 'ff',
    \   input: matchstr(getcmdline()[: getcmdpos() - 2], '\f*$'),
    \   sources: [
    \     #{ name: 'file', options: #{ defaultAction: 'feedkeys' } },
    \   ],
    \   uiParams: #{
    \     ff: #{
    \       startFilter: v:true,
    \       replaceCol: match(getcmdline()[: getcmdpos() - 2], '\f*$') + 1,
    \     },
    \   },
    \ })<CR><Cmd>call setcmdline('')<CR><CR>

" Hook source
call ddu#custom#alias('source', 'file_rg', 'file_external')

call ddu#custom#patch_global(#{
    \   ui: 'ff',
    \   sourceOptions: #{
    \     _: #{
    \       ignoreCase: v:true,
    \       matchers: ['matcher_substring'],
    \     },
    \     file_old: #{
    \       matchers: [
    \         'matcher_substring', 'matcher_relative',
    \       ],
    \     },
    \     file_external: #{
    \       matchers: [
    \         'matcher_substring',
    \       ],
    \     },
    \     file_rec: #{
    \       matchers: [
    \         'matcher_substring', 'matcher_hidden',
    \       ],
    \     },
    \     file: #{
    \       matchers: [
    \         'matcher_substring', 'matcher_hidden',
    \       ],
    \       sorters: ['sorter_alpha'],
    \     },
    \     markdown: #{
    \       sorters: [],
    \     },
    \   },
    \   sourceParams: #{
    \     file_external: #{
    \       cmd: ['git', 'ls-files', '-co', '--exclude-standard'],
    \     },
    \   },
    \   uiOptions: #{
    \     filer: #{
    \       toggle: v:true,
    \     },
    \   },
    \   uiParams: #{
    \     ff: #{
    \       filterSplitDirection: 'floating',
    \       previewFloating: v:true,
    \       highlights: #{
    \         floating: 'Normal',
    \       },
    \     },
    \     filer: #{
    \       split: 'no',
    \       sort: 'filename',
    \       sortTreesFirst: v:true,
    \       toggle: v:true,
    \     },
    \   },
    \   kindOptions: #{
    \     file: #{
    \       defaultAction: 'open',
    \     },
    \     word: #{
    \       defaultAction: 'append',
    \     },
    \     deol: #{
    \       defaultAction: 'switch',
    \     },
    \     action: #{
    \       defaultAction: 'do',
    \     },
    \     readme_viewer: #{
    \       defaultAction: 'open',
    \     },
    \   },
    \   actionOptions: #{
    \     narrow: #{
    \       quit: v:false,
    \     },
    \   },
    \ })
call ddu#custom#patch_local('files', #{
    \   uiParams: #{
    \     ff: #{
    \       split: has('nvim') ? 'floating' : 'horizontal',
    \     }
    \   },
    \ })

call ddu#custom#patch_global(#{
    \   sourceParams: #{
    \     file_rg: #{
    \       cmd: ['rg', '--files', '--glob', '!.git',
    \               '--color', 'never', '--no-messages'],
    \       updateItems: 50000,
    \     },
    \     rg: #{
    \       args: [
    \         '--ignore-case', '--column', '--no-heading', '--color', 'never',
    \       ],
    \     },
    \   }
    \ })
call ddu#custom#patch_global(#{
    \   filterParams: #{
    \     matcher_substring: #{
    \       highlightMatched: 'Search',
    \     },
    \   }
    \ })

call ddu#custom#action('kind', 'file', 'grep',
    \ { args -> GrepAction(args) })
function! GrepAction(args)
    " NOTE: param "path" must be one directory
    let path = a:args.items[0].action.path
    let directory = isdirectory(path) ? path : fnamemodify(path, ':h')

    call ddu#start(#{
        \   name: a:args.options.name,
        \   push: v:true,
        \   sources: [
        \     {
        \       name: 'rg',
        \       params: {
        \         path: path,
        \         input: input('Pattern: '),
        \       },
        \     },
        \   ],
        \ })
endfunction

" ddu-ui-filer
nnoremap <Space>f <Cmd>Ddu
    \ -name=filer-`win_getid()` -ui=filer -resume -sync file
    \ -source-option-path=`getcwd()`
    \ -source-option-columns=filename<CR>

" TODO uncomment
" autocmd MyAutoCmd TabEnter,WinEnter,CursorHold,FocusGained *
"     \ call ddu#ui#filer#do_action('checkItems')
