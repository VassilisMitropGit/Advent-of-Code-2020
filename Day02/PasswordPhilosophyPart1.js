import fs from 'fs'

var validPasswords = 0;
//Since we are reading a local file, we choose to read it using readFileSync
var corruptedDatabase = fs.readFileSync('PasswordPhilosophy.txt', 'utf-8').split("\n")

corruptedDatabase.forEach(element => {
    var data = element.split(" ")
    let re = new RegExp(data[1][0], "g")
    var limits = data[0].split("-").map(Number)
    var lowerLimit = limits[0]
    var upperLimit = limits[1]
    //console.log(((data[2] || '').match(re) || []).length)
    if ( !(((data[2] || '').match(re) || []).length > upperLimit || ((data[2] || '').match(re) || []).length < lowerLimit)){
        validPasswords++;
    }
});

console.log(validPasswords)