let lines = readfile("C:/Users/Andrew/Desktop/part2.txt")
let scores1 = {"A X": 4, "A Y": 8, "A Z": 3, "B X": 1, "B Y": 5, "B Z": 9, "C X": 7, "C Y": 2, "C Z": 6}
let scores2 = {"A X": 3, "A Y": 4, "A Z": 8, "B X": 1, "B Y": 5, "B Z": 9, "C X": 2, "C Y": 6, "C Z": 7}
let ans1 = reduce(lines, {sum, val -> sum + g:scores1[val]}, 0)
let ans2 = reduce(lines, {sum, val -> sum + g:scores2[val]}, 0)
echo ans1 . ' ' . ans2
