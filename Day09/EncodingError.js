import fs from 'fs'

var XMASWeakness = 0

var sequence = []
var sum = 0

//Since we are reading a local file, we choose to read it using readFileSync
var XMAS = fs.readFileSync('EncodingError.txt', 'utf-8').split("\n").map(Number)

var PreambleList = XMAS.slice(0, 25)
var PreambleSet = new Set(PreambleList)

for (let index = 25; index < XMAS.length; index++) {
    const element = XMAS[index]
    if (!isValid(element)){
        XMASWeakness = element
        console.log(XMASWeakness)
        break
    }
    else {
        PreambleList.shift()
        PreambleList.push(element)
        PreambleSet = new Set(PreambleList)
    }
}

for (let index = 0; index < XMAS.length; index++) {
    if (findSequence(XMASWeakness, index)) break
}

function isValid(target){
    for (let index = 0; index < PreambleList.length; index++) {
        const element = PreambleList[index];
        if (PreambleSet.has(target - element)){
            return true
        }
    }
    return false
}

function findSequence(target, startingIndex){
    for (let index = startingIndex; index < XMAS.length; index++) {
        const element = XMAS[index]
        sum += element
        sequence.push(element)
        if (sum == target){
            sequence.sort()
            console.log(sequence[0] + sequence.pop())
            return true
        } else if (sum > target){
            sequence = []
            sum = 0
            return false
        }
    }
}