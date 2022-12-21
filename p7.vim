let g:lines = readfile("C:/Users/Andrew/Desktop/part7.txt")
let g:total=0
let g:idx = 0

function! Solve(minn)
  let sum = 0
  while g:idx < len(g:lines)
    let line = g:lines[g:idx]
    let g:idx+= 1
    if line[0] =~ '[0-9]'
      let sum += str2nr(matchstr(line, '^\d\+'))
    elseif line[0] == '$'
      if len(line) >= 5 && line[5] == '.'
        if sum <= 100000
          let g:total += sum
        endif
        if sum >= a:minn
          let g:ans2 = min([g:ans2, sum])
        endif
        return sum
      elseif line[2] == 'c'
        let sub_sum = Solve(copy(a:minn))
        let sum += sub_sum
      endif
    endif
  endwhile
  if sum <= 100000
    let g:total += sum
  endif
  if sum >= a:minn
    let g:ans2 = min([g:ans2, sum])
  endif
  return sum
endfunction

" Part 1
let tot = Solve(0)
echo g:total

" Part 2
let needed = tot - 40000000
let g:ans2 = 30000000
let g:total = 0
let g:idx = 0
call Solve(needed)
echo ans2
