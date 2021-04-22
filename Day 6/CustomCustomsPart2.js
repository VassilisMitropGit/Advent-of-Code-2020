import fs from 'fs'

var setIntersection
var report = []
var totalYesAnswers = 0
//Since we are reading a local file, we choose to read it using readFileSync
var customsReports = fs.readFileSync('CustomCustoms.txt', 'utf-8').split("\n")

customsReports.forEach(line => {
    if (line === "\r"){
        calculateUniqueAnswers(report)
        report = []
    } else{
        report.push(line.trim())
    }
});

calculateUniqueAnswers(report)

console.log(totalYesAnswers)

function calculateUniqueAnswers(groupAnswers){
    var asnwersSet = new Set()
    var setList = []
    groupAnswers.forEach(element => {
        for (let index = 0; index < element.length; index++) {
            const answer = element[index]
            asnwersSet.add(answer)
        }
        setList.push(asnwersSet)
        asnwersSet = new Set()
    })

    if (setList.length >= 2){
        setIntersection = intersection(setList[0], setList[1])
        for (let i = 2; i < setList.length; i++) {
            setIntersection = intersection(setIntersection, setList[i])
        }
    } else {
        setIntersection = setList[0]
    }

    totalYesAnswers += setIntersection.size
}

function intersection(setA, setB) {
    let _intersection = new Set()
    for (let elem of setB) {
        if (setA.has(elem)) {
            _intersection.add(elem)
        }
    }
    return _intersection
}