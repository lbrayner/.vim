" http://vim.wikia.com/wiki/Run_a_command_in_multiple_buffers
function! tab#TabDo(command)
  let currentTab=tabpagenr()
  execute 'tabdo ' . a:command
  execute 'tabn ' . currentTab
endfunction

function! s:PrintTabs(currentTab)
    let l:currentTab=tabpagenr()
    if l:currentTab == a:currentTab
        echohl WarningMsg
    else
        echohl Directory
    endif
    let spacing = "  "
    echo spacing . l:currentTab " " . fnamemodify(getcwd(),":~")
    echohl None
    let currentWindow=winnr()
    for window in gettabinfo(l:currentTab)[0]["windows"]
        if win_id2win(window) == currentWindow
            let spacing = "> "
        else
            let spacing = "  "
        endif
        let buf_nr = getwininfo(window)[0]["bufnr"]
        let buf_type = getbufvar(buf_nr,"&bt")
        let prefix = "\t" . spacing
        if buf_type == "quickfix"
            echo prefix . "[quickfix]"
        else
            echo prefix . fnamemodify(getbufinfo(buf_nr)[0]["name"]
                    \,":~:.")
        endif
    endfor
endfunction

function! tab#GoToTab()
    let s:a_tab_nr=tabpagenr()
    echo "Current tabs:"
    " https://github.com/chrisbra/SaveSigns.vim
    " consider saving and restoring the signs
    sign unplace *
    noautocmd call tab#TabDo("call s:PrintTabs(s:a_tab_nr)")
    let tab = input("Go to tab (" . tabpagenr() . "): ")
    if tab == ""
        return
    endif
    exe "tabn " . tab
endfunction

function! tab#GoToLastTab()
    if ! exists("g:tab#lasttab")
        let g:tab#lasttab = tabpagenr()
    endif
    exe "tabn " . g:tab#lasttab
endfunction

" https://superuser.com/a/555047
function! tab#TabCloseRight(bang)
    let currrentTab = tabpagenr()
    while currrentTab < tabpagenr('$')
        exe 'tabclose' . a:bang . ' ' . (currrentTab + 1)
    endwhile
endfunction

function! tab#TabCloseLeft(bang)
    while tabpagenr() > 1
        exe 'tabclose' . a:bang . ' 1'
    endwhile
endfunction
