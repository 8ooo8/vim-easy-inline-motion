"" Version: 0.0.0
"" Author: 8ooo8 <ben.cky.workspace@gmail.com>
"" Source: github.com/8ooo8/vim-easy-inline-motion
"" License: MIT

"" Script loading control
if v:version < 800
  echoe '[Vim-easy-inline-motion] Please update your vim to a verion 8 or higher.' | finish
endif
if &cp 
  echoe '[Vim-easy-inline-motion] Not Vi-compatible. ":set nocp" to solve it.' | finish
endif
if exists('g:easyInlineMotion_loaded') && g:easyInlineMotion_loaded 
  echom '[Vim-easy-inline-motion] This plugin was already loaded.'
  finish
endif
let g:easyInlineMotion_loaded = 1

"" Default configuration
let g:vim_easy_inline_motion_cterm_colors = get(g:, 'vim_easy_inline_motion_cterm_colors',
  \ [9, 13, 11, 10, 1, 5, 3, 28])
let g:vim_easy_inline_motion_gui_colors = get(g:, 'vim_easy_inline_motion_gui_colors', 
  \ ['#ff0000', '#ff00ff', '#ffff00', '#00ff00', '#800000', '#800080', '#808000', '#00af00'])
let g:vim_easy_inline_motion_adjacent_lines = get(g:, 'vim_easy_inline_motion_adjacent_lines', 
  \ 8)
let g:vim_easy_inline_motion_adjacent_lines = 1

"" User interface
noremap <silent><Plug>(easy-inline-motion-toggle-auto-highlight-mode) :silent call
  \ vim_easy_inline_motion#toggle_auto_highlight_mode()<CR>
command! EasyInlineMotionOn silent call vim_easy_inline_motion#turn_on_auto_highlight_mode()
command! EasyInlineMotionOff silent call vim_easy_inline_motion#turn_off_auto_highlight_mode()

"" Turn on auto highlight mode
silent call vim_easy_inline_motion#turn_on_auto_highlight_mode()
