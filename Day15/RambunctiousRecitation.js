import fs from 'fs'

var input = fs.readFileSync('RambunctiousRecitation.txt', 'utf-8').split("\n")

let game = new Map()

var startingNumbers = input[0].split(",")

//Say the starting numbers
for (let index = 0; index < startingNumbers.length; index++) {
    game.set(parseInt(startingNumbers[index]), [index + 1, index + 1])
}

//Set the lastNumberSpoken to the last starting number
var lastNumberSpoken = parseInt(startingNumbers[startingNumbers.length-1])
var numberSpoken

//Let the game begin
for (let index = startingNumbers.length + 1; index <= 30000000; index++) {
    //Determine what number we are going to say next
    if (game.has(lastNumberSpoken)){
        numberSpoken = game.get(lastNumberSpoken)[0] - game.get(lastNumberSpoken)[1]
    } else {
        //If the lastNumberSpoken is not in the Set, add it and say 0
        game.set(parseInt(lastNumberSpoken), [index - 1, index - 1])
        numberSpoken = 0
    }
    //Update spokenNumber stats
    if (game.has(numberSpoken)){
        game.get(numberSpoken)[1] = game.get(numberSpoken)[0]
        game.get(numberSpoken)[0] = index
    }
    lastNumberSpoken = numberSpoken
}

console.log(lastNumberSpoken)