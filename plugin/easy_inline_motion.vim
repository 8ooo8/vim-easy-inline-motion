"" Version: 0.0.0
"" Author: 8ooo8 <ben.cky.workspace@gmail.com>
"" Source: github.com/8ooo8/vim-easy-inline-motion
"" License: MIT

"" Script loading control
let g:easy_inline_motion_loaded = 0
if v:version < 800
  echoe '[Easy-Inline-Motion] Please update your vim to a verion 8 or higher.' | finish
endif
if &cp 
  echoe '[Easy-Inline-Motion] Not Vi-compatible. ":set nocp" to solve it.' | finish
endif
if exists('g:easy_inline_motion_loaded') && g:easy_inline_motion_loaded
  echom '[Easy-Inline-Motion] This plugin was already loaded.'
  finish
endif
let g:easy_inline_motion_loaded = 1

"" Default configuration
let g:easy_inline_motion_cterm_colors = get(g:, 'easy_inline_motion_cterm_colors',
  \ [9, 13, 11, 10, 27,
  \ 1, 5, 3, 28, 36])
let g:easy_inline_motion_gui_colors = get(g:, 'easy_inline_motion_gui_colors', 
  \ ['#ff0000', '#ff00ff', '#ffff00', '#00ff00', '#005fff',
  \ '#800000', '#800080', '#808000', '#00af00', '#00af87'])
let g:easy_inline_motion_preview_lines = get(g:, 'easy_inline_motion_preview_lines', 
  \ 8)
let g:easy_inline_motion_preview_lines = 1

"" User interface
noremap <silent><Plug>(easy-inline-motion-toggle-auto-highlight-mode) :silent call
  \ easy_inline_motion#toggle_auto_highlight_mode()<CR>
command! EasyInlineMotionOn silent call easy_inline_motion#turn_on_auto_highlight_mode()
command! EasyInlineMotionOff silent call easy_inline_motion#turn_off_auto_highlight_mode()

"" Turn on auto highlight mode
silent call easy_inline_motion#turn_on_auto_highlight_mode()
