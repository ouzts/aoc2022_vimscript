let cubes = []
for line in readfile('C:/Users/Andrew/Desktop/part18.txt')
  let data = split(line,",")
  call add(cubes, [str2nr(data[0]), str2nr(data[1]), str2nr(data[2])])
endfor

function! Sides(x,y,z)
  return [[a:x+1,a:y,a:z], [a:x-1,a:y,a:z], [a:x,a:y+1,a:z], [a:x,a:y-1,a:z], [a:x,a:y,a:z+1], [a:x,a:y,a:z-1]]
endfunction

let rv = 0
for c in cubes
  for s in Sides(c[0], c[1], c[2])
    if count(cubes, s) == 0
      let rv += 1
    endif
  endfor
endfor
echo rv

let mins = [0,0,0]
let maxes = [0,0,0]
for cube in cubes
  let mins[0] = min([mins[0], cube[0]])
  let mins[1] = min([mins[1], cube[1]])
  let mins[2] = min([mins[2], cube[2]])
  let maxes[0] = max([maxes[0], cube[0]])
  let maxes[1] = max([maxes[1], cube[1]])
  let maxes[2] = max([maxes[2], cube[2]])
endfor

for i in range(3)
  let mins[i] -= 1
  let maxes[i] += 1
endfor

let pts = {}
let q = []
call add(q, mins)

while !empty(q)
  let [x,y,z] = q[0]
  call remove(q, 0)

  if has_key(pts, string([x, y, z]))
    continue
  endif

  let pts[string([x,y,z])] = 1
  let sides = Sides(x, y, z)
  for [sx, sy, sz] in sides
    if mins[0] <= sx && sx <= maxes[0] && mins[1] <= sy && sy <= maxes[1] && mins[2] <= sz && sz <= maxes[2]
       if count(cubes, [sx, sy, sz]) == 0
         call add(q, [sx,sy,sz])
       endif
     endif
  endfor
endwhile

let ptstwo = {}
for x in range(mins[0], maxes[0])
  for y in range(mins[1], maxes[1])
    for z in range(mins[2], maxes[2])
      if !has_key(pts, string([x,y,z]))
        let ptstwo[string([x,y,z])] = 1
      endif
    endfor
  endfor
endfor


let rv = 0
for c in keys(ptstwo)
  let thecube = eval(c)
  for s in Sides(thecube[0], thecube[1], thecube[2])
    if !has_key(ptstwo, string(s))
      let rv += 1
    endif
  endfor
endfor
echo rv
