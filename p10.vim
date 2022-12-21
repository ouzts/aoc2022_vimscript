let lines = readfile("C:/Users/Andrew/Desktop/part10.txt")
let accumulated = [1]
let val = 1

for line in lines
  if line == "noop"
    call add(accumulated, val)
  else
    call add(accumulated, val)
    let val += str2nr(split(line)[1])
    call add(accumulated, val)
  endif
endfor

let ans1=0
let ans2=""
for i in range(1,len(accumulated)-1)
  let cur = accumulated[i]
  if (i+1)%40 == 20
    let ans1 += (i+1)*cur
  endif
  if abs(i%40 - cur) < 2
    let ans2 .= "#"
   else 
    let ans2 .= " "
  endif
  if (i+1)%40 == 0
    let ans2 .= "\n"
  endif
endfor

echo ans1
echo ans2
