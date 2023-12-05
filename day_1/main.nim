import strutils

const numStrings = @["one", "two", "three", "four", "five", "six",  "seven", "eight", "nine"]
let
    lines = splitLines(readFile("input.txt"))
var sum: int

# part 1
for l in lines:
    for c in l:
        if isDigit(c):
            sum += (ord(c) - ord('0')) * 10
            break
    for i in countdown(l.len - 1, 0):
        if isDigit(l[i]):
            sum += (ord(l[i]) - ord('0'))
            break

echo sum

# part 2
sum = 0
for l in lines:
    block lr:
        for i in countup(0, l.len - 1):
            if isDigit(l[i]):
                sum += (ord(l[i]) - ord('0')) * 10
                break lr
            else:
                for j, str in numStrings:
                    if (l[i..l.len - 1].find(str) == 0):
                        sum += (j + 1) * 10
                        break lr
    block rl:
        for i in countdown(l.len - 1, 0):
            if isDigit(l[i]):
                sum += (ord(l[i]) - ord('0'))
                break rl
            else:
                for j, str in numStrings:
                    if (l[i..l.len - 1].find(str) == 0):
                        sum += j + 1
                        break rl

echo sum