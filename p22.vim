let lines = readfile("C:/Users/Andrew/Desktop/part22.txt")
let map = deepcopy(lines[0:-2])
for i in range(len(map))
  let map[i] = ' ' . map[i] . ' '
endfor

let empty = repeat(nr2char(32), len(map[0]))
call add(map, empty)
call insert(map, empty)

for i in range(len(map))
  if len(map[i]) != len(map[1])
    let map[i] = map[i] . repeat(nr2char(32), 152 - len(map[i]))
  endif
endfor

let start = stridx(lines[0], '.')
let moves = split(lines[-1], '/\d/\+\|[RL]\zs')

let right = [0,1]
let down = [1,0]
let left = [0,-1]
let up = [-1,0]
let dir = right

let x = 1
let y = start+1

for move in moves
  let ridx = stridx(move, 'R')
  let lidx = stridx(move, 'L')
  let ct = 0
  if ridx == -1 && lidx == -1
    let ct = str2nr(move)
  else
    let ct = str2nr(move[:-1])
  endif

  for i in range(ct)
    let orig = [deepcopy(x), deepcopy(y)]
    let [x, y] = [x + dir[0], y + dir[1]]

    if map[x][y] == ' '
      let [x, y] = [x - dir[0], y - dir[1]]
      while map[x][y] != ' '
        let [x, y] = [x - dir[0], y - dir[1]]
      endwhile
      let [x, y] = [x + dir[0], y + dir[1]]
      if map[x][y] == '#'
        let [x,y] = orig
        break
      endif
    endif
    if map[x][y] == '#'
      let [x, y] = [x - dir[0], y - dir[1]]
      break
    endif
  endfor

  if ridx != -1
    if dir == right | let dir = down
    elseif dir == left | let dir = up
    elseif dir == up | let dir = right
    elseif dir == down | let dir = left
    endif
  elseif lidx != -1
    if dir == right | let dir = up
    elseif dir == left | let dir = down
    elseif dir == up | let dir = left
    elseif dir == down | let dir = right
    endif
  endif
endfor

let rv = 1000*(x) + 4*(y) + (dir == right ? 0 : dir == down ? 1 : dir == left ? 2 : 3)
echo rv
