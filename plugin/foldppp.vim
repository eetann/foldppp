" File: foldppp.vim
" Author: eetann
" call dein#add('~/.vim/my_plugins/foldppp')

scriptencoding utf-8

if exists('g:loaded_foldppp')
    finish
endif
let g:loaded_foldppp = 1

let s:save_cpoptions = &cpoptions
set cpoptions&vim

let g:foldppp_maxheight = get(g:,'foldppp_maxheight', 30)

command! -nargs=0 Foldppp call foldppp#Show_fold()
noremap <unique> <Plug>(foldppp) :<C-u>call foldppp#Show_fold()<CR>

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
