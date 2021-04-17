import fs from 'fs'

// Use fs.readFile() method to read our input file
fs.readFile('Report_Repair_Input.txt', 'utf8', function(err, data){
    var expense_report  = data.split('\n')
    //Display the file content
    console.log(data)
    console.log("-----")
    console.log(expense_report.length)
})