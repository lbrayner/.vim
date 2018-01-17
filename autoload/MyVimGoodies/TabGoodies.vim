" http://vim.wikia.com/wiki/Run_a_command_in_multiple_buffers
function! MyVimGoodies#TabGoodies#TabDo(command)
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
    for window in gettabinfo(l:currentTab)[0]["windows"]
        echo "\t" . fnamemodify(getbufinfo(getwininfo(window)
                    \[0]["bufnr"])[0]["name"]
                    \,":~:.")
    endfor
endfunction

function! MyVimGoodies#TabGoodies#GoToTab()
    let s:a_tab_nr=tabpagenr()
    echo "Current tabs:"
    call MyVimGoodies#TabGoodies#TabDo("call s:PrintTabs(s:a_tab_nr)")
    let tab = input("Go to tab (" . tabpagenr() . "): ")
    if tab == ""
        return
    endif
    exe "tabn " . tab
endfunction

function! MyVimGoodies#TabGoodies#GoToLastTab()
    if ! exists("g:MyVimGoodies#TabGoodies#lasttab")
        let g:MyVimGoodies#TabGoodies#lasttab = tabpagenr()
    endif
    exe "tabn " . g:MyVimGoodies#TabGoodies#lasttab
endfunction
