"" API {{{1
function! vim_easy_inline_motion#regex#get_n_th_word_tip_position(n, row, col)
  "" the backward flag does not function as expected when '\%#' is involved
  "" let search_flag = (a:n > 0 ? 'nW' : 'nWb') 
  if a:n > 0
    let [tip_row, tip_col] = searchpos('\m\%' .a:row .'l\%' .a:col .'c\(\([0-9a-zA-Z_#]\+\|[^0-9a-zA-Z_# \t]\+\|\s\)\s*\)\{' .a:n .'}\zs', 'n')
  else
    let [tip_row, tip_col] = searchpos('\m\%' .a:row .'l\(\([0-9a-zA-Z_#]\+\|[^0-9a-zA-Z_# \t]\+\)\s*\)\{' .abs(a:n) .'}\%' .a:col .'c', 'n')
  endif
  return [tip_row, tip_col]
endfunction
