"" API {{{1
function! vim_easy_inline_motion#char_locator#locate_n_w_target_char(text, n, start_position) "" w for the built-in 'w' cursor motion 
endfunction

"" Private functions {{{1
"" w for the built-in 'w' cursor motion; w target set refers to the set of char w may jump to.
function! _is_in_w_target_char_set_1(char) 
  return a:char =~ '\w' || a:char ==# '#'
endfunction

"" w for the built-in 'w' cursor motion; w target set refers to the set of char w may jump to.
function! _is_in_w_target_char_set_2(char) 
  return a:char !~ '\s' && !_is_in_w_target_char_set_1(a:char)
endfunction

"" w for the built-in 'w' cursor motion 
function! _locate_next_w_target_char(text, start_position) 
  if a:start_position >= strlen(a:text) - 1 || a:start_position < 0
    return -1
  endif

  let current_char = a:text[a:start_position]
  let w_set_that_current_char_in = 0 "" 0 value means current_char is not in any w target char set
  let w_set_that_current_char_in = _is_in_w_target_char_set_1(current_char) ? 1 : w_set_that_current_char_in
  let w_set_that_current_char_in = _is_in_w_target_char_set_2(current_char) ? 2 : w_set_that_current_char_in

  for i in range(a:start_position + 1, strlen(a:text) - 1)
    let new_char = a:text[i]
    let new_w_set = 0
    let new_w_set = _is_in_w_target_char_set_1(new_char) ? 1 : new_w_set
    let new_w_set = _is_in_w_target_char_set_2(new_char) ? 2 : new_w_set
    if new_w_set != 0 && w_set_that_current_char_in != new_w_set
      return i
    endif

    let w_set_that_current_char_in = new_w_set
  endfor

  return -1
endfunction

"" b for the built-in 'b' cursor motion 
function! _locate_next_b_target_char(text, start_position) 
  if a:start_position >= strlen(a:text) || a:start_position <= 0
    return -1
  endif

  let current_char = a:text[a:start_position - 1]
  let w_set_that_current_char_in = 0 "" 0 value means current_char is not in any w target char set
  let w_set_that_current_char_in = _is_in_w_target_char_set_1(current_char) ? 1 : w_set_that_current_char_in
  let w_set_that_current_char_in = _is_in_w_target_char_set_2(current_char) ? 2 : w_set_that_current_char_in

  if a:start_position == 1
    if w_set_that_current_char_in != 0
      return 0
    endif
  else
    for i in reverse(range(0, a:start_position - 2))
      let new_char = a:text[i]
      let new_w_set = 0
      let new_w_set = _is_in_w_target_char_set_1(new_char) ? 1 : new_w_set
      let new_w_set = _is_in_w_target_char_set_2(new_char) ? 2 : new_w_set
      echom 'i: ' .i . ', set: ' .w_set_that_current_char_in . ', new_set: ' .new_w_set .' ,new_char: ' .new_char
      if w_set_that_current_char_in != 0 && w_set_that_current_char_in != new_w_set
        return i + 1
      endif

      let w_set_that_current_char_in = new_w_set
    endfor
  endif

  if _is_in_w_target_char_set_1(a:text[0]) || _is_in_w_target_char_set_2(a:text[0])
    return 0
  endif

  return -1
endfunction
