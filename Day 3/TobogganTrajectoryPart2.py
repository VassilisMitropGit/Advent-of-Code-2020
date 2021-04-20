trajectory = open("TobogganTrajectory.txt", "r")
trajectoryLines = trajectory.readlines()
trajectory.close()

length = len(trajectoryLines[1].strip())
size = len(trajectoryLines)

def calculateSlope(right, down):
    column = 0
    row = 0
    treeCount = 0
    reachedFinalRow = False
    while not reachedFinalRow:
        if (column >= length):
            column = column - length
        if (trajectoryLines[row].strip()[column] == "#"):
            treeCount += 1
        row = row + down
        column = column + right
        if (row >= size):
            reachedFinalRow = True
            break
    return(treeCount)

print(
    calculateSlope(1, 1) * 
    calculateSlope(3, 1) *
    calculateSlope(5, 1) *
    calculateSlope(7, 1) *
    calculateSlope(1, 2)
)