let file = "C:/Users/Andrew/Desktop/part3.txt"
let lines = readfile(file)

let prio = {}
for i in range(char2nr('a'), char2nr('z') + 1)
  let prio[nr2char(i)] = i - char2nr('a') + 1
endfor
for i in range(char2nr('A'), char2nr('Z') + 1)
  let prio[nr2char(i)] = i - char2nr('A') + 27
endfor

" part 1
let rv = 0
for line in lines
  let freq = {}
  for i in range(0, len(line) / 2 - 1)
    let freq[line[i]] = 1
  endfor
  for i in range(len(line) / 2, len(line))
    if has_key(freq, line[i])
      let rv += prio[line[i]]
      break
    endif
  endfor
endfor

echo rv

" part 2
let rv = 0
for i in range(0, len(lines), 3)
  if i >= len(lines)
    break
  endif
  let maps = [{}, {}, {}]
  for ch in lines[i]
    let maps[0][ch] = 1
  endfor
  for ch in lines[i + 1]
    let maps[1][ch] = 1
  endfor
  for ch in lines[i + 2]
    let maps[2][ch] = 1
  endfor
  for [k, v] in items(maps[0])
    if has_key(maps[1], k) && has_key(maps[2], k)
      let rv += prio[k]
      break
    endif
  endfor
endfor

echo rv
