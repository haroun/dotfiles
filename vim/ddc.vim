" NOTE: reference https://github.com/Shougo/shougo-s-github/blob/master/vim/rc/ddc.toml
" Thank you Shougo: https://github.com/Shougo
call ddc#custom#patch_global('sources',
      \ ['around', 'file', 'rg'],
      \ )
call ddc#custom#patch_global('cmdlineSources', {
      \   ':': ['cmdline-history', 'cmdline', 'around'],
      \   '@': ['cmdline-history', 'input', 'file', 'around'],
      \   '>': ['cmdline-history', 'input', 'file', 'around'],
      \   '/': ['around', 'line'],
      \   '?': ['around', 'line'],
      \   '-': ['around', 'line'],
      \   '=': ['input'],
      \ })

call ddc#custom#patch_global('sourceOptions', #{
      \   _: #{
      \     ignoreCase: v:true,
      \     matchers: ['matcher_head', 'matcher_length'],
      \     sorters: ['sorter_rank'],
      \     converters: [
      \       'converter_remove_overlap', 'converter_truncate_abbr',
      \     ],
      \   },
      \   around: #{
      \     mark: 'A',
      \   },
      \   buffer: #{
      \     mark: 'B',
      \   },
      \   necovim: #{
      \    mark: 'vim'
      \   },
      \   cmdline: #{
      \     mark: 'cmdline',
      \     forceCompletionPattern: '\S/\S*|\.\w*',
      \     dup: 'force',
      \   },
      \   input: #{
      \     mark: 'input',
      \     forceCompletionPattern: '\S/\S*',
      \     isVolatile: v:true,
      \     dup: 'force',
      \   },
      \   line: #{
      \     mark: 'line',
      \   },
      \   nvim-lsp: #{
      \     mark: 'lsp',
      \     forceCompletionPattern: '\.\w*|:\w*|->\w*',
      \     dup: 'force',
      \   },
      \   file: #{
      \     mark: 'F',
      \     isVolatile: v:true,
      \     minAutoCompleteLength: 1000,
      \     forceCompletionPattern: '\S/\S*',
      \   },
      \   cmdline-history: #{
      \     mark: 'history',
      \     sorters: [],
      \   },
      \   shell-history: #{
      \     mark: 'shell'
      \   },
      \   zsh: #{
      \     mark: 'zsh',
      \     isVolatile: v:true,
      \     forceCompletionPattern: '\S/\S*',
      \   },
      \   rg: #{
      \     mark: 'rg',
      \     minAutoCompleteLength: 5,
      \     enabledIf: "finddir('.git', ';') != ''",
      \   },
      \ })

call ddc#custom#patch_global('sourceParams', #{
      \   buffer: #{
      \     requireSameFiletype: v:false,
      \     limitBytes: 50000,
      \     fromAltBuf: v:true,
      \     forceCollect: v:true,
      \   },
      \   file: #{
      \     filenameChars: '[:keyword:].',
      \   },
      \ })

call ddc#custom#patch_filetype(
      \ ['help', 'markdown', 'gitcommit'], 'sources',
      \ ['around', 'rg']
      \ )
call ddc#custom#patch_filetype(['ddu-ff-filter'], #{
      \   keywordPattern: '[0-9a-zA-Z_:#-]*',
      \   sources: ['line', 'buffer'],
      \   specialBufferCompletion: v:true,
      \ })

if has('nvim')
      call ddc#custom#patch_filetype(
            \ ['typescript', 'go', 'python'], 'sources',
            \ ['around', 'nvim-lsp']
            \ )
endif

call ddc#custom#patch_filetype(['FineCmdlinePrompt'], #{
      \   keywordPattern: '[0-9a-zA-Z_:#-]*',
      \   sources: ['cmdline-history', 'around'],
      \   specialBufferCompletion: v:true,
      \ })

" Use pum.vim
call ddc#custom#patch_global('autoCompleteEvents', [
      \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
      \ 'CmdlineEnter', 'CmdlineChanged', 'TextChangedT',
      \ ])

call ddc#custom#patch_global('ui', 'pum')

" For insert mode completion
inoremap <expr> <TAB>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#map#manual_complete()
inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
inoremap <C-o>   <Cmd>call pum#map#confirm()<CR>
inoremap <expr> <C-l>   ddc#map#extend(pum#map#confirm())
inoremap <expr> <C-x><C-f> ddc#map#manual_complete('path')
inoremap <expr> l
      \ pum#entered() ?
      \ '<Cmd>call pum#map#insert_relative(+1)<CR>' : 'l'
inoremap <expr> h
      \ pum#entered() ?
      \ '<Cmd>call pum#map#insert_relative(-1)<CR>' : 'h'
inoremap <expr> <C-e>
      \ ddc#map#insert_item(0, '<Cmd>call pum#map#cancel()<CR>')
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>

" For command line mode completion
cnoremap <expr> <Tab>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ exists('b:ddc_cmdline_completion') ?
      \ ddc#map#manual_complete() : nr2char(&wildcharm)
cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
cnoremap <C-o>   <Cmd>call pum#map#confirm()<CR>
cnoremap <expr> <C-e>
      \ ddc#map#insert_item(0, '<Cmd>call pum#map#cancel()<CR>')

" NOTE: Test for terminal completion
call ddc#custom#patch_filetype(['deol'], #{
      \   specialBufferCompletion: v:true,
      \   keywordPattern: '[0-9a-zA-Z_./#:-]*',
      \   sources: ['zsh', 'shell-history', 'around'],
      \ })

call ddc#enable()

" Hook add
nnoremap :       <Cmd>call CommandlinePre(':')<CR>:
nnoremap ?       <Cmd>call CommandlinePre('/')<CR>?
function! CommandlinePre(mode) abort
      " NOTE: It disables default command line completion!
      set wildchar=<C-t>
      set wildcharm=<C-t>
      cnoremap <expr><buffer> <Tab>
            \ pum#visible() ?
            \  '<Cmd>call pum#map#insert_relative(+1)<CR>' :
            \ exists('b:ddc_cmdline_completion') ?
            \   ddc#map#manual_complete() : "\<C-t>"
      " Overwrite sources
      if !exists('b:prev_buffer_config')
            let b:prev_buffer_config = ddc#custom#get_buffer()
      endif
      if a:mode ==# ':'
            call ddc#custom#patch_buffer('keywordPattern', '[0-9a-zA-Z_:#-]*')
      endif
      " TODO uncomment
      autocmd MyAutoCmd User DDCCmdlineLeave ++once call CommandlinePost()
      autocmd MyAutoCmd InsertEnter <buffer> ++once call CommandlinePost()
      call ddc#enable_cmdline_completion()
endfunction
function! CommandlinePost() abort
      silent! cunmap <buffer> <Tab>
      " Restore sources
      if exists('b:prev_buffer_config')
            call ddc#custom#set_buffer(b:prev_buffer_config)
            unlet b:prev_buffer_config
      else
            call ddc#custom#set_buffer({})
      endif
      set wildcharm=<Tab>
endfunction

" pum.vim
call pum#set_option('max_width', 80)
call pum#set_option('use_complete', v:true)
