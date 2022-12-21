let g:line = readfile("C:/Users/Andrew/Desktop/part6.txt")[0]

function! Solve(num)
  let freq = {}
  let win_start = 0
  let win_end = 0
  while win_end < strlen(g:line)
    if has_key(freq, g:line[win_end])
      let freq[g:line[win_end]] += 1
    else
      let freq[g:line[win_end]] = 1
    endif
    if win_end >= a:num
      let freq[g:line[win_start]] -= 1
      if !freq[g:line[win_start]]
        call remove(freq, g:line[win_start])
      endif
      let win_start += 1
    endif
    if len(keys(freq)) == a:num
      return win_end + 1
    endif

    let win_end += 1
  endwhile
endfunction

echo Solve(4) . " " . Solve(14)
