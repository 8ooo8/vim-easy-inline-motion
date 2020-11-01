"" API {{{1
"" w for the built-in 'w' cursor motion 
function! vim_easy_inline_motion#char_locator#get_n_w_target_char_index(text, n, start_index) 
  let target_index = a:start_index
  for i in range(a:n)
    let target_index = _get_next_w_target_char_index(a:text, target_index)
    if target_index < 0
      return -1
    endif
  endfor
  return target_index
endfunction

"" w for the built-in 'w' cursor motion 
function! vim_easy_inline_motion#char_locator#get_n_b_target_char_index(text, n, start_index) 
  let target_index = a:start_index
  for i in range(a:n)
    let target_index = _get_next_b_target_char_index(a:text, target_index)
    if target_index < 0
      return -1
    endif
  endfor
  return target_index
endfunction

"" Private functions {{{1
"" w for the built-in 'w' cursor motion; w target set refers to the set of char w may jump to.
function! _is_in_w_target_char_set_1(char) 
  return a:char =~ '\k' || a:char ==# '#'
endfunction

"" w for the built-in 'w' cursor motion; w target set refers to the set of char w may jump to.
function! _is_in_w_target_char_set_2(char) 
  return a:char !~ '\s' && !_is_in_w_target_char_set_1(a:char)
endfunction

"" w for the built-in 'w' cursor motion 
function! _get_next_w_target_char_index(text, start_index) 
  if a:start_index >= strlen(a:text) - 1 || a:start_index < 0
    return -1
  endif

  let current_char = a:text[a:start_index]
  let w_set_that_current_char_in = 0 "" 0 value means current_char is not in any w target char set
  let w_set_that_current_char_in = _is_in_w_target_char_set_1(current_char) ? 1 : w_set_that_current_char_in
  let w_set_that_current_char_in = _is_in_w_target_char_set_2(current_char) ? 2 : w_set_that_current_char_in

  for i in range(a:start_index + 1, strlen(a:text) - 1)
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
function! _get_next_b_target_char_index(text, start_index) 
  if a:start_index >= strlen(a:text) || a:start_index <= 0
    return -1
  endif

  let current_char = a:text[a:start_index - 1]
  let w_set_that_current_char_in = 0 "" 0 value means current_char is not in any w target char set
  let w_set_that_current_char_in = _is_in_w_target_char_set_1(current_char) ? 1 : w_set_that_current_char_in
  let w_set_that_current_char_in = _is_in_w_target_char_set_2(current_char) ? 2 : w_set_that_current_char_in

  if a:start_index == 1
    if w_set_that_current_char_in != 0
      return 0
    endif
  else
    for i in reverse(range(0, a:start_index - 2))
      let new_char = a:text[i]
      let new_w_set = 0
      let new_w_set = _is_in_w_target_char_set_1(new_char) ? 1 : new_w_set
      let new_w_set = _is_in_w_target_char_set_2(new_char) ? 2 : new_w_set
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
