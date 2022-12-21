let headx = 0
let heady = 0
let tailx = 0
let taily = 0
let m = {"U": [0, 1],"D": [0, -1],"R": [1, 0],"L": [-1, 0] }
let ans1 = {}
let ans2 = {}
let rope = [[0,0],[0,0],[0,0],[0,0],[0,0], [0,0],[0,0],[0,0],[0,0],[0,0]]

function! Sign(x)
  if a:x > 0 | return 1 | elseif a:x < 0 | return -1 | else return 0 | endif
endfunction

function! Part1()
  let dx = g:tailx - g:headx
  let dy = g:taily - g:heady
  if dx == 0 || dy == 0
    if abs(dx) >= 2
      let g:tailx -= Sign(dx)
    endif
    if abs(dy) >= 2
      let g:taily -= Sign(dy)
    endif
  elseif abs(dx) != 1 || abs(dy) != 1
    let g:tailx -= Sign(dx)
    let g:taily -= Sign(dy)
  endif
endfunction

function! Part2(i)
  let g:headx = g:rope[a:i - 1][0]
  let g:heady = g:rope[a:i - 1][1]
  let g:tailx = g:rope[a:i][0]
  let g:taily = g:rope[a:i][1]
  let dx = g:tailx - g:headx
  let dy = g:taily - g:heady
  if dx == 0 || dy == 0
    if abs(dx) >= 2
      let g:rope[a:i][0] -= Sign(dx)
    endif
    if abs(dy) >= 2
      let g:rope[a:i][1] -= Sign(dy)
    endif
  elseif [abs(dx), abs(dy)] != [1, 1]
    let g:rope[a:i][0] -= Sign(dx)
    let g:rope[a:i][1] -= Sign(dy)
  endif
endfunction


let lines = readfile("C:/Users/Andrew/Desktop/part9.txt")
for x in lines
  let line = split(x,' ')[0]
  let n = split(x,' ')[1]
  let n = str2nr(n)
  let ans1[join([tailx,taily],'==')] = 1
  for i in range(n)
    let dx = m[line][0]
    let dy = m[line][1]
    let headx += dx
    let heady += dy
    call Part1()
    let ans1[join([tailx,taily],'==')] = 1
  endfor
endfor

let headx = 0
let heady = 0
let tailx = 0
let taily = 0

let lines = readfile("C:/Users/Andrew/Desktop/part9.txt")
for x in lines
  let line = split(x,' ')[0]
  let n = split(x,' ')[1]
  let n = str2nr(n)
  let ans2[join([rope[-1][0], rope[-1][1]],"==")] = 1
  for i in range(n)
    let dx = m[line][0]
    let dy = m[line][1]
    let rope[0][0] += dx
    let rope[0][1] += dy
    for i in range(1, 9)
      call Update(i)
    endfor
    let ans2[join([rope[-1][0], rope[-1][1]],"==")] = 1
  endfor
endfor

echo len(ans1) . " " . len(ans2)
