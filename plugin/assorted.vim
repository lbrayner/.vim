command! -bar -range=% RemoveTrailingSpaces
            \ call util#PreserveViewPort('keeppatterns '.<line1>.','.<line2>.'s/\s\+$//e')

" dictionaries
command! -nargs=1 SetDictionaryLanguage
            \ call assorted#SetDictionaryLanguage(0,<f-args>)
command! -nargs=1 SetGlobalDictionaryLanguage
            \ call assorted#SetDictionaryLanguage(1,<f-args>)

" file under the cursor

nnoremap <silent> <leader>fn
            \ :call assorted#CopyFileNameUnderCursor()<cr>
nnoremap <silent> <leader>fp
            \ :call assorted#CopyFileParentUnderCursor()<cr>
nnoremap <silent> <leader>ff
            \ :call assorted#CopyFileFullPathUnderCursor()<cr>
nnoremap <silent> <leader>fr
            \ :call assorted#CopyFilePathUnderCursor()<cr>

" other

vnoremap <silent> <leader><f3> :call assorted#FilterVisualSelection()<cr>
vnoremap <silent> <leader><f4> :call assorted#SourceVisualSelection()<cr>
vnoremap <silent> <leader>* <esc>:call assorted#SearchLastVisualSelectionNoMagic()<cr>

if has("win32")
    nnoremap <silent> <leader><F3> :call assorted#FilterLine()<cr>
endif

" XML

nnoremap <silent> [< :call assorted#NavigateXmlDepthBackward(-v:count1)<cr>
nnoremap <silent> ]> :call assorted#NavigateXmlDepth(-v:count1)<cr>

" overlength

nnoremap <silent> <leader><f2> :call assorted#HighlightOverLength()<cr>

" format

command! -range -nargs=0 CNPJFormat <line1>,<line2>call assorted#CNPJFormat()
command! -range -nargs=0 CPFFormat <line1>,<line2>call assorted#CPFFormat()
command! -range -nargs=0 DmyYmdToggle <line1>,<line2>call assorted#DmyYmdToggle()
command! -bar AllLowercase call util#PreserveViewPort('keeppatterns %s/.*/\L&/g')

" Save any buffer

command! -nargs=1 -bang -complete=file Save call assorted#Save(<f-args>,<bang>0)
