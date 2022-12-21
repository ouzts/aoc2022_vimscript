function! Parse_stack_text(stacktext)
  let stacks = ["","","","","","","","",""]
  for line in a:stacktext
    let i = 0
    for i in range(1, len(line), 4)
      let box = line[i]
      if box != " "
        let idx = i/4 
        let stacks[idx] .= box
      endif
      let i += 1
    endfor
  endfor
  return stacks
endfunction

let input_data = readfile("C:/Users/Andrew/Desktop/part5.txt")
let stackt=[]
let instructions = []
for line in input_data
  if line == ""
    call add(stackt, instructions)
    let instructions = []
  else
    call add(instructions, line)
  endif
endfor

let stackt = stackt[0]
call remove(stackt, -1)
let stacks = Parse_stack_text(stackt)

let p1 = copy(stacks)
let p2 = copy(stacks)

for line in instructions
  let parts = split(line, " ")
  let n = str2nr(parts[1])
  let src = str2nr(parts[3]) - 1
  let dest = str2nr(parts[5]) - 1
  let p2tmp = p2[src][0:n-1]
  let tmp = join(reverse(split(p1[src][0:n-1],'\zs')),'')
  let p1[src] = p1[src][n:]
  let p2[src] = p2[src][n:]
  let p1[dest] = tmp . p1[dest]
  let p2[dest] = p2tmp . p2[dest]
endfor

let ans=''
for e in p1
  let ans = ans . e[0]
endfor
echo ans

let ans = ''
for e in p2
  let ans = ans . e[0]
endfor
echo ans


"echo "Part 1: " . join([s[0] for s in p1 if s])
"echo "Part 2: " . join([s[0] for s in p2 if s])
