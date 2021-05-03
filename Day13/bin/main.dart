import 'dart:io';

void main() {
  File myFile = File("../ShuttleSearch.txt");
  List<String> input = myFile.readAsLinesSync();
  //Part 1
  num myTimestamp = num.parse(input[0]);
  List<num> availableBusses = parseBusses(input[1]);
  findLowestWaitTime(myTimestamp, availableBusses);

  //Part 2
  var busList = input[1];
  var temp = parseBussesWithOffset(busList);
  var availableBussesList = temp[0];
  var offsetList = temp[1];
  calculateCommonTimestamp(availableBussesList, offsetList);
}

parseBusses(String busList) {
  List<int> availableBusses = [];
  List<String> busses = busList.split(",");
  for (var bus in busses) {
    if (bus != "x") {
      availableBusses.add(int.parse(bus));
    }
  }
  return availableBusses;
}

findLowestWaitTime(num myTimestamp, List<num> availableBusses) {
  num lowestWaitTime = -double.infinity;
  num busID = 0;
  availableBusses.forEach((element) {
    num approximation = (myTimestamp / element).floor() + 1;
    if ((myTimestamp - approximation * element) > lowestWaitTime) {
      lowestWaitTime = (myTimestamp - approximation * element);
      busID = element;
    }
    ;
  });

  print(lowestWaitTime.abs() * busID);
}

parseBussesWithOffset(String busList) {
  List<num> offsets = [];
  List<String> busses = busList.split(",");
  List<num> availableBusses = [];
  num offset = 0;
  for (var bus in busses) {
    if (bus != "x") {
      offsets.add(offset);
      offset = 1;
      availableBusses.add(num.parse(bus));
    } else {
      offset++;
    }
  }

  num sum = 0;
  for (var i = 0; i < offsets.length; i++) {
    sum += offsets[i];
    offsets[i] = sum;
  }

  return [availableBusses, offsets];
}

calculateCommonTimestamp(var availableBussesList, var offsetList) {
  //First calculate the initial timestamp for the first two busses.
  bool found = false;
  num i = 0;
  while (!found) {
    i++;
    if ((i * availableBussesList[0] + offsetList[1]) % availableBussesList[1] == 0) found = true;
  }

  var timestamp = i * availableBussesList[0];
  var valid = availableBussesList[0] * availableBussesList[1];
  //Then calculate the timestamp for the remaining busses.
  for (var i = 2; i < availableBussesList.length; i++) {
    while ((timestamp + offsetList[i]) % availableBussesList[i] != 0) {
      timestamp += valid;
    }
    valid *= availableBussesList[i];
  }

  print(timestamp);
}
