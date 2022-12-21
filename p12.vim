function! Solve(part1)
  let data = []
  let steps = 0
  let q = []
  let start = {}
  let goal = {}

  let data = readfile("C:/Users/Andrew/Desktop/part12.txt")

  for i in range(len(data))
    for j in range(strlen(data[i]))
      if data[i][j] ==# 'S'
        if j == 0
          let data[i] = 'a' . data[i][1:]
        else
          let data[i] = data[i][0:j-1] . 'a' . data[i][j+1:]
        endif
        call add(q, {'i': i, 'j': j})
      elseif data[i][j] ==# 'E'
        let goal = {'i': i, 'j': j}
        if j == 0
          let data[i] = 'z' . data[i][1:]
        else
          let data[i] = data[i][0:j-1] . 'z' . data[i][j+1:]
        endif
      elseif data[i][j] ==# 'a' && !a:part1
        call add(q, {'i': i, 'j': j})
      endif
    endfor
  endfor

  let dirs = [{'i': 0, 'j': 1}, {'i': 1, 'j': 0}, {'i': -1, 'j': 0}, {'i': 0, 'j': -1}]
  let visited = {}

  while len(q) > 0
    let sz = len(q)
    for i in range(sz)
      let node = q[0]
      call remove(q, 0)
      let visited[string(node)] = 1
      if node.i == goal.i && node.j == goal.j
        return steps
      endif
      let elev = data[node.i][node.j]
      for dir in dirs
        let x = node.i + dir.i
        let y = node.j + dir.j
        if x >= 0 && y >= 0 && x < len(data) && y < strlen(data[0])
          if char2nr(data[x][y]) > char2nr(data[node.i][node.j]) + 1
            continue
          endif
          if has_key(visited, string({'i': x, 'j': y}))
            continue
          endif
          let visited[string({'i': x, 'j': y})] = 1
          call add(q, {'i': x, 'j': y})
        endif
      endfor
    endfor
    let steps += 1
  endwhile
endfunction

echo Solve(1) . " " . Solve(0)
