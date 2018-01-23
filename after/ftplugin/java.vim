" Only do this when not done yet for this buffer
if exists("b:MVGoodies_did_ftplugin")
    finish
endif
let b:MVGoodies_did_ftplugin = 1

if &ft == 'java'
    if MyVimGoodies#extensions#util#EclimLoaded()
      if MyVimGoodies#extensions#eclim#EclimAvailable()
          let projectName = eclim#project#util#GetCurrentProjectName()
          if projectName != ""
              let s:eclim = 1
              augroup MVGoodies_BE_java
                    autocmd! BufEnter <buffer>
                    autocmd  BufEnter <buffer>
                        \ call MyVimGoodies#util#vimmap('nnoremap <buffer>',
                        \   '<leader>P',':let @"=eclim#java#util#GetPackage()<cr>'
    \ . ':let @+=@" <cr> :let @*=@" <cr> :echo @"<cr>')
                    autocmd  BufEnter <buffer>
                        \   call MyVimGoodies#util#vimmap('nnoremap <buffer> <silent>',
                        \   '<leader>C'
            \ ,':call MyVimGoodies#extensions#eclim#EclimGoToClassDeclarationLine()<cr>')
                    autocmd  BufEnter <buffer>
                        \ call MyVimGoodies#util#vimmap('nnoremap <buffer>',
    \   '<leader>F',':let @"=eclim#java#util#GetPackage().".".expand("%:t:r")<cr>'
    \ . ':let @+=@" <cr> :let @*=@" <cr> :echo @"<cr>')
                    autocmd  BufEnter <buffer>
                        \ call MyVimGoodies#util#vimmap('nnoremap <buffer>',
                        \   '<leader>S',':JavaSearch<space>')
              augroup END
              if v:vim_did_enter
                   call MyVimGoodies#extensions#eclim#EclimGoToClassDeclarationLine()
              endif
          endif
      endif
        call MyVimGoodies#util#vimmap
                    \('nnoremap <buffer>','<leader>js',':JavaSearch<space>')
        call MyVimGoodies#util#vimmap
                    \('nnoremap <buffer>','<leader>jr',':JavaRename<space>')
        call MyVimGoodies#util#vimmap
                    \('nnoremap <buffer>','<leader>ji',':JavaImport<cr>')
        call MyVimGoodies#util#vimmap
                    \('nnoremap <buffer>','<leader>jn',':JavaNew<space>')
        call MyVimGoodies#util#vimmap
                    \('nnoremap <buffer>','<leader>jg',':JavaGet')
        call MyVimGoodies#util#vimmap
                    \('nnoremap <buffer>','<leader>jo',':JavaImportOrganize<cr>')
    endif
    if executable('git')
        call MyVimGoodies#util#vimmap('nmap <buffer>'
                    \ ,'<leader>G','<Plug>MVGGitDiffThisExtDiff')
    endif
    if executable('svn')
        call MyVimGoodies#util#vimmap('nmap <buffer>'
            \ ,'<leader>D'
            \ ,'<Plug>MVGSVNDiffThisIgnoreAllWS')
    endif
    if !exists("s:eclim")
        if executable("ctags")
            augroup CtagsJava
                au!
                autocmd  BufWritePost <buffer> call ctags#UpdateTags()
            augroup END
        endif
    endif
    " static snippets
    iabbrev <buffer> sysout System.out.println("");<left><left><left>
    inoreabbrev <buffer> sysou sysout
    inoreabbrev <buffer> syso sysout
    inoreabbrev <buffer> main public static void main(String[] args)<cr>{<cr>}<up><cr>
    inoreabbrev <buffer> pubs public static void ()<cr>{<cr>}<up><up><c-o>f(
    inoreabbrev <buffer> for for()<cr>{<cr>}<cr><up><up><up><c-o>f(<right>
    inoreabbrev <buffer> while while()<cr>{<cr>}<cr><up><up><up><c-o>f(<right>
    inoreabbrev <buffer> if if()<cr>{<cr>}<cr><up><up><up><c-o>f(<right>
    iabbrev <buffer> format String.format("")<left><left>
    inoreabbrev <buffer> fmt format
endif
