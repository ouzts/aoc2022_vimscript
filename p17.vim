"let rocks = [[[0,0],[1,0],[2,0],[3,0]], [[1,0],[0,1],[1,1],[2,1],[1,2]], [[0,2],[1,2],[2,0],[2,1],[2,2]], [[0,0],[0,1],[0,2],[0,3]], [[0,0],[1,0],[0,1],[1,1]] ]
let rocks = [[[0,0], [1,0], [2,0], [3,0]], [[1,0], [0,1], [2,1], [1,2]], [[0,0], [1,0], [2,0], [2,1], [2,2]], [[0,0],[0,1],[0,2],[0,3]], [[0,0],[1,0],[0,1],[1,1]]]
let jets = []
for line in readfile("C:/Users/Andrew/Desktop/part17.txt")
  for letter in line
    let jet = [char2nr(letter) - 61,0]
    call add(jets, jet)
  endfor
endfor
let tower = {}
let top = 0

function! Empty(pos)
  let check1 = a:pos[0] >= 0
  let check2 = a:pos[0] < 7
  let check3 = a:pos[1] > 0
  let check4 = !has_key(g:tower, string(a:pos))
  return check1&&check2&&check3&&check4
endfunction

function! Check(pos, dir, rock)
  let rv = 1
"  echo "Checking if we can move " a:pos " in direction " a:dir " with rock " a:rock
  for r in a:rock
    let newpos = deepcopy(a:pos)
    let newpos[0] = newpos[0] + a:dir[0]
    let newpos[1] = newpos[1] + a:dir[1]
    let newpos[0] = newpos[0] + r[0]
    let newpos[1] = newpos[1] + r[1]
    let rv = rv && Empty(newpos)
  endfor
  return rv
endfunction

let i = 0
let j = 0
for step in range(2022)
  let pos = [2, top+4]
"  echo "On step " step " pos is " pos

  let rock = rocks[i]                             " get next rock
  let i = (i+1) % len(rocks)                      " and inc index
"  echo "Current rock is " rock

  while 1
    let jet = jets[j]                             " get next jet
    let j = (j+1) % len(jets)                     " and inc index
"    echo "Jet is " jet

    if Check(pos, jet, rock)
      let pos[0] += jet[0]                             " maybe move side
      let pos[1] += jet[1]
"      echo "True condition 1, moving to the side."
    endif
    if Check(pos, [0,-1], rock)
"      echo "True condition 2, moving down."
      let pos[1] -= 1
    else
      break                                       " can't move down
    endif
  endwhile

  for r in rock
    let position = deepcopy(pos)
    let position[0] += r[0]
    let position[1] += r[1]
    let tower[string(position)] = 1
  endfor
  let top = max([top, pos[1]+[1,0,2,2,3][i]])     " compute new top
endfor
echo top
