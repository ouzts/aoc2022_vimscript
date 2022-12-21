let g:lines = readfile("C:/Users/Andrew/Desktop/part8.txt")
let g:ans1 = 0
let g:ans2 = 0
let g:part2 = 0

function! Solve(i, j, height, dir)
  if a:i < 0 || a:j < 0 || a:i >= len(g:lines) || a:j >= strlen(g:lines[0])
    return !g:part2
  endif
  if g:lines[a:i][a:j] - '0' >= a:height
    return g:part2
  endif
  if a:dir == 0
    return  g:part2 + Solve(a:i + 1, a:j, a:height, g:part2 ? 0 : a:dir)
  elseif a:dir == 1
    return  g:part2 + Solve(a:i - 1, a:j, a:height, g:part2 ? 1 : a:dir)
  elseif a:dir == 2
    return  g:part2 + Solve(a:i, a:j - 1, a:height, g:part2 ? 2 : a:dir)
  elseif a:dir == 3
    return  g:part2 + Solve(a:i, a:j + 1, a:height, g:part2 ? 3 : a:dir)
  endif
endfunction

function! Part1(i, j)
  let g:part2 = 0
  return Solve(a:i + 1, a:j, str2nr(g:lines[a:i][a:j]), 0) || Solve(a:i - 1, a:j, str2nr(g:lines[a:i][a:j]), 1) || Solve(a:i, a:j - 1, str2nr(g:lines[a:i][a:j]), 2) || Solve(a:i, a:j + 1, str2nr(g:lines[a:i][a:j]), 3)
endfunction
function! Part2(i, j)
  let g:part2=1
  return Solve(a:i + 1, a:j, str2nr(g:lines[a:i][a:j]), 0) * Solve(a:i - 1, a:j, str2nr(g:lines[a:i][a:j]), 1) * Solve(a:i, a:j - 1, str2nr(g:lines[a:i][a:j]), 2) * Solve(a:i, a:j + 1, str2nr(g:lines[a:i][a:j]), 3)
endfunction

for i in range(len(g:lines))
  for j in range(strlen(g:lines[0]))
    if i == 0 || j == 0 || i == len(g:lines) - 1 || j == strlen(g:lines[0]) - 1
      let g:ans1 += 1
    else
      let g:ans1 += Part1(i,j)
    endif
    let vis = Part2(i,j)
    let g:ans2 = max([g:ans2, vis])
  endfor
endfor

echo g:ans1 . " " . g:ans2
