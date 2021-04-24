import fs from 'fs'

var oneJoltDifferenceCounter = 0
var threeJoltDifferenceCounter = 0
var joltDifference = 0
//Since we are reading a local file, we choose to read it using readFileSync
var adapters = fs.readFileSync('AdapterArray.txt', 'utf-8').split("\n").map(Number).sort(function(a, b){return a-b})

var builtInAdapter = adapters[adapters.length-1] + 3

calculateJoltDifferences()
console.log(oneJoltDifferenceCounter * threeJoltDifferenceCounter)

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