import 'dart:io';

void main() {
  File input = File("../SeatingSystem.txt");
  var seatMap = input.readAsLinesSync();
  int rows = seatMap.length;
  int columns = seatMap[0].length;

  bool finished = false;
  while (!finished) {
    var tempSeatMap = new List<String>.from(seatMap);
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < columns; j++) {
        var myAdjasentCoordinates = calculateAdjasentCoordinates(i, j);
        var myAdjasentSeats = ajdasentSeats(rows, columns, myAdjasentCoordinates, tempSeatMap);
        seatMap = enforceRules(seatMap, myAdjasentSeats, i, j, tempSeatMap);
      }
    }
    print("Zonk");
    if (isEqual(tempSeatMap, seatMap)) finished = true;
  }

  int occupiedSeats = calculateOccupiedSeats(seatMap);
  print(occupiedSeats);
}

enforceRules(List<String> seatSnapshot, List<String> adjSeats, int x, int y, List<String> ref) {
  int occupiedSeats = 0;
  for (var item in adjSeats) {
    if (item == "#") occupiedSeats++;
  }

  if (ref[x][y] == "L" && occupiedSeats == 0)
    seatSnapshot[x] = seatSnapshot[x].substring(0, y) + "#" + seatSnapshot[x].substring(y + 1);
  else if (ref[x][y] == "#" && occupiedSeats >= 4)
    seatSnapshot[x] = seatSnapshot[x].substring(0, y) + "L" + seatSnapshot[x].substring(y + 1);

  return seatSnapshot;
}

calculateAdjasentCoordinates(int x, int y) {
  var coordinates = Map<String, Map<String, int>>();
  //Starting Coordinates
  coordinates['start'] = {'x': x, 'y': y};
  //calculate North
  coordinates['N'] = {'x': x - 1, 'y': y};
  //calculate South
  coordinates['S'] = {'x': x + 1, 'y': y};
  //calculate East
  coordinates['E'] = {'x': x, 'y': y + 1};
  //calculate West
  coordinates['W'] = {'x': x, 'y': y - 1};
  //calculate NorthWest
  coordinates['NW'] = {'x': x - 1, 'y': y - 1};
  //calculate NorthEast
  coordinates['NE'] = {'x': x - 1, 'y': y + 1};
  //calculate SouthEast
  coordinates['SE'] = {'x': x + 1, 'y': y + 1};
  //calculate SouthWest
  coordinates['SW'] = {'x': x + 1, 'y': y - 1};

  return coordinates;
}

ajdasentSeats(int rows, int columns, Map<String, Map<String, int>> coord, List<String> seatSnapshot) {
  List<String> adjSeats = [];
  if (coord['N']!['x']! >= 0) adjSeats.add(seatSnapshot[coord['N']!['x']!][coord['N']!['y']!]);
  if (coord['S']!['x']! <= rows - 1) adjSeats.add(seatSnapshot[coord['S']!['x']!][coord['S']!['y']!]);
  if (coord['W']!['y']! >= 0) adjSeats.add(seatSnapshot[coord['W']!['x']!][coord['W']!['y']!]);
  if (coord['E']!['y']! <= columns - 1) adjSeats.add(seatSnapshot[coord['E']!['x']!][coord['E']!['y']!]);

  if (coord['NW']!['x']! >= 0 && coord['NW']!['y']! >= 0)
    adjSeats.add(seatSnapshot[coord['NW']!['x']!][coord['NW']!['y']!]);
  if (coord['NE']!['x']! >= 0 && coord['NE']!['y']! <= columns - 1)
    adjSeats.add(seatSnapshot[coord['NE']!['x']!][coord['NE']!['y']!]);
  if (coord['SW']!['x']! <= rows - 1 && coord['SW']!['y']! >= 0)
    adjSeats.add(seatSnapshot[coord['SW']!['x']!][coord['SW']!['y']!]);
  if (coord['SE']!['x']! <= rows - 1 && coord['SE']!['y']! <= columns - 1)
    adjSeats.add(seatSnapshot[coord['SE']!['x']!][coord['SE']!['y']!]);

  return adjSeats;
}

calculateOccupiedSeats(List<String> seats) {
  int occupiedSeats = 0;
  for (var i = 0; i < seats.length; i++) {
    for (var j = 0; j < seats[i].length; j++) {
      if (seats[i][j] == "#") occupiedSeats++;
    }
  }
  return occupiedSeats;
}

isEqual(List<String> a, List<String> b) {
  bool equal = true;
  for (var i = 0; i < a.length; i++) {
    if (a[0] != b[0]) {
      equal = false;
      break;
    }
  }
  return equal;
}