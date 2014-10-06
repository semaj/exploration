import sys
argString = sys.stdin.readline()
args = argString.split()

n1 = args[0]
n2 = args[1]
nth = args[2]

n1 = int(float(n1))
n2 = int(float(n2))
nth = int(float(nth))

solution = 0

for i in range(0, nth -1):
    prevSolution = solution
    solution = n2 * n2 + n1
    n2 = solution
    n1 = prevSolution



print(solution)

test = 0
