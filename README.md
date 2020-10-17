# Markdown headings in Vim

This plugin introduces an elegant way to handle markdown headings {h1-h6} from the Normal mode on the current line.

Default mappings (only in markdown/liquid files):

```viml
nnoremap <silent> = :call <SID>HeadingIncrease()<CR>
nnoremap <silent> _ :call <SID>HeadingDecrease()<CR>
```

Default maps are disabled with the following option:

```viml
let g:vim_heading_maps = 0
```
