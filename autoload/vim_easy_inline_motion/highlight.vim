let s:highlight_groups = []
let s:highlight_match_id = [] "" storing all match id; no record about what is highlighted by the associated id
let s:encoding_base_byte_size = 1

function! vim_easy_inline_motion#highlight#highlight_at(row, col, cterm_color, gui_color)
  let group_name = _get_highlight_group_name(a:cterm_color, a:gui_color)
  call _add_highlight_match(a:row, a:col, group_name)
endfunction

function! vim_easy_inline_motion#highlight#clear_all_highlights()
  for id in s:highlight_match_id
    call matchdelete(id) "" clear all matches created by this plugin
  endfor
  let s:highlight_match_id = []
endfunction

function! _add_highlight_match(row, col, highlight_group_name)
  "" call add(s:highlight_match_id, matchaddpos(a:highlight_group_name, [[a:row, a:col], s:encoding_base_byte_size]))
  let id = matchaddpos(a:highlight_group_name, [[a:row, a:col, s:encoding_base_byte_size]])
  call add(s:highlight_match_id, id)
  "" echom 'call add(' .s:highlight_match_id.', '.matchaddpos(a:highlight_group_name, [a:row, a:col]).')'
endfunction

function! _get_highlight_group_name(cterm_color, gui_color)
  "" retrieve the group name corresponding to the specified color
  "" from the exisiting group names
  for group in s:highlight_groups
    if group['cterm_color'] == a:cterm_color && group['gui_color'] == a:gui_color
      return group['group_name']
    endif
  endfor 

  "" create a new group for the specified color
  let group_name = 'vim_easy_inline_motion_highlight_groups_' .len(s:highlight_groups)
  exe 'highlight ' .group_name .' ctermbg=' .a:cterm_color .' guibg=' .a:gui_color
  call add(s:highlight_groups, {'group_name': group_name, 'cterm_color': a:cterm_color, 'gui_color': a:gui_color})
  return group_name
endfunction

function! vim_easy_inline_motion#highlight#set_encoding_base_byte_size(size)
  if a:size <= 0
    throw "Encoding base's byte size cannot be smaller than 1."
  endif
  let s:encoding_base_byte_size = a:size
endfunction
