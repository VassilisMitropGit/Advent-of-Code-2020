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

  //Part 2
  List<String> validTickets = discardInvalidTickets(correctNumbers, List.from(nearbyTickets));
  validTickets.add(myTicket[0]);

  List<Set> columnValues = parseColumns(validTickets);
  List<Set> columnRestrictions = calculateCorrectNumbersInColumns(ticketRules);

  Map<int, List<int>> match = {};
  int ruleIndex = 0;
  int columnIndex = 0;
  List<int> columnIndexes = [];
  for (var rule in columnRestrictions) {
    columnIndex = 0;
    columnIndexes.clear();
    for (var column in columnValues) {
      if (column.difference(rule).isEmpty) {
        columnIndexes.add(columnIndex);
      }
      columnIndex++;
    }
    match[ruleIndex] = List.from(columnIndexes);
    ruleIndex++;
  }
  var matched = new Set();
  var matches = matchRulesWithColumns(match, matched);

  var result = 1;
  var myTicketValues = myTicket[0].split(",");
  for (var i = 0; i < 6; i++) {
    result *= int.parse(myTicketValues[matches[i]![0]]);
  }
  print(result);
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

discardInvalidTickets(Set correctNumbers, List<String> nearbyTickets) {
  List<String> validTickets = [];
  bool valid = true;
  for (var i = 0; i < nearbyTickets.length; i++) {
    var values = nearbyTickets[i].split(",");
    valid = true;
    for (var value in values) {
      if (!correctNumbers.contains(int.parse(value))) {
        valid = false;
        break;
      }
    }
    if (valid) validTickets.add(nearbyTickets[i]);
  }
  return validTickets;
}

parseColumns(List<String> validTickets) {
  var columnValuesSet = new Set();
  List<Set> columnValuesTotal = [];
  for (var i = 0; i < validTickets[0].split(",").length; i++) {
    columnValuesSet.clear();
    for (var j = 0; j < validTickets.length; j++) {
      var eachValue = validTickets[j].split(",");
      columnValuesSet.add(int.parse(eachValue[i]));
    }
    columnValuesTotal.insert(i, Set.from(columnValuesSet));
  }
  return columnValuesTotal;
}

calculateCorrectNumbersInColumns(List<String> ticketRules) {
  List<Set> columnRules = [];
  var correctNumbers = new Set();
  RegExp rangeExp = new RegExp(r"[0-9]+");
  var i = 0;
  for (var line in ticketRules) {
    correctNumbers.clear();
    var range = rangeExp.allMatches(line).map((z) => z.group(0)).toList();
    var firstRangeList = [for (var i = int.parse(range[0]!); i < int.parse(range[1]!) + 1; i++) i];
    var secondRangeList = [for (var i = int.parse(range[2]!); i < int.parse(range[3]!) + 1; i++) i];
    for (var number in firstRangeList) {
      correctNumbers.add(number);
    }
    for (var number in secondRangeList) {
      correctNumbers.add(number);
    }
    columnRules.insert(i, Set.from(correctNumbers));
    i++;
  }

  return columnRules;
}

matchRulesWithColumns(Map<int, List<int>> match, Set matched) {
  for (var i = 0; i < match.length; i++) {
    for (var key in match.keys) {
      if (match[key]!.length == 1 && !matched.contains(match[key]![0])) {
        for (var zonk in match.keys) {
          if (match[zonk]!.length != 1) {
            match[zonk]!.remove(match[key]![0]);
          }
        }
        matched.add(match[key]![0]);
      }
    }
  }

  return match;
}
