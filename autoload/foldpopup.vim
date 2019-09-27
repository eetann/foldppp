" File: foldpopup.vim
" Author: eetann

scriptencoding utf-8
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" echo foldclosed(26)

function! Foldpopup_filter(windid, key)
    " TODO: それぞれのキーを辞書に登録して任意に書き換えられるようにする
    if a:key == "\<C-k>"
        let s:oldstart = popup_getoptions(a:windid)['firstline']
        " TODO: スクロール量を変数にする
        let s:newstart = (s:oldstart - 1) > 0 ? (s:oldstart - 1) : 1
        call popup_setoptions(a:windid,{'firstline':s:newstart})
    elseif a:key == "\<C-j>"
        let s:oldstart = popup_getoptions(a:windid)['firstline']
        let s:newstart = line('$') > s:oldstart ? (s:oldstart + 1) : line('$')
        call popup_setoptions(a:windid,{'firstline':s:newstart})
    endif
endfunction

function! Show_fold()
    let s:fold_start = foldclosed('.')
    if s:fold_start != -1
        let s:fold_end = foldclosedend('.')
        " call popup_atcursor(getline(foldclosed('.'),foldclosedend('.')), {'pos': 'botleft','line': 'cursor-1', 'col': 'cursor','moved': 'WORD'})
        let s:fold_win = popup_atcursor(getline(s:fold_start, s:fold_end), {
                        \ 'pos': 'botleft',
                        \ 'line': 'cursor-1',
                        \ 'col': 'cursor',
                        \ 'moved': 'WORD',
                        \ 'maxheight': 20,
                        \ 'border': [],
                        \ 'filter': 'Foldpopup_filter',
                        \ })
        " TODO: maxheight を変数にする
    endif
endfunction

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
