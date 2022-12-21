let dirs = [[0,1], [1,0], [0,-1], [-1,0]]

let lines = readfile("C:/Users/Andrew/Desktop/part13.txt")
let s = []
for i in range(0, len(lines), 3)
  let a = eval(lines[i])
  let b = eval(lines[i+1])
  call add(s, [a, b])
endfor


function! Zip(a, b)
  let zipped = []
  let n = min([len(a:a), len(a:b)])
  for i in range(n)
    let tuple = []
    call add(tuple, a:a[i])
    call add(tuple, a:b[i])
    call add(zipped, tuple)
  endfor
  return zipped
endfunction

function! Sigcmp(a, b)
  if a:a < a:b | return -1
  elseif a:a == a:b | return 0
  else | return 1
  endif
endfunction

function! Cmp(a, b)
  let a = copy(a:a)
  let b = copy(a:b)
  if type(a) == type(0) && type(b) == type(0)
    return Sigcmp(a, b)
  elseif type(a) == type([]) && type(b) == type(0)
    let b = [b]
  elseif type(a) == type(0) && type(b) == type([])
    let a = [a]
  endif

  let n = len(a)
  let m = len(b)
  for [zipped_a, zipped_b] in Zip(a, b)
    let r = Cmp(zipped_a, zipped_b)
    if r != 0
      return r
    endif
  endfor

  return Sigcmp(n,m)
endfunction

let r = 0
let i = 0
for pair in s
  let a = pair[0]
  let b = pair[1]
  if Cmp(a, b) == -1
    let r += i + 1
  endif
  let i += 1
endfor
echo r

let packets = []
for pair in s
  let a = pair[0]
  let b = pair[1]
  call add(packets, a)
  call add(packets, b)
endfor

call add(packets, [[2]])
call add(packets, [[6]])

for i in range(len(packets))
  for j in range(len(packets) - 1)
    if Cmp(packets[j], packets[j+1]) > 0
      let tmp = packets[j]
      let packets[j] = packets[j+1]
      let packets[j+1] = tmp
    endif
  endfor
endfor

let [x, y] = filter(range(len(packets)), 'packets[v:val] == [[2]] || packets[v:val] == [[6]]')
echo (x + 1) * (y + 1)
