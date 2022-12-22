let lines = readfile("C:/Users/Andrew/Desktop/part22.txt")
let map = deepcopy(lines[0:-2])
for i in range(len(map))
  let map[i] = ' ' . map[i] . ' '
endfor
let empty = repeat(nr2char(32), 300)
echo "Len of map is " len(map)
let mx=0
for line in map
  let mx = max([len(line), mx])
endfor
echo "Max individual is " mx
call add(map, empty)
call insert(map, empty)

for i in range(len(map))
  if len(map[i]) != 152
    let delta = 152 - len(map[i])
    let emptiness = repeat(nr2char(32), delta)
    let map[i] = map[i] . emptiness
  endif
  echo "Length of map[i] is " len(map[i])
endfor
"echo map

let start = stridx(lines[0], '.')
let moves = split(lines[-1], '/\d/\+\|[RL]\zs')
"echo map

let right = [0,1]
let down = [1,0]
let left = [0,-1]
let up = [-1,0]
let dir = right

let x = 1
let y = start+1

"echo "Moves: " moves
for move in moves
  let ridx = stridx(move, 'R')
  let lidx = stridx(move, 'L')
  let ct = 0
  if ridx == -1 && lidx == -1
    let ct = str2nr(move)
  else
    let ct = str2nr(move[:-1])
  endif

  echo "Moving " ct " elements in dir " dir " from " [x,y]
  for i in range(ct)
    let origX = deepcopy(x)
    let origY = deepcopy(y)
    let x += dir[0]
    let y += dir[1]

    echo "At " [x,y] " map is " char2nr(map[x][y])
    if map[x][y] == ' '
      echo "Empty spot at " [x,y] " , backing up"
      let x -= dir[0]
      let y -= dir[1]
      while map[x][y] != ' '
        let x -= dir[0]
        let y -= dir[1]
      endwhile
      let x += dir[0]
      let y += dir[1]
      echo "Finally wrapped around at " [x,y]
      if map[x][y] == '#'
        echo "Couldnt wrap around, resetting to " [origX, origY]
        let x = origX
        let y = origY
        break
      endif
    endif
    if map[x][y] == '#'
      let x -= dir[0]
      let y -= dir[1]
      break
    endif
  endfor
"  echo "Position at end: " [x,y]

  if ridx != -1
    if dir == right
      let dir = down
    elseif dir == left
      let dir = up
    elseif dir == up
      let dir = right
    elseif dir == down
      let dir = left
    endif
    
  elseif lidx != -1
    if dir == right
      let dir = up
    elseif dir == left
      let dir = down
    elseif dir == up
      let dir = left
    elseif dir == down
      let dir = right
    endif
  endif
endfor

echo "Final y is " y ", final x is " x+1

let rv = 1000*(x) + 4*(y)
let bonus = dir == right ? 0 : dir == down ? 1 : dir == left ? 2 : 3
echo "Final dir was " dir " so bonus was " bonus
let rv += bonus
echo rv

