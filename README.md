# vim-easy-inline-motion

![The snapshot of the highlight][highlight-snapshot]

Have you ever thought of utilizing the cursor motion command like `7w` and `8b`? This plugin highlights the tips of the words so that with the highlight colors, users may immediately know the exact cursor motion command to instantly reach their target words.

## Table of content

1. [Quick start](#quick-start)
1. [Comparison with vim-easymotion](#comparison-with-vim-easymotion)
1. [Installation](#installation)
1. [Configuration](#configuration)
1. [Commands](#commands)

## Quick start

In general, this plugin works well with the default configuration.

### Highlight colors

![A picture of the deault highlight colros][default-highlight-colors]

In the default configuration, a red color to mean one word forward/backward, pink to mean 2 words forward/backward, etc. The first 5 colors are red, pink, yellow, green and blue, and the second 5 colors are likely to be the dull version of the first 5 colors.

The colors is configurable, see [color configuration](#the-geasy_inline_motion_cterm_colors-option). Please note that the colors differ on different running environment and therefore, the default colors shown on your vim may be different from the above picture.

### Highlight rules

1. This plugin highlights characters that built-in cursor motion command, `w` and `b`, may jump to.
1. Basically, it auto highlights the line your cursor is currently on.
1. In the case that the word tip(s) supposed to be highlighted is/are out of the current line, it/they is/are not highlighted. For instance, the cursor is at the end of a line, the next word tip(s) is/are not highlighted since it/they are out of the current line.
1. It can be configured to preview the highlighting of the adjacent lines -- preview the highlighting as the cursor is moved to the adjacent lines using `j` or `k` or `<up>` or `<down>`. See [g:easy_inline_motion_preview_lines](#the-geasy_inline_motion_preview_lines-option) for its configuration.
1. The highlighting is off when it is in the insert mode.
1. The highlighting can be turned on and off/toggled using [commands](#commands) or [mapped keys](#map-a-key-to-toggle-the-auto-highlighting).

## Comparison with [vim-easymotion][vim-easymotion-repo]

|vim-easy-inline-motion|vim-easy-motion|Comparison|
|-|-|-|
|Highlight with colors|Change character|Reading colors consumes less time if familiar with the colors|
|Auto highlighting|Mapped keys to trigger functions|Auto highlighting saves time on typing mapped keys|
|Coverage: current and adjacent lines|Coverage: whole buffer|easymotion has the ability to instantly reach faraway targets|
|Not direct support to an instant jump to non-word-tip characters|Direct support to an instant jump to non-word-tip characters|easymotion has a direct support to an instant jump to non-word-tip characters| 

## Installation

For example, with plugin manager, [vim-plug][vim-plug-repo]:

```vim
Plug '8ooo8/vim-inline-easy-motion'
```

## Configuration

### Map a key to toggle the auto highlighting

```vim
map <Leader>eim <Plug>(easy-inline-motion-toggle-auto-highlight-mode)
```

### The `g:easy_inline_motion_cterm_colors` option 

1. [What are cterm and gui in the sense of highlighting?][what-cterm-gui-are]
1. [cterm color cheat sheet][cterm-color-cheat-sheet]

Assign an array of colors to this global variable to configure the highlight colors on the colored terminals. 

```vim
"" Color with ID 9 to highlight the tip of the previous and the next words,
"" 13 for the tip of the previous previous and the next next words, etc.
"" Please note that this plugin highlights more word tips as you assign more colors here.
let g:easy_inline_motion_cterm_colors = [9, 13, 11, 10, 27, 1, 5, 3, 28, 36]
```

### The `g:easy_inline_motion_gui_colors` option

1. [What are cterm and gui in the sense of highlighting?][what-cterm-gui-are]

Assign an array of colors to this global variable to configure the highlight colors on the gui vim. 

```vim
"" Color of '#ff0000' to highlight the tip of the previous and the next words,
"" '#ff00ff' for the tip of the previous previous and the next next words, etc.
"" Please note that this plugin highlights more word tips as you assign more colors here.
let g:easy_inline_motion_gui_colors = ['#ff0000', '#ff00ff', '#ffff00', '#00ff00', '#005fff',
  \ '#800000', '#800080', '#808000', '#00af00', '#00af87']
```

### The `g:easy_inline_motion_preview_lines` option

```vim
"" 1 value to preview 1 upper and 1 below lines.
let g:easy_inline_motion_preview_lines = 1
```


## Commands

### The `EasyInlineMotionOn` command

This commands turns on the auto highlighting.

```vim
:EasyInlineMotionOn
```

### The `EasyInlineMotionOff` command

This commands turns off the auto highlighting.

```vim
:EasyInlineMotionOff
```

## License
[MIT][MIT-license]


[default-highlight-colors]: docs/default-highlight-colors.png
[highlight-snapshot]: docs/highlight-snapshot.png
[MIT-license]: LICENSE
  
[cterm-color-cheat-sheet]: https://jonasjacek.github.io/colors/
[what-cterm-gui-are]: https://stackoverflow.com/questions/60590376/what-is-the-difference-between-cterm-color-and-gui-color
[vim-easymotion-repo]: https://github.com/easymotion/vim-easymotion
[vim-plug-repo]: https://github.com/junegunn/vim-plug
