import fs from 'fs'

var target = 2020

//Since we are reading a local file, we choose to read it using readFileSync
var expenseReport = fs.readFileSync('ReportRepairInput.txt', 'utf-8').split("\n").map(Number)

var expenseReportSorted = quickSortBasic(expenseReport)

var Solution = findSolution(expenseReportSorted, expenseReportSorted.length, target)

console.log(Solution)

function findSolution(array, arraySize, targetSum){
    var leftPointer = 0
    var rightPointer = arraySize - 1;

    while (leftPointer < rightPointer){
        if (array[leftPointer] + array[rightPointer] == targetSum){
            return array[leftPointer] * array[rightPointer]
        } else if (array[leftPointer] + array[rightPointer] < targetSum){
            leftPointer++
        } else {
            rightPointer--
        }
    }
}

function quickSortBasic(array) {
    if(array.length < 2) {
      return array;
    }
  
    var pivot = array[0];
    var lesserArray = [];
    var greaterArray = [];
  
    for (var i = 1; i < array.length; i++) {
      if ( array[i] > pivot ) {
        greaterArray.push(array[i]);
      } else {
        lesserArray.push(array[i]);
      }
    }
  
    return quickSortBasic(lesserArray).concat(pivot, quickSortBasic(greaterArray));
  }