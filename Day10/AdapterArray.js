//used hints from https://pietroppeter.github.io/adventofnim/2020/day10hints.html

import fs from 'fs'

var oneJoltDifferenceCounter = 0
var threeJoltDifferenceCounter = 0
var joltDifference = 0
//Since we are reading a local file, we choose to read it using readFileSync
var adapters = fs.readFileSync('AdapterArray.txt', 'utf-8').split("\n").map(Number).sort(function(a, b){return a-b})

var builtInAdapter = adapters[adapters.length-1] + 3

//Part 1
calculateJoltDifferences()
console.log(oneJoltDifferenceCounter * threeJoltDifferenceCounter)

//Part 2
var differencesSequence = [adapters[0]]
calculateDifferencesSequence()
console.log(calculatePossibleArrangements(differencesSequence))

function calculatePossibleArrangements(diffSequence){
    //if sequence has length 1 (or less) that means that we have one element so we return
    if (diffSequence.length <= 1) return 1
    //Check for difference 3 at the beggining or the end
    if (diffSequence[0] == 3) 
        return calculatePossibleArrangements(diffSequence.slice(1))
    if (diffSequence[diffSequence.length-1] == 3){
        return calculatePossibleArrangements(diffSequence.slice(0,diffSequence.length-1))
    }
    //Check for consecutive 2s at the beggining or the end
    if (diffSequence[0] == 2 && diffSequence[1] == 2)
        return calculatePossibleArrangements(diffSequence.slice(2))
    if (diffSequence[diffSequence.length-1] == 2 && diffSequence[diffSequence.length-2] == 2)
        return calculatePossibleArrangements(diffSequence.slice(0, diffSequence.length-2))
    //check for the above conditions inside the sequence
    for (let index = 0; index < diffSequence.length; index++) {
        if (diffSequence[index] == 3) 
            return calculatePossibleArrangements(diffSequence.slice(0,index)) * calculatePossibleArrangements(diffSequence.slice(index+1,diffSequence.length))
        if (diffSequence[index] == 2 && diffSequence[index+1] == 2)
            return calculatePossibleArrangements(diffSequence.slice(0,index)) * calculatePossibleArrangements(diffSequence.slice(index+2,diffSequence.length))
    }

    //We need to reduce the size.
    return calculatePossibleArrangements(diffSequence.slice(1)) +
        calculatePossibleArrangements(diffSequence.slice(2).concat([diffSequence[0] + diffSequence[1]]))
}

function calculateDifferencesSequence(){
    for (let index = 0; index < adapters.length; index++) {
        const element = adapters[index]
        if (index == adapters.length - 1){
            differencesSequence.push(3)
        } else {
            differencesSequence.push((adapters[index+1] - adapters[index]))
        }
    }
}

function calculateJoltDifferences() {
    for (let index = 0; index < adapters.length; index++) {
        if (index == adapters.length - 1){
            joltDifference = builtInAdapter - adapters[index]
        } else {
            joltDifference = adapters[index+1] - adapters[index]
        }
        switch (joltDifference) {
            case 1:
                oneJoltDifferenceCounter++
                break
            case 3:
                threeJoltDifferenceCounter++
                break
            default:
                break
        }
    }
    if (adapters[0] == 1) oneJoltDifferenceCounter++
    else if (adapters[0] == 3) threeJoltDifferenceCounter++
}