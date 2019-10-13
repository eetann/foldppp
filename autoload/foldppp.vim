" File: foldppp.vim
" Author: eetann

scriptencoding utf-8
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" help の *popup-filter* と *popup_menu-shortcut-example* 参考
function! s:foldppp_filter(windid, key) abort
    " TODO: それぞれのキーを辞書に登録して任意に書き換えられるようにする
    " TODO: G、gg、一時的なpppwinサイズの変更等のマッピング
    if a:key ==# "\<C-k>"
        let s:oldstart = popup_getoptions(a:windid)['firstline']
        " TODO: スクロール量を変数にする
        " TODO: 不必要なスクロールはしない
        let s:newstart = (s:oldstart - 1) > 0 ? (s:oldstart - 1) : 1
        call popup_setoptions(a:windid,{'firstline':s:newstart})
        return 1
    elseif a:key ==# "\<C-j>"
        let s:oldstart = popup_getoptions(a:windid)['firstline']
        let s:newstart = line('$') > s:oldstart ? (s:oldstart + 1) : line('$')
        call popup_setoptions(a:windid,{'firstline':s:newstart})
        return 1
    elseif a:key ==# 'x'
        call popup_close(a:winid)
        return 1
    endif
    return 0
endfunction

function! foldppp#Show_fold() abort
    let s:fold_start = foldclosed('.')
    if s:fold_start != -1
        let s:fold_end = foldclosedend('.')
        let s:fold_win = popup_atcursor(getline(s:fold_start, s:fold_end), {
                        \ 'pos': 'botleft',
                        \ 'line': 'cursor-1',
                        \ 'col': 'cursor',
                        \ 'moved': 'WORD',
                        \ 'maxheight': g:foldppp_maxheight,
                        \ 'border': [],
                        \ 'filter': function('s:foldppp_filter'),
                        \ })
        " TODO: maxheight を変数にする
    endif
endfunction

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
