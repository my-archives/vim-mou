"=============================================================================
" File:     mou.vim
" Author:   Kissdry Cai <cfddream@gmail.com>
" URL:      https://github.com/cfddream/vim-mou
" Version:  0.0.1

if &cp || (exists("g:mou_loaded") && g:mou_loaded)
  finish
endif
let g:mou_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:mou_dir")
  let g:mou_dir = "Mou.app"
endif

function s:OpenMou()
  silent exe "!open -a " . g:mou_dir . " '%:p'"
  redraw!
endfunction

function s:QuitMou()
  let pid = system('ps ax | grep "[M]ou" | awk "{print \$1}"')
  if ! empty(pid)
    silent exe "!kill -TERM ".pid
    redraw!
  endif
endfunction

command! MouOpen :call s:OpenMou()
command! MouQuit :call s:QuitMou()

if has('autocmd')
  augroup mou_autoclose
    autocmd!
    autocmd VimLeave * :call <SID>QuitMou()
  augroup END
endif

let &cpo = s:save_cpo
unlet s:save_cpo

"vim:set et
