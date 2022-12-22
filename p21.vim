let g:operators={'+':{a,b->a+b},'-':{a,b->a-b},'*':{a,b->a*b},'/':{a,b->a/b}}
let g:reverse_operators={'+':[{c,x->c-x},{c,x->c-x}],'-':[{c,x->x-c},{c,x->c+x}],'*':[{c,x->c/x},{c,x->c/x}],'/':[{c,x->x/c},{c,x->c*x}] }

function! Part1(data)
  let solved = {}
  for [id, op] in a:data
    if len(split(op, ' ')) == 1
      let solved[id] = str2nr(op)
    endif
  endfor
  while !has_key(solved, 'root')
    for [id, op] in a:data
      if has_key(solved, id)
        continue
      endif
      let [a, operator, b] = split(op, ' ')
      if has_key(solved, a) && has_key(solved, b)
        let v = g:operators[operator](solved[a], solved[b])
        let solved[id] = v
      endif
    endfor
  endwhile
  return str2nr(solved['root'])
endfunction

function! Propagate(target, solved, operations)
  while !has_key(a:solved, a:target)
    for [_id, thesecondpart] in items(a:operations)
      let a = thesecondpart[0]
      let task = thesecondpart[1]
      let b = thesecondpart[2]
      if has_key(a:solved, _id)
        continue
      endif
      if has_key(a:solved, a) && has_key(a:solved, b)
        let aa = a:solved[a]
        let bb = a:solved[b]
        if aa == v:null || bb == v:null
          let v = v:null
        else
          let v = g:operators[task](a:solved[a], a:solved[b])
        endif
        let a:solved[_id] = v
      endif
    endfor
  endwhile
endfunction

function! Part2(data)
  let known = {}
  let operations = {}
  for [_id, op] in a:data
    if len(split(op, ' ')) == 1
      let known[_id] = str2nr(op)
    else
      let [a, task, b] = split(op, ' ')
      let new_op = [a, task, b]
      let operations[_id] = new_op
    endif
  endfor
  let known['humn'] = v:null
  let [thefirst,junk,thesecond] = operations['root']
  call Propagate(thefirst, known, operations)
  call Propagate(thesecond, known, operations)
  if known[thefirst] is v:null
    let target = thefirst
    let current = known[thesecond]
  else
    let target = thesecond
    let current = known[thefirst]
  endif
  while target != 'humn'
    let [a, op, b] = operations[target]
    if known[a] is v:null
      let target = a
      let current = g:reverse_operators[op][1](current, known[b])
    endif
    if known[b] is v:null
      let target = b
      let current = g:reverse_operators[op][0](current, known[a])
    endif
  endwhile
  let solution = str2nr(current)
  return solution
endfunction

let input_ = readfile('C:/Users/Andrew/Desktop/part21.txt')
let data = map(input_, { idx, val -> split(val, ': ') })
echo Part1(data) . " " . Part2(data)
