import fs from 'fs'

var validPasswords = 0;
//Since we are reading a local file, we choose to read it using readFileSync
var corruptedDatabase = fs.readFileSync('PasswordPhilosophy.txt', 'utf-8').split("\n")

corruptedDatabase.forEach(element => {
    var data = element.split(" ")
    var limits = data[0].split("-").map(Number)
    var lowerLimit = limits[0]
    var upperLimit = limits[1]
    let re1 = new RegExp("^.{" + (lowerLimit - 1) + "}" + data[1][0], "g")
    let re2 = new RegExp("^.{" + (upperLimit - 1) + "}" + data[1][0], "g")
    if (((data[2] || '').match(re1) || []).length + ((data[2] || '').match(re2) || []).length == 1){
        validPasswords++;
    }
});

console.log(validPasswords)