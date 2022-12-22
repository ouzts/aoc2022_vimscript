function! Bfs(bp)
  " Values by idx:
  " 0 => ore
  " 1 => clay
  " 2 => obsidian
  " 3 => geodes
  " 4 => ore robots
  " 5 => clay robots
  " 6 => obsidian robots
  " 7 => geode robots
  " 8 => used mask
  " 9 => time
  let init = [0, 0, 0, 0, 1, 0, 0, 0, 15, 0]
  let q = [init]
  let geodes = 0
  let GEO_ORE_COST = 5
  let GEO_OBS_COST = 6
  let ORE_COST = 1
  let CLAY_COST = 2
  let OBS_ORE_COST = 3
  let OBS_CLAY_COST = 4
  while !empty(q)
    let state = q[0]
    call remove(q, 0)

    if state[9] == 25 " 33 for part 2
      let geodes = max([geodes, state[3]])
      continue
    endif
    let state[9] += 1

    " todo make sure a:bp indices are right
    if state[0] >= a:bp[GEO_ORE_COST] && state[2] >= a:bp[GEO_OBS_COST] && (and(state[8],(1*float2nr(pow(2,3)))))
      let newRes = deepcopy(state)
      for i in range(4)
        let newRes[i] += state[i+4]
      endfor
      let newRes[0] -= a:bp[GEO_ORE_COST]
      let newRes[2] -= a:bp[GEO_OBS_COST]
      let newRes[7] += 1
      let newRes[8] = 15
      let state[8] = xor(state[8], invert(1<<3))
      call insert(q, newRes)
      continue
    endif

    if state[0] >= a:bp[ORE_COST] && state[4] < 5 && (and(state[8],(1*float2nr(pow(2,0)))))
      let newRes = deepcopy(state)
      for i in range(4)
        let newRes[i] += state[i+4]
      endfor
      let newRes[0] -= a:bp[ORE_COST]
      let newRes[4] += 1
      let newRes[8] = 15
      let state[8] = xor(state[8], invert(1*float2nr(pow(2,0))))
      call insert(q, newRes)
    endif

    if state[0] >= a:bp[CLAY_COST] && state[5] < 20 && (and(state[8],(1*float2nr(pow(2,1)))))
      let newRes = deepcopy(state)
      for i in range(4)
        let newRes[i] += state[i+4]
      endfor
      let newRes[0] -= a:bp[CLAY_COST]
      let newRes[5] += 1
      let newRes[8] = 15
      let state[8] = xor(state[8], invert(1*float2nr(pow(2,1))))
      call insert(q, newRes)
    endif

    if state[1] >= a:bp[OBS_CLAY_COST] && state[0] >= a:bp[OBS_ORE_COST] && state[6] < 12 && (and(state[8],(1*float2nr(pow(2,2)))))
      let newRes = deepcopy(state)
      for i in range(4)
        let newRes[i] += state[i+4]
      endfor
      let newRes[1] -= a:bp[OBS_CLAY_COST]
      let newRes[0] -= a:bp[OBS_ORE_COST]
      let newRes[6] += 1
      let newRes[8] = 15
      let state[8] = xor(state[8], invert(1*float2nr(pow(2,2))))
      call insert(q, newRes)
    endif

    if state[8] && state[0] < 7
      for i in range(4)
        let state[i] += state[i+4]
      endfor
      call insert(q, state)
    endif
  endwhile
  return geodes
endfunction
let blueprints = []
let lines = readfile("C:/Users/Andrew/Desktop/part19_test.txt")
let idx = 1
for line in lines
  let data = split(line)
  let i = idx
  let a = str2nr(data[6])
  let b = str2nr(data[12])
  let c = str2nr(data[18])
  let d = str2nr(data[21])
  let e = str2nr(data[27])
  let f = str2nr(data[30])
  let idx += 1
  call add(blueprints, [i,a,b,c,d,e,f])
endfor

let ans = 0 " 1 for part 2
for bp in blueprints " range(3) for part 2
  let rv = Bfs(blueprints[0])
  let ans += rv * bp[0] " ans *= rv for part 2
endfor
echo ans
