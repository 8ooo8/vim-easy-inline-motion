"" Variable declaration {{{1
let s:highlight_groups = []
let s:highlight_match_id = [] "" storing all match id; no record about what is highlighted by the associated id
let s:supported_encoding = ['utf-8']

"" API {{{1
function! easy_inline_motion#highlight#highlight_at(line, col, cterm_color, gui_color)
  if !_encoding_is_supoorted()
    echohl WarningMsg | echo '[Easy-Inline-Motion] Warning: the current encoding method is not supported.'
  endif
  let group_name = _get_highlight_group_name(a:cterm_color, a:gui_color)
  call _add_highlight_match(a:line, a:col, group_name)
endfunction

function! easy_inline_motion#highlight#clear_all_highlights()
  for id in s:highlight_match_id
    try 
      call matchdelete(id) "" clear all matches created by this plugin
    catch /\ce803/
    endtry
  endfor
  let s:highlight_match_id = []
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
  let id = matchaddpos(a:highlight_group_name, [[a:line, a:col]])
  call add(s:highlight_match_id, id)
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