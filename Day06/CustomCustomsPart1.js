import fs from 'fs'

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
    const asnwersSet = new Set()
    groupAnswers.forEach(element => {
        for (let index = 0; index < element.length; index++) {
            const answer = element[index]
            asnwersSet.add(answer)
        }
    })
    totalYesAnswers += asnwersSet.size
}