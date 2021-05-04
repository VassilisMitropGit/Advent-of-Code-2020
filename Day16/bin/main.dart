import 'dart:io';

void main() {
  File myFile = File("../TicketTranslation.txt");
  List<String> input = myFile.readAsLinesSync();

  //Parse File into 3 lists
  int dumbInputParse = 0;
  List<String> ticketRules = [];
  List<String> myTicket = [];
  List<String> nearbyTickets = [];
  for (var line in input) {
    if (line.isEmpty) dumbInputParse++;
    switch (dumbInputParse) {
      case 0:
        ticketRules.add(line);
        break;
      case 1:
        myTicket.add(line);
        break;
      case 2:
        nearbyTickets.add(line);
        break;
    }
  }
  //remove blank lines
  myTicket.removeAt(0);
  nearbyTickets.removeAt(0);
  //remove "your ticket:" and "nearby tickets:"
  myTicket.removeAt(0);
  nearbyTickets.removeAt(0);

  Set correctNumbers = calculateCorrectNumbers(ticketRules);
  //Part 1
  calculateTicketScanErrorRate(correctNumbers, nearbyTickets);
}

calculateCorrectNumbers(List<String> ticketRules) {
  var correctNumbers = new Set();
  RegExp rangeExp = new RegExp(r"[0-9]+");
  for (var line in ticketRules) {
    var range = rangeExp.allMatches(line).map((z) => z.group(0)).toList();
    var firstRangeList = [for (var i = int.parse(range[0]!); i < int.parse(range[1]!) + 1; i++) i];
    var secondRangeList = [for (var i = int.parse(range[2]!); i < int.parse(range[3]!) + 1; i++) i];
    for (var number in firstRangeList) {
      correctNumbers.add(number);
    }
    for (var number in secondRangeList) {
      correctNumbers.add(number);
    }
  }

  return correctNumbers;
}

calculateTicketScanErrorRate(Set correctNumbers, List<String> nearbyTickets) {
  var ticketScanErrorRate = 0;
  for (var ticket in nearbyTickets) {
    var values = ticket.split(",");
    for (var value in values) {
      if (!correctNumbers.contains(int.parse(value))) {
        ticketScanErrorRate += int.parse(value);
      }
    }
  }

  print(ticketScanErrorRate);
}
