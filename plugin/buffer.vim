command! -nargs=1 BWipe call buffer#BWipe(<f-args>)
command! -nargs=1 BWipeFileType call buffer#BWipeFileType(<f-args>)
command! -nargs=1 BWipeHidden call buffer#BWipeHidden(<f-args>)
command! -nargs=0 BWipeNotLoaded call buffer#BWipeNotLoaded()
command! -nargs=1 BWipeForce call buffer#BWipeForce(<f-args>)
command! -nargs=1 BWipeForceUnlisted call buffer#BWipeForceUnlisted(<f-args>)
command! -nargs=0 BWipeNotReadable call buffer#BWipeNotReadable()

" Swap | File changes outside
" https://github.com/neovim/neovim/issues/2127
augroup AutoSwap
        autocmd!
        autocmd SwapExists *  call s:AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
augroup END

function! s:AS_HandleSwapfile (filename, swapname)
        " if swapfile is older than file itself, just get rid of it
        if getftime(v:swapname) < getftime(a:filename)
                call delete(v:swapname)
                let v:swapchoice = 'e'
        endif
endfunction
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
  \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

augroup Checktime
    autocmd!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved
                    \,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave *
                    \ sil! exe "checktime"
    endif
augroup END

" Save any buffer

function! s:SaveAs(name,bang)
    try
        let lazyr = &lazyredraw
        set lazyredraw
        let buf_nr = bufnr('%')
        let temp_file = tempname()
        silent exec 'write ' . fnameescape(temp_file)
        enew
        normal! dG
        let new_buf_nr = bufnr('%')
        silent exec "read " . fnameescape(temp_file)
        1d_
        let write = "w"
        if a:bang
            let write = "w!"
        endif
        silent exec write . " " . fnameescape(a:name)
    finally
        let &lazyredraw = lazyr
        call delete(temp_file)
    endtry
endfunction

command! -nargs=1 -bang -complete=file SaveAs call s:SaveAs(<f-args>,<bang>0)
