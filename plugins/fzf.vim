" fzf confiuration
let $FZF_DEFAULT_COMMAND = 'fd -t f -H'
let $FZF_DEFAULT_OPTS = '--border --reverse --inline-info'
let g:fzf_layout = { 'window': 'FzfFloatingCenteredWindow' }
let g:fzf_buffers_jump = 1
nnoremap <silent> <leader><leader> :Files<CR>
nnoremap <M-l> :Lines <C-R><C-w><CR>

" refine quickfix results
command! RefineQuickfix call fzf#run({
      \ 'source': map(getqflist(), function('<sid>qf_to_fzf')),
      \ 'down':   '20',
      \ 'sink*':   function('<sid>fzf_to_qf'),
      \ 'options': '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all --prompt "quickfix> "',
      \ 'window': 'FzfQuickfixFloatingWindow',
      \ })

command! FzfFloatingCenteredWindow call s:fzf_floating_window({
      \ 'width': 150,
      \ 'height': 20,
      \ 'relative': 'editor',
      \ 'anchor': 'SW',
      \ 'row': (&lines/2) + 10,
      \ 'col': (&columns/2) - 75
      \})

" Matches the height of the quickfix window and places the floating window at
" the bottom of the screen.
" The idea is to make it look like the quickfix window itself is being edited
command! FzfQuickfixFloatingWindow call s:fzf_floating_window({
      \ 'height': min([20, len(getqflist())]) + 1,
      \ 'width': &columns,
      \ 'relative': 'editor',
      \ 'anchor': 'SW',
      \ 'row': &lines,
      \ 'col': 0,
      \})

command! -nargs=* Find call fzf#run({
\ 'source':  printf('rg -a --vimgrep --color always "%s"',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110 -x',
\ 'sink*': function('<sid>rg_handler'),
\ 'down':    '50%',
\ })

" Find string inside the CWD
nnoremap <leader>p/ :silent! Find <C-R><C-W><CR>
vnoremap <leader>p/ y:silent Find <C-R>"<CR>
" helpers

" auto-adjust window height to a max of N lines
function! AdjustWindowHeight(minheight, ...)
    exe max([min([line("$"), (a:0 >= 1) ? a:1 : a:minheight]), a:minheight]) . "wincmd _"
endfunction
augroup WindowSizing
  au!
  au FileType qf       call AdjustWindowHeight(1,  20)
augroup END

function! s:rg_handler(lines)
  if len(a:lines) < 2 | return | endif
  let cmd = get({ 'ctrl-x': 'split'
                \,'ctrl-v': 'vertical split'
                \,'ctrl-t': 'tabe'
                \ } , a:lines[0], 'e' )
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')
  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'
  if len(list) > 1
    call setqflist(list)
    copen
  endif
endfunction

function! s:qf_to_fzf(key, line) abort
  let l:filepath = expand('#' . a:line.bufnr . ':p')
  return l:filepath . ':' . a:line.lnum . ':' . a:line.col . ':' . a:line.text
endfunction

function! s:fzf_to_qf(filtered_list) abort
  let list = map(a:filtered_list, 's:ag_to_qf(v:val)')
  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

" ({ 'width': number,
"    'height': number,
"    'message': array<string>,
"    'relative': 'editor' | 'cursor',
"    'anchor': 'NW' | 'NE' | 'SW' | 'SE',
"    'enter': 0 | 1,
"    'centered': boolean }) -> window_id
function! s:fzf_floating_window(opts) abort
  let l:buff = nvim_create_buf(v:false, v:true)

  let l:message = get(a:opts, 'message', [])

  " Window size
  " TODO: get the width from the longest line in l:message
  let l:width = get(a:opts, 'width', 150)
  let l:height = max([get(a:opts, 'height', 1), len(l:message)])

  let l:col = get(a:opts, 'col', 1)
  let l:row = get(a:opts, 'row', 0)
  let l:anchor = get(a:opts, 'anchor', 'SW')
  let l:relative = get(a:opts, 'relative', 'cursor')

  let l:win_opts = {
        \ 'relative': l:relative,
        \ 'anchor': l:anchor,
        \ 'col': l:col,
        \ 'row': l:row,
        \ 'width': l:width,
        \ 'height': l:height,
        \ 'style': 'minimal'
        \ }

  let l:enter = get(a:opts, 'enter', 0)

  if len(l:message) > 0
    call nvim_buf_set_lines(l:buff, 0, -1, v:true, l:message)
  else
    " force the enter option if we're operating on the current buffer
    let l:enter = 1
  endif

  " Window position
  if get(a:opts, 'centered', v:false)
    let l:win_opts.relative = 'editor'
    let l:win_opts.anchor = 'NW'
    let l:win_opts.col = (&columns/2) - (l:width/2)
    let l:win_opts.row = (&lines/2) - (l:height/2)
  endif

  " Window id
  let l:win_id = nvim_open_win(l:buff, l:enter, l:win_opts)


  doautocmd User FloatingWindowEnter

  return l:win_id
endfunction

function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return { 'filename': parts[0],
         \ 'lnum': parts[1],
         \ 'col': parts[2],
         \ 'text': join(parts[3:], ':')
         \ }
endfunction
g
