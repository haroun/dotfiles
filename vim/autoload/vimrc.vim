" NOTE: source https://github.com/Shougo/shougo-s-github/blob/1f70fac53a921e44769c3cb1c06bda2017d4e420/vim/autoload/vimrc.vim#L108
"
function! vimrc#check_syntax() abort
  if getfsize(@%) > 512 * 1000
    syntax off
  endif
endfunction

function! vimrc#on_filetype() abort
  if execute('filetype') !~# 'OFF'
    if !exists('b:did_ftplugin')
      runtime! after/ftplugin.vim
    endif

    return
  endif

  filetype plugin indent on
  syntax enable

  " NOTE: filetype detect does not work on startup
  filetype detect
endfunction
