"let lines = readfile("C:/Users/Andrew/Desktop/part1_test.txt")
let lines = readfile("C:/Users/Andrew/Desktop/part1.txt")

let groups = []
let cur_group = []
for line in lines
  if line == ""
    call add(groups, cur_group)
    let cur_group = []
  else
    call add(cur_group, line)
  endif
endfor

let data = []
for grp in groups
  let sum = 0
  for val in grp
    let sum += str2nr(val)
  endfor
  call add(data, sum)
endfor

call sort(data, 'n')
call reverse(data)

let ans1 = remove(data, 0)
let ans2 = ans1 + remove(data, 0) + remove(data, 0)

echo ans1 . " " . ans2
