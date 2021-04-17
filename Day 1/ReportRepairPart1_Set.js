import fs from 'fs'

var target = 2020

//Since we are reading a local file, we choose to read it using readFileSync
var expenseReport = fs.readFileSync('ReportRepairInput.txt', 'utf-8').split("\n").map(Number)

//Since we don't care about duplicate values (even if they exit in our data) we can create a set
var expenseReportSet = new Set(expenseReport)

for (let index = 0; index < expenseReport.length; index++) {
    const element = expenseReport[index];
    if (expenseReportSet.has(target - element)){
        console.log(element * (target - element))
        break
    }
    
}