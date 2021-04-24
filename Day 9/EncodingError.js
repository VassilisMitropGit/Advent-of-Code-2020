import fs from 'fs'

//Since we are reading a local file, we choose to read it using readFileSync
var XMAS = fs.readFileSync('EncodingError.txt', 'utf-8').split("\n").map(Number)

var PreambleList = XMAS.slice(0, 25)
var PreambleSet = new Set(PreambleList)

for (let index = 25; index < XMAS.length; index++) {
    const element = XMAS[index];
    if (!isValid(element)){
        console.log(element)
        break
    }
    else {
        PreambleList.shift()
        PreambleList.push(element)
        PreambleSet = new Set(PreambleList)
    }
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