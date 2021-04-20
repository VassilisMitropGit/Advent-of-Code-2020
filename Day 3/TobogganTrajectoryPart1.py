trajectory = open("TobogganTrajectory.txt", "r")
trajectoryLines = trajectory.readlines()
trajectory.close()

length = len(trajectoryLines[1].strip())
size = len(trajectoryLines)

treeCount = 0
reachedFinalRow = False
column = 0
row = 0

while not reachedFinalRow:
    if (column >= length):
        column = column - length
    if (trajectoryLines[row].strip()[column] == "#"):
        treeCount += 1
    row += 1
    column += 3
    if (row == size):
        reachedFinalRow = True

print(treeCount)