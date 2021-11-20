" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

call ddc#custom#patch_global('sources', ['nvim-lsp'])
call ddc#custom#patch_global('sourceOptions', {
    \ '_': { 'matchers': ['matcher_head'] },
    \ 'nvim-lsp': {
    \   'mark': 'lsp',
    \   'forceCompletionPattern': '\.\w*|:\w*|->\w*' },
    \ })

call ddc#enable()
