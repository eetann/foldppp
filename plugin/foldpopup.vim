" File: foldpopup.vim
" Author: eetann

scriptencoding utf-8

if exists('g:loaded_foldpopup')
    finish
endif
let g:loaded_foldpopup = 1

let s:save_cpoptions = &cpoptions
set cpoptions&vim

command! -nargs=1 foldpopup call Show_fold(<f-args>)
nnoremap <Plug>(foldpopup)

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
