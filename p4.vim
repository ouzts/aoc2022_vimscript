function! DataPoint(b1, e1, b2, e2)
  let self = {}
  let self.b1 = a:b1
  let self.e1 = a:e1
  let self.b2 = a:b2
  let self.e2 = a:e2
  return self
endfunction

let lines = readfile("C:/Users/Andrew/Desktop/part4.txt")

let data_points = []
for line in lines
  let elements = []
  let initial_split = split(line, ',')
  call add(elements, str2nr(split(initial_split[0], '-')[0]))
  call add(elements, str2nr(split(initial_split[0], '-')[1]))
  call add(elements, str2nr(split(initial_split[1], '-')[0]))
  call add(elements, str2nr(split(initial_split[1], '-')[1]))

  let data_point = DataPoint(elements[0], elements[1], elements[2], elements[3])
  call add(data_points, data_point)
endfor

let Pt1_cond = {val, pt -> (((pt.b1 <= pt.b2) && (pt.e1 >= pt.e2)) || ((pt.b2 <= pt.b1) && (pt.e2 >= pt.e1))) ? (val + 1) : val}
let Pt2_cond = {val, pt -> (((pt.e1 >= pt.b2) && (pt.e1 <= pt.e2)) || ((pt.e1 >= pt.e2) && (pt.b1 <= pt.e2))) ? (val + 1) : val}

echo reduce(data_points, Pt1_cond, 0) . "\n"
echo reduce(data_points, Pt2_cond, 0) . "\n"
