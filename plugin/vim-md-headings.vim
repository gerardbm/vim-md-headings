if !exists('g:vim_heading_maps')
	let g:vim_heading_maps = 1
endif

let s:levelRegexpDict = {
    \ 1: '\v^(#[^#]@=|.+\n\=+$)',
    \ 2: '\v^(##[^#]@=|.+\n-+$)',
    \ 3: '\v^###[^#]@=',
    \ 4: '\v^####[^#]@=',
    \ 5: '\v^#####[^#]@=',
    \ 6: '\v^######[^#]@='
\ }

function! s:HeadingIncrease()
	let l:forbiddenLevel = 6
	let l:replaceLevels = [5, 1]
	let l:levelDelta = 1
	let l:flags = (&gdefault ? '' : 'g')
	for l:level in range(replaceLevels[0], replaceLevels[1], -l:levelDelta)
		execute 'silent! substitute/' . s:levelRegexpDict[l:level] . '/' .
					\ repeat('#', l:level + l:levelDelta) . '/' . l:flags
	endfor
	execute 'silent! substitute/\v^(\k|\*|-|\+)/\#\ &/g'
endfunction

function! s:HeadingDecrease()
	let l:forbiddenLevel = 1
	let l:replaceLevels = [2, 6]
	let l:levelDelta = -1
	execute 'silent! substitute/\v^#\ //g'
	let l:flags = (&gdefault ? '' : 'g')
	for l:level in range(replaceLevels[0], replaceLevels[1], -l:levelDelta)
		execute 'silent! substitute/' . s:levelRegexpDict[l:level] . '/' .
					\ repeat('#', l:level + l:levelDelta) . '/' . l:flags
	endfor
endfunction

if g:vim_heading_maps == 1
	augroup markdown
		autocmd FileType markdown,liquid
					\ nnoremap <silent> = :call <SID>HeadingIncrease()<CR>
		autocmd FileType markdown,liquid
					\ nnoremap <silent> _ :call <SID>HeadingDecrease()<CR>
	augroup end
endif
