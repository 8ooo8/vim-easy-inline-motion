"" Version: 0.0.0
"" Author: 8ooo8 <ben.cky.workspace@gmail.com>
"" Source: github.com/8ooo8/vim-easy-inline-motion
"" License: MIT

if expand('%:p') ==# expand('<sFile>:p')
  unlet g:easyInlineMotion_loaded
endif
if v:version < 800
  echoe '[Vim-easy-inline-motion]: Please update your vim to a verion 8 or higher.' | finish
endif
if &cp 
  echoe '[Vim-easy-inline-motion] Not Vi-compatible. ":set nocp" to solve it.' | finish
endif
if exists('g:easyInlineMotion_loaded') && g:easyInlineMotion_loaded 
  finish
endif
let g:easyInlineMotion_loaded = 1



