"" Variable declaration
let s:auto_highlight_mode_is_on = 0

"" API {{{1
function! easy_inline_motion#toggle_auto_highlight_mode()
  if s:auto_highlight_mode_is_on
    call easy_inline_motion#turn_off_auto_highlight_mode()
  else
    call easy_inline_motion#turn_on_auto_highlight_mode()
  endif
endfunction

function! easy_inline_motion#turn_on_auto_highlight_mode()
  augroup easy-inline-motion-auto-highlight
    autocmd!
    autocmd TextChanged,CursorMoved,InsertLeave *
      \ if &filetype !=? 'nerdtree' |
      \   call easy_inline_motion#highlight#clear_all_highlights() |
      \   call easy_inline_motion#highlight_all_requested_w_and_b_targets() |
      \ endif 
    autocmd WinLeave,InsertEnter *
      \ if &filetype !=? 'nerdtree' |
      \   call easy_inline_motion#highlight#clear_all_highlights() |
      \ endif 
  augroup END

  let s:auto_highlight_mode_is_on = 1

  call easy_inline_motion#highlight#clear_all_highlights()
  call easy_inline_motion#highlight_all_requested_w_and_b_targets()
endfunction

function! easy_inline_motion#turn_off_auto_highlight_mode()
  autocmd! easy-inline-motion-auto-highlight
  let s:auto_highlight_mode_is_on = 0

  call easy_inline_motion#highlight#clear_all_highlights()
endfunction

function! easy_inline_motion#highlight_all_requested_w_and_b_targets()
  let [curr_buf, curr_line, curr_col, curr_off, curr_curswant] = getcurpos()

  ""highlight as requested
  for line in range(curr_line - g:easy_inline_motion_preview_lines, curr_line + g:easy_inline_motion_preview_lines)
    let rightmost_col = strlen(getline(line))
    let col = curr_curswant <= rightmost_col ? curr_curswant : rightmost_col
    call easy_inline_motion#highlight_w_and_b_targets_on_specified_cursor_position(line, col)
  endfor
endfunction

function! easy_inline_motion#highlight_w_and_b_targets_on_specified_cursor_position(line, col)
  let num_of_char_to_highlight = {}
  let num_of_char_to_highlight['cterm'] = len(g:easy_inline_motion_cterm_colors)
  let num_of_char_to_highlight['gui'] = len(g:easy_inline_motion_gui_colors)
  let max_num_of_char_to_highlight = num_of_char_to_highlight['cterm'] > num_of_char_to_highlight['gui'] ? 
    \ num_of_char_to_highlight['cterm'] : num_of_char_to_highlight['gui']

  for i in range(max_num_of_char_to_highlight)
    let cterm_color = i < num_of_char_to_highlight['cterm'] ? g:easy_inline_motion_cterm_colors[i] : ''
    let gui_color = i < num_of_char_to_highlight['gui'] ? g:easy_inline_motion_gui_colors[i] : ''
    let w_target_char_col = easy_inline_motion#char_locator#get_n_w_target_char_index(getline(a:line), i + 1, a:col - 1) + 1
    let b_target_char_col = easy_inline_motion#char_locator#get_n_b_target_char_index(getline(a:line), i + 1, a:col - 1) + 1
    
    if w_target_char_col > 0
      call easy_inline_motion#highlight#highlight_at(a:line, w_target_char_col, cterm_color, gui_color)
    endif 
    if b_target_char_col > 0
      call easy_inline_motion#highlight#highlight_at(a:line, b_target_char_col, cterm_color, gui_color)
    endif
  endfor
endfunction
