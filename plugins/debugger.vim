nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call win_gotoid(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call win_gotoid(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call win_gotoid(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call win_gotoid(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call win_gotoid(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call win_gotoid(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
nmap <S-F11> <Plug>VimspectorStepOut
nmap <leader><F4> <Plug>VimspectorRestart
nmap <leader><F5> :call vimspector#Continue()<CR>

nmap <leader>rcd <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

" packadd! vimspector

