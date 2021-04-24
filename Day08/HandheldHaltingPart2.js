import fs from 'fs'

var accumulator = 0
var commandArray = []
var visitedArray = []

//Since we are reading a local file, we choose to read it using readFileSync
var ourInput = fs.readFileSync('HandheldHalting.txt', 'utf-8').split("\n")

for (let index = 0; index < ourInput.length; index++) {
    const element = ourInput[index]
    commandArray[index] = element.trim()
    visitedArray[index] = false
}

bootSystem()
console.log(accumulator)

function bootSystem() {
    var index = 0
    while (index < commandArray.length) {
        var command = commandArray[index].split(" ")
        if (command[0] == "acc"){
            visitedArray[index] = true
            accumulator = eval(accumulator + command[1])
            index++
        } else if (command[0] == "nop"){
            visitedArray[index] = true
            const tempArray = [...visitedArray]
            var tempAccum = accumulator
            if (isWinningPosition(tempArray, eval(index + command[1]))){
                break
            } else {
                accumulator = tempAccum
                index++
            }
        } else if (command[0] == "jmp"){
            visitedArray[index] = true
            const tempArray = [...visitedArray]
            var tempAccum = accumulator
            if (isWinningPosition(tempArray, index + 1)){
                break
            } else {
                accumulator = tempAccum
                index = eval(index + command[1])
            }
        }
    }
}

function isWinningPosition(visited, j) {
    var index = j
    while (index < commandArray.length){
        if (visited[index]){
            return false
        }
        var command = commandArray[index].split(" ")
        if (command[0] == "acc"){
            visited[index] = true
            accumulator = eval(accumulator + command[1])
            index++
        } else if (command[0] == "nop"){
            visited[index] = true
            index++
        } else if (command[0] == "jmp"){
            visited[index] = true
            index = eval(index + command[1])
        }
    }
    return true
}