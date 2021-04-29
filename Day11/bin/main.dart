import 'dart:io';

void main() {
  File input = File("../SeatingSystem.txt");
  var seatMap = input.readAsLinesSync();
  List<String> tempSeatMap;
  int rows = seatMap.length;
  int columns = seatMap[0].length;

  bool finished = false;
  while (!finished) {
    tempSeatMap = List.from(seatMap);
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < columns; j++) {
        //Part 1 adjasentSeats
        //var myAdjasentCoordinates = calculateAdjasentCoordinates(i, j);
        //var myAdjasentSeats = ajdasentSeats(rows, columns, myAdjasentCoordinates, tempSeatMap);

        //Part 2 adjasentSeats
        var myAdjasentSeats = seatsInVision(rows, columns, i, j, tempSeatMap);
        int occupiedSeats = 0;
        for (var item in myAdjasentSeats) {
          if (item == "#") occupiedSeats++;
        }

        if (tempSeatMap[i][j] == "L" && occupiedSeats == 0)
          seatMap[i] = seatMap[i].substring(0, j) + '#' + seatMap[i].substring(j + 1);
        else if (tempSeatMap[i][j] == "#" && occupiedSeats >= 5)
          seatMap[i] = seatMap[i].substring(0, j) + 'L' + seatMap[i].substring(j + 1);
      }
    }
    if (isEqual(tempSeatMap, seatMap)) finished = true;
  }

  int occupiedSeats = calculateOccupiedSeats(seatMap);
  print(occupiedSeats);
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
      if (seats[i][j] == '#') occupiedSeats++;
    }
  }
  return occupiedSeats;
}

isEqual(List<String> a, List<String> b) {
  bool equal = true;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) {
      equal = false;
      break;
    }
  }
  return equal;
}

seatsInVision(int rows, int columns, int startX, int startY, List<String> seatSnapshot) {
  List<String> adjSeats = [];
  bool outOfBounds = false;
  int x = startX;
  int y = startY;
  //calculate North seat
  while (!outOfBounds) {
    x -= 1;
    if (x >= 0) {
      if (seatSnapshot[x][y] == "#" || seatSnapshot[x][y] == "L") {
        adjSeats.add(seatSnapshot[x][y]);
        break;
      }
    } else {
      outOfBounds = true;
    }
  }
  //calculate South seat
  outOfBounds = false;
  x = startX;
  y = startY;
  while (!outOfBounds) {
    x += 1;
    if (x <= rows - 1) {
      if (seatSnapshot[x][y] == "#" || seatSnapshot[x][y] == "L") {
        adjSeats.add(seatSnapshot[x][y]);
        break;
      }
    } else {
      outOfBounds = true;
    }
  }
  //calculate West seat
  x = startX;
  y = startY;
  outOfBounds = false;
  while (!outOfBounds) {
    y -= 1;
    if (y >= 0) {
      if (seatSnapshot[x][y] == "#" || seatSnapshot[x][y] == "L") {
        adjSeats.add(seatSnapshot[x][y]);
        break;
      }
    } else {
      outOfBounds = true;
    }
  }
  //calculate East seat
  outOfBounds = false;
  x = startX;
  y = startY;
  while (!outOfBounds) {
    y += 1;
    if (y <= columns - 1) {
      if (seatSnapshot[x][y] == "#" || seatSnapshot[x][y] == "L") {
        adjSeats.add(seatSnapshot[x][y]);
        break;
      }
    } else {
      outOfBounds = true;
    }
  }
  //calculate NorthWest seat
  outOfBounds = false;
  x = startX;
  y = startY;
  while (!outOfBounds) {
    x -= 1;
    y -= 1;
    if (y >= 0 && x >= 0) {
      if (seatSnapshot[x][y] == "#" || seatSnapshot[x][y] == "L") {
        adjSeats.add(seatSnapshot[x][y]);
        break;
      }
    } else {
      outOfBounds = true;
    }
  }
  //calculate NorthEast seat
  outOfBounds = false;
  x = startX;
  y = startY;
  while (!outOfBounds) {
    x -= 1;
    y += 1;
    if (y <= columns - 1 && x >= 0) {
      if (seatSnapshot[x][y] == "#" || seatSnapshot[x][y] == "L") {
        adjSeats.add(seatSnapshot[x][y]);
        break;
      }
    } else {
      outOfBounds = true;
    }
  }
  //calculate SouthWest seat
  outOfBounds = false;
  x = startX;
  y = startY;
  while (!outOfBounds) {
    x += 1;
    y -= 1;
    if (y >= 0 && x <= rows - 1) {
      if (seatSnapshot[x][y] == "#" || seatSnapshot[x][y] == "L") {
        adjSeats.add(seatSnapshot[x][y]);
        break;
      }
    } else {
      outOfBounds = true;
    }
  }
  //calculate SouthEast seat
  outOfBounds = false;
  x = startX;
  y = startY;
  while (!outOfBounds) {
    x += 1;
    y += 1;
    if (y <= columns - 1 && x <= rows - 1) {
      if (seatSnapshot[x][y] == "#" || seatSnapshot[x][y] == "L") {
        adjSeats.add(seatSnapshot[x][y]);
        break;
      }
    } else {
      outOfBounds = true;
    }
  }

  return adjSeats;
}
