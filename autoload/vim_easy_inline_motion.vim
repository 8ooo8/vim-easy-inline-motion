function! vim_easy_inline_motion#highlight_current_line()
  let tips_to_highlight_in_cterm = len(g:vim_easy_inline_motion_cterm_colors)
  let tips_to_highlight_in_gui = len(g:vim_easy_inline_motion_gui_colors)
  let tips_to_highlight = tips_to_highlight_in_cterm > tips_to_highlight_in_gui ? tips_to_highlight_in_cterm : tips_to_highlight_in_gui

  for i in range(tips_to_highlight)
    let cterm_color = i < tips_to_highlight_in_cterm ? g:vim_easy_inline_motion_cterm_colors[i] : ''
    let gui_color = i < tips_to_highlight_in_gui ? g:vim_easy_inline_motion_gui_colors[i] : ''
    
    let [row1, col1] = vim_easy_inline_motion#regex#get_n_th_word_tip_position(i + 1)
    let [row2, col2] = vim_easy_inline_motion#regex#get_n_th_word_tip_position(-i - 1)
    
    call vim_easy_inline_motion#highlight#highlight_at(row1, col1, cterm_color, gui_color)
    call vim_easy_inline_motion#highlight#highlight_at(row2, col2, cterm_color, gui_color)
  endfor
endfunction
