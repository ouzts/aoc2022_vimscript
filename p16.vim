let flowMap = {}
let adj = {}
let opened = {"AA":1}
let dist = {}
let nonZeroFlowNodes = ["AA"]
let rv = 0

function! Solve(opened, flow, room, time, part2, elephant)
  let g:rv = max([g:rv, a:flow])
  if a:time <= 0
    return
  endif

  if !has_key(a:opened, a:room)
    let a:opened[a:room] = 1
    call Solve(a:opened, a:flow + g:flowMap[a:room] * a:time, a:room, a:time - 1, a:part2, a:elephant)
    if a:part2 && !a:elephant
      call Solve(a:opened, a:flow + g:flowMap[a:room] * a:time, "AA", 25, 1, 1)
    endif
    call remove(a:opened, a:room)
  else
    " This room is already opened - find another path.
    " Only attempt to move to unopened valves that have a positive flow
    for tunnel in g:nonZeroFlowNodes
      if !has_key(a:opened, tunnel)
        call Solve(a:opened, a:flow, tunnel, a:time - g:dist[string([a:room,tunnel])], a:part2, a:elephant)
      endif
    endfor
  endif
endfunction


function! Bfs(initial, goal)
  let q = [a:initial]
  let depth = 0
  while !empty(q)
    let sz = len(q)
    for i in range(sz)
      let next = q[0]
      call remove(q, 0)
      if next == a:goal
        return depth
      endif
      for path in g:adj[next]
        if path == a:goal
          return depth + 1
        endif
        call add(q, path)
      endfor
    endfor
    let depth += 1
  endwhile

  return -1
endfunction

let lines = readfile("C:/Users/Andrew/Desktop/part16.txt")
for line in lines
  let iss = split(line, ' ')
  let valveID = iss[1]
  let flow = str2nr(split(iss[4],'=')[1])
  let tunnels = []
  let i = 9
  while i <= len(iss) - 1
    let tunnel = iss[i]
    let tunnel = tunnel[0:1]
    call add(tunnels, tunnel)
    let i += 1
  endwhile

  let flowMap[valveID] = flow
  let adj[valveID] = tunnels

  if flow > 0
    call add(g:nonZeroFlowNodes, valveID)
  endif
endfor

for valve1 in nonZeroFlowNodes
  for valve2 in nonZeroFlowNodes
    if valve1 != valve2
      let dist[string([valve1,valve2])] = Bfs(valve1, valve2) 
    endif
  endfor
endfor

call Solve(opened, 0, "AA", 29, 0, 0)
echo rv
let rv = 0
let opened = {"AA":1}
call Solve(opened, 0, "AA", 25, 1, 0)
echo rv
