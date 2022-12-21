let content = readfile("C:/Users/Andrew/Desktop/part11.txt")

let ops = []
let tests = []
let conds = []

for i in range(2, len(content), 7)
  call add(ops, content[i][23:])
endfor
for i in range(3, len(content), 7)
  call add(tests, str2nr(content[i][21:]))
endfor
for i in range(4, len(content), 7)
  call add(conds, [str2nr(content[i][29:]), str2nr(content[i+1][30:])])
endfor

let modulo = 1
for i in tests
  let modulo *= i
endfor

echo modulo
function! Solve(pt1) 
  let inspections = []
  let items = {}
  for i in range(len(g:tests))
    call add(inspections, 0)
  endfor
  for i in range(1, len(g:content), 7)
    for j in split(g:content[i][18:], ", ")
      if has_key(items, i/7)
        call add(items[i/7], str2nr(j))
      else
        let items[i/7] = [str2nr(j)]
      endif
    endfor
  endfor
  for junk in range(a:pt1 ? 20 : 10000)
    for i in range(0, len(inspections)-1)
      for j in range(0, len(items[i])-1)
        let current = str2nr(items[i][j])
        if g:ops[i] == "* old"
          let current *= current
        elseif g:ops[i][0] == "*"
          let current *= str2nr(g:ops[i][2:])
        elseif g:ops[i][0] == "+"
          let current += str2nr(g:ops[i][2:])
        endif

        let current = a:pt1 ? current / 3 : current % g:modulo
        if current % g:tests[i] == 0
          call add(items[g:conds[i][0]], current)
        else
          call add(items[g:conds[i][1]], current)
        endif
        let inspections[i] += 1
      endfor
      let items[i] = []
    endfor
  endfor
  echo inspections
  let sorted = sort(inspections, "n")
  echo sorted[-1] * sorted[-2]
endfunction

call Solve(1)
call Solve(0)
