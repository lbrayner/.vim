function! s:LinkifyLine(line)
    return '<a href="'.a:line.'">'.a:line.'</a>'
endfunction

function! s:LinkifyList(lines)
    if empty(a:lines)
        return a:lines
    endif
    return [s:LinkifyLine(a:lines[0])] + s:LinkifyList(a:lines[1:])
endfunction

function! s:Linkify(text)
    let lines = split(a:text,"\n")
    return join(s:LinkifyList(lines),"\n")
endfunction

function! s:LinkifyLastVisualSelection()
    let last_visual_selection = util#getVisualSelection()
    return s:Linkify(last_visual_selection)
endfunction

" Based on tpope's vim-surround
function! html#linkify(type) range
    let text = s:LinkifyLastVisualSelection()
    let reg = '"'
    let reg_save = getreg(reg)
    let reg_type = getregtype(reg)
    call setreg('"',text,a:type)
    silent exe 'norm! gv'.(reg == '"' ? '' : '"' . reg).'p`['
    call setreg(reg,reg_save,reg_type)
endfunction