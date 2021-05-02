import 'dart:io';

void main() {
  File myFile = File("../ShuttleSearch.txt");
  List<String> input = myFile.readAsLinesSync();
  num myTimestamp = num.parse(input[0]);
  List<num> availableBusses = parseBusses(input[1]);

  findLowestWaitTime(myTimestamp, availableBusses);
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
