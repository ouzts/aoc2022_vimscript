function! Dist(x, y, bx, by)
  return abs(a:by-a:y) + abs(a:bx-a:x)
endfunction

function! Intersect(sum, diff)
  let x = (a:sum + a:diff) / 2
  let y = a:sum - x
  return [x, y]
endfunction

function! Solve(x, y)
  if a:x >= 0 && a:x <= 4000000 && a:y >= 0 && a:y <= 4000000
    for [sx, sy, bx, by] in g:sensors
      if Dist(sx,sy,a:x,a:y) <= Dist(sx,sy,bx,by)
        return 0
      endif
    endfor
    return 1
  endif
  return 0
endfunction

function! Attempt(sx, sy, bx, by, offset, diag)
  let r = Dist(a:sx, a:sy, a:bx, a:by) + a:offset
  if a:diag
    return [a:sx + a:sy + r, a:sx + a:sy - r]
  else
    return [a:sx - a:sy + r, a:sx - a:sy - r]
  endif
endfunction

let sensors = []

for line in readfile("C:/Users/Andrew/Desktop/part15.txt")
  let words = split(line)
  let sx = str2nr(split(words[2][0:-2],'=')[1])
  let sy = str2nr(split(words[3][0:-2],'=')[1])
  let bx = str2nr(split(words[8][0:-2],'=')[1])
  let by = str2nr(split(words[9],'=')[1])
  call add(sensors, [sx,sy,bx,by])
endfor

let c=0

let counter=0
" Part 1 - this is SLOOOOOOOW in VimL
for x in range(-10000000,10000000)
  let y = 10
  let counter += 1
  for [sx,sy,bx,by] in sensors
    if x == bx && y == by
      break
    endif
    if Dist(sx,sy,x,y) <= Dist(sx,sy,bx,by)
      let c+=1
      break
    endif
  endfor
endfor


function! Part2()
for s1 in g:sensors
  for s2 in g:sensors
    for m1 in Attempt(s1[0], s1[1], s1[2], s1[3], 1, 1)
      for o2 in Attempt(s2[0], s2[1], s2[2], s2[3], 1, 0)
        let p = Intersect(m1, o2)
        if Solve(p[0], p[1])
          return p[0] * 4000000 + p[1]
        endif
      endfor
    endfor
    for o1 in Attempt(s1[0], s1[1], s1[2], s1[3], 1, 0)
      for m2 in Attempt(s2[0], s2[1], s2[2], s2[3], 1, 1)
        let p = Intersect(o1, m2)
        if Solve(p[0], p[1])
          return p[0] * 4000000 + p[1]
        endif
      endfor
    endfor
  endfor
endfor
endfunction!

echo c " " Part2()
