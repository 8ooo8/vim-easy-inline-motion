function! vim_easy_inline_motion#regex#get_n_th_word_tip_position(n)
  "" the backward flag does not function as expected when '\%#' is involved
  "" let search_flag = (a:n > 0 ? 'nW' : 'nWb') 
  let search_flag = a:n > 0 ? 'nW' : 'n'
  if a:n > 0
    let [row, col] = searchpos('\m\%#\(\([0-9a-zA-Z_#]\+\|[^0-9a-zA-Z_# \t]\+\|\s\)\s*\)\{' .a:n .'}\zs', search_flag)
  else
    let [row, col] = searchpos('\m\(\([0-9a-zA-Z_#]\+\|[^0-9a-zA-Z_# \t]\+\)\s*\)\{' .abs(a:n) .'}\%#', search_flag)
  endif
  return [row, col]
endfunction
