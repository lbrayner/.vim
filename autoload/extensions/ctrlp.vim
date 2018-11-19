function! s:IsVimDir()
    if exists("g:vim_dir")
        let vim_dir = util#GetComparableNodeName(g:vim_dir)
        let cwd = util#GetComparableNodeName(getcwd())
        return vim_dir ==# cwd
    endif
    return 0
endfunction

function! extensions#ctrlp#ignore(item,type)
    if a:type ==# 'file'
        if has_key(g:extensions#ctrlp#ctrlp_custom_ignore,'file')
            if s:IsVimDir()
                let file = g:extensions#ctrlp#ctrlp_custom_ignore.file
                let file .= '|plugin/eclim\.vim$'
                return a:item =~# file
            endif
            return a:item =~# g:extensions#ctrlp#ctrlp_custom_ignore.file
        endif
    endif
    if a:type ==# 'link'
        if has_key(g:extensions#ctrlp#ctrlp_custom_ignore,'link')
            return a:item =~# g:extensions#ctrlp#ctrlp_custom_ignore.link
        endif
    endif
    if a:type ==# 'dir'
        if has_key(g:extensions#ctrlp#ctrlp_custom_ignore,'dir')
            if s:IsVimDir()
                let dir = g:extensions#ctrlp#ctrlp_custom_ignore.dir
                let dir .= '|(eclim|pack)$'
                return a:item =~# dir
            endif
            return a:item =~# g:extensions#ctrlp#ctrlp_custom_ignore.dir
        endif
    endif
    return 0
endfunction
