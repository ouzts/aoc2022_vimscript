let orig = []
let part2 = 1
let lines = readfile("C:/Users/Andrew/Desktop/part20.txt")
for line in lines
  call add(orig, (part2 ? 811589153 : 1) * str2nr(line))
endfor

function! EuclideanRemainder(n, m)
  let r = a:n%a:m
  return r>= 0 ? r : r + abs(a:m)

endfunction

let val = 0
let curr = []
for i in range(len(orig))
  call add(curr, val)
  let val += 1
endfor

for j in range(part2 ? 10 : 1)
  for i in range(len(orig))
    let loc = index(curr, i)
    call remove(curr, loc)
    call insert(curr, i, EuclideanRemainder(loc + orig[i], len(curr)))
  endfor
endfor

let orig_0 = index(orig, 0)
let curr_0 = index(curr, orig_0)
let rv = 0
for i in [1000, 2000, 3000]
  let idx = (curr_0 + i) % len(curr)
  let subval = curr[idx]
  let finalval = orig[subval]
  let rv += finalval
endfor
echo rv
