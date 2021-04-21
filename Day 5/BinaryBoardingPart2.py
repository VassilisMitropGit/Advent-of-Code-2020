myfile = open("BinaryBoarding.txt", "r")
boardingPasses = myfile.readlines()
myfile.close()

minRow = 0
maxRow = 127
minColumn = 0
maxColumn = 7
maxID = 0
IDs = []

def calculateSeat(rowString, columnString, firstRow, lastRow, firstColumn, lastColumn):

    #find the respective row
    row = list(range(firstRow, lastRow+1))
    if (rowString[0] == "F"):
        row = row[:len(row)//2]
    else:
        row = row[len(row)//2:]
    if (rowString[1] == "F"):
        row = row[:len(row)//2]
    else:
        row = row[len(row)//2:]
    if (rowString[2] == "F"):
        row = row[:len(row)//2]
    else:
        row = row[len(row)//2:]
    if (rowString[3] == "F"):
        row = row[:len(row)//2]
    else:
        row = row[len(row)//2:]
    if (rowString[4] == "F"):
        row = row[:len(row)//2]
    else:
        row = row[len(row)//2:]
    if (rowString[5] == "F"):
        row = row[:len(row)//2]
    else:
        row = row[len(row)//2:]
    if (rowString[6] == "F"):
        row = row[:len(row)//2]
    else:
        row = row[len(row)//2:]
    

    #find the respective column
    column = list(range(firstColumn, lastColumn+1))
    if (columnString[0] == "L"):
        column = column[:len(column)//2]
    else:
        column = column[len(column)//2:]
    if (columnString[1] == "L"):
        column = column[:len(column)//2]
    else:
        column = column[len(column)//2:]
    if (columnString[2] == "L"):
        column = column[:len(column)//2]
    else:
        column = column[len(column)//2:]

    return row[0], column[0]


def calculateID(row, column):
    return (row * 8 + column)

for boardingPass in boardingPasses:
    row, column = calculateSeat(boardingPass[:7], boardingPass[7:10], minRow, maxRow, minColumn, maxColumn)
    ID = calculateID(row, column)
    IDs.append(ID)
    if (ID > maxID):
        maxID = ID

IDs.sort()

for id in IDs:
    my_seat = id+1
    if (not my_seat in IDs): 
        print(my_seat)
        break