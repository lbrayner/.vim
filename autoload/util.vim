function! util#vimmap(leftside,keyseq,keyseqtarget)
    if ! hasmapto(a:keyseqtarget)
        exec a:leftside." "a:keyseq." "a:keyseqtarget
    endif
endfunction

function! util#escapeFileName(filename)
    return substitute(a:filename, '\', '/', 'g')
endfunction

" Based on tpope's vim-surround
function! util#getVisualSelection()
    let ve = &virtualedit
    set virtualedit=
    let reg = 'v'
    let reg_save = getreg(reg)
    let reg_type = getregtype(reg)
    silent exe 'norm! gv"'.reg.'y'
    let visual_selection = getreg(reg)
    call setreg(reg,reg_save,reg_type)
    let &virtualedit = ve
    return visual_selection
endfunction

function! util#trivialHorizontalMotion()
    let col = getpos('.')[2]
    if col <= 1
        return 'h'
    endif
    return 'lh'
endfunction

function! util#truncateFilename(filename,maxlength)
    if len(a:filename) <= a:maxlength
        return a:filename
    endif
    if len(fnamemodify(a:filename,":t")) < a:maxlength
        " -1 (forward slash), -3 (three dots)
        let trunc_fname_head=strpart(fnamemodify(a:filename,":h"),0,
                    \a:maxlength-len(fnamemodify(a:filename,":t"))-1-3)
        return trunc_fname_head.".../".fnamemodify(a:filename,":t")
    endif
    if fnamemodify(a:filename,":e") != ""
        " -1 (a dot), -3 (three dots)
        let trunc_fname_tail=strpart(fnamemodify(a:filename,":t"),0,
                    \a:maxlength-len(fnamemodify(a:filename,":e"))-1-3)
        return trunc_fname_tail."....".fnamemodify(a:filename,":e")
    endif
    let trunc_fname_tail=strpart(fnamemodify(a:filename,":t"),0,a:maxlength-3)
    return trunc_fname_tail."..."
endfunction
