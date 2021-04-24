import fs from 'fs'

var accumulator = 0
var commandArray = []

//Since we are reading a local file, we choose to read it using readFileSync
var ourInput = fs.readFileSync('HandheldHalting.txt', 'utf-8').split("\n")

for (let index = 0; index < ourInput.length; index++) {
    const element = ourInput[index];
    commandArray[index] = [element.trim(), false]
}

var index = 0
while (index < commandArray.length) {
    const element = commandArray[index];
    if (element[1]) break

    var command = element[0].split(" ")
    if (command[0] == "acc"){
        accumulator = eval(accumulator + command[1])
        index++
    } else if (command[0] == "nop"){
        index++
    } else if (command[0] == "jmp"){
        index = eval(index + command[1])
    }

    element[1] = true
}

console.log(accumulator)