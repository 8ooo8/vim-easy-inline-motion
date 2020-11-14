"" Variable declaration {{{1
let s:highlight_groups = []
"" The data structure of s:highlight_match_id is:
"" {buffer_id_1: [match_id_1, ...], buffer_id_2: [...], ...}
let s:highlight_match_id = {} 
let s:supported_encoding = ['utf-8']

"" API {{{1
function! easy_inline_motion#highlight#shade_line(line)
  if !g:easy_inline_motion_shading_on
    return
  endif
  let group_name = _get_highlight_group_name(g:easy_inline_motion_shade_cterm_color, g:easy_inline_motion_shade_gui_color)
  let match_id = matchadd(group_name, '\m\%' .a:line .'l', -1)
  let buffer_id = bufnr()
  call _store_highlight_match_id(buffer_id, match_id)
endfunction

function! easy_inline_motion#highlight#highlight_at(line, col, cterm_color, gui_color)
  if !_encoding_is_supoorted()
    echohl WarningMsg | echo '[Easy-Inline-Motion] Warning: the current encoding method is not supported.'
  endif
  let group_name = _get_highlight_group_name(a:cterm_color, a:gui_color)
  call _add_highlight_match(a:line, a:col, group_name)
endfunction

function! easy_inline_motion#highlight#clear_current_buffer_highlights()
  let buffer_id = bufnr()
  if !exists('s:highlight_match_id[' .buffer_id .']')
    return
  endif

  for match_id in s:highlight_match_id[buffer_id]
    try 
      call matchdelete(match_id) "" clear all matches created by this plugin
    catch /\ce803/
    endtry
  endfor
  let s:highlight_match_id[buffer_id] = []
endfunction

"" Private functions {{{1
function! _encoding_is_supoorted()
  for enc in s:supported_encoding
    if enc ==? &encoding
      return 1
    endif
  endfor
  return 0
endfunction

function! _add_highlight_match(line, col, highlight_group_name)
  let match_id = matchaddpos(a:highlight_group_name, [[a:line, a:col]])
  let buffer_id = bufnr()
  call _store_highlight_match_id(buffer_id, match_id)
endfunction

function! _get_highlight_group_name(cterm_color, gui_color)
  if a:cterm_color ==# '' && a:gui_color ==# ''
    throw 'The ctermfg or/and guifg color(s) for the highlighting has/have to be defined.'
  endif
  "" retrieve the group name corresponding to the specified color
  "" from the exisiting group names
  for group in s:highlight_groups
    if group['cterm_color'] == a:cterm_color && group['gui_color'] == a:gui_color
      return group['group_name']
    endif
  endfor 

  "" create a new group for the specified color
  let group_name = 'easy_inline_motion_highlight_groups_' .len(s:highlight_groups)
  exe 'highlight ' .group_name 
    \ .(strlen(a:cterm_color) > 0 ? ' ctermfg=' .a:cterm_color : '')
    \ .(strlen(a:gui_color) > 0 ? ' guifg=' .a:gui_color : '')
  call add(s:highlight_groups, {'group_name': group_name, 'cterm_color': a:cterm_color, 'gui_color': a:gui_color})
  return group_name
endfunction

function! _store_highlight_match_id(buffer_id, match_id)
  if !exists('s:highlight_match_id[' .a:buffer_id .']')
    let s:highlight_match_id[a:buffer_id] = []
  endif
  call add(s:highlight_match_id[a:buffer_id], a:match_id)
endfunction
