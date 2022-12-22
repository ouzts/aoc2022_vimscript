function! Part1(ans)
  call Solve('root', a:ans)
  return str2nr(a:ans['root'])
endfunction

function! Part2(ans)
  let a:ans['humn'] = v:null
  let [a,junk,b] = g:operations['root']
  call Solve(a, a:ans)
  call Solve(b, a:ans)
  let tgt = a:ans[a] == v:null ? a : b
  let cur = tgt == a ? a:ans[b] : a:ans[a]
  while tgt != 'humn'
    let [a, op, b] = g:operations[tgt]
    let tgt = a:ans[a] == v:null ? a : b
    let cur = tgt == a ? g:rops[op][1](cur, a:ans[b]) : g:rops[op][0](cur, a:ans[a])
  endwhile
  return str2nr(cur)
endfunction

function! Solve(tgt, ans)
  while !has_key(a:ans, a:tgt)
    for [_id, bpart] in items(g:operations)
      let [a,op,b] = bpart
      if has_key(a:ans, _id) | continue | endif
      if has_key(a:ans, a) && has_key(a:ans, b)
        if a:ans[a] == v:null || a:ans[b] == v:null | let v = v:null
        else | let v = g:ops[op](a:ans[a], a:ans[b])
        endif
        let a:ans[_id] = v
      endif
    endfor
  endwhile
endfunction

let g:ops={'+':{a,b->a+b},'-':{a,b->a-b},'*':{a,b->a*b},'/':{a,b->a/b}}
let g:rops={'+':[{c,x->c-x},{c,x->c-x}],'-':[{c,x->x-c},{c,x->c+x}],'*':[{c,x->c/x},{c,x->c/x}],'/':[{c,x->x/c},{c,x->c*x}] }
let ans = {}
let input_ = readfile('C:/Users/Andrew/Desktop/part21.txt')
let operations = {}
for [_id, op] in map(input_, { idx, val -> split(val, ': ') })
  if len(split(op, ' ')) == 1 | let ans[_id] = str2nr(op)
  else
    let new_op = split(op, ' ')
    let operations[_id] = new_op
  endif
endfor
echo Part1(deepcopy(ans)) . " " . Part2(deepcopy(ans))
