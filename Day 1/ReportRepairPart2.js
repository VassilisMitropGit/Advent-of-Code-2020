import fs from 'fs'

var target = 2020

//Since we are reading a local file, we choose to read it using readFileSync
var expenseReport = fs.readFileSync('ReportRepairInput.txt', 'utf-8').split("\n").map(Number)

//Since we don't care about duplicate values (even if they exit in our data) we can create a set
var expenseReportSet = new Set(expenseReport)

var result = calculateResult(expenseReport, expenseReportSet, target)
console.log(result)

//This function is basically 2 times the Part 1 solution. We define a new target sum and we search for 2 elements.
function calculateResult(my_array, my_set, sum){
    for (let index = 0; index < my_array.length; index++) {
        const element = my_array[index]
        var temp_sum = sum - element
        for (let index = 0; index < my_array.length; index++) {
            const newElement = my_array[index];
            if (my_set.has(temp_sum - newElement)){
                return (newElement * (temp_sum - newElement) * element)
            }
        }
    }
}