let data = readfile("C:/Users/Andrew/Desktop/part14.txt")
let lines = []
for line in data
  let numbers = []
  let splt = split(line, "->")
  for item in splt
    let nums = split(join(split(item)), ",")
    call add(numbers, nums[0])
    call add(numbers, nums[1])
  endfor

  for i in range(3, len(numbers)-1, 2)
    call add(lines, [numbers[i - 3], numbers[i - 2], numbers[i - 1], numbers[i]])
  endfor
endfor

let grid = []
for i in range(700)
  let row = []
  for j in range(700)
    call add(row, '.')
  endfor
  call add(grid, row)
endfor

let maxY = 0
for line in lines
  let start = line[0:1]
  let end = line[2:]
  let maxY = max([maxY, start[1], end[1]])
  if start[0] == end[0]
    let mn = min([start[1], end[1]])
    let mx = max([start[1], end[1]])
    for i in range(mn, mx)
      let grid[i][start[0]] = '#'
    endfor
  else
    let mn = min([start[0], end[0]])
    let mx = max([start[0], end[0]])
    for i in range(mn, mx)
      let grid[start[1]][i] = '#'
    endfor
  endif
endfor

function! Solve(grid, part2) 
  let rv = 0
  let sand = [500, 0]
  while 1
    if a:part2 && sand[1] == (g:maxY + 1)
      let rv += 1
      if get(a:grid[sand[1]], sand[0], 'y') != 'y'
        let a:grid[sand[1]][sand[0]] = 'o'
      endif
      let sand = [500, 0]
    elseif !a:part2 && sand[1] > g:maxY
      return rv
    elseif get(a:grid[sand[1] + 1], sand[0], 'y') == '.'
      let sand[1] += 1
    elseif get(a:grid[sand[1] + 1], sand[0] - 1, 'y') == '.'
      let sand[1] += 1
      let sand[0] -= 1
    elseif get(a:grid[sand[1] + 1], sand[0] + 1, 'y') == '.'
      let sand[1] += 1
      let sand[0] += 1
    else
      let rv += 1
      if sand[0] == 500 && sand[1] == 0
        break
      endif
      let a:grid[sand[1]][sand[0]] = 'o'
      let sand = [500, 0]
    endif
  endwhile
  return rv
endfunction

echo Solve(deepcopy(grid), 0) . " " . Solve(deepcopy(grid), 1)
