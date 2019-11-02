if !exists('g:FerretLoaded') || !g:FerretLoaded
    finish
endif

" Ignore submodules when searching the dotvim folder
if ferret#private#executable() =~# "^rg "
    cnoreabbrev <buffer> Rg Ack -g !pack<S-Left><S-Left><left>
endif
