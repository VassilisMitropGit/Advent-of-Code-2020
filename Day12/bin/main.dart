import 'dart:io';
import 'dart:core';

void main() {
  var path = "../RainRisk.txt";
  Map<String, int> coordinates = {'x': 0, 'y': 0};
  Map<String, int> waypoint = {'x': 10, 'y': 1};
  //Part 1
  //int courseIndex = 0;
  //List<String> horizon = ["E", "S", "W", "N"];
  String command;
  int commandValue;

  File input = File(path);
  List<String> commands = input.readAsLinesSync();

  for (var line in commands) {
    command = line[0];
    commandValue = int.parse(line.substring(1));

    //Part 1
    // if (command == "R" || command == "L") {
    //   courseIndex = steerShip(command, commandValue, courseIndex);
    // } else {
    //   coordinates = moveShip(command, commandValue, horizon[courseIndex], coordinates);
    // }

    if (command == "F") {
      coordinates = moveToWaypoint(commandValue, coordinates, waypoint);
    } else {
      waypoint = adjustWaypoint(command, commandValue, waypoint);
    }
  }
  print(coordinates['x']!.abs() + coordinates['y']!.abs());
}

moveShip(String command, int commandVal, String course, Map<String, int> coord) {
  //move commands
  if (command == "N" || (command == "F" && course == "N")) {
    coord.update('y', (value) => value + commandVal);
  }
  if (command == "S" || (command == "F" && course == "S")) {
    coord.update('y', (value) => value - commandVal);
  }
  if (command == "E" || (command == "F" && course == "E")) {
    coord.update('x', (value) => value + commandVal);
  }
  if (command == "W" || (command == "F" && course == "W")) {
    coord.update('x', (value) => value - commandVal);
  }

  return coord;
}

steerShip(String command, int commandVal, int courseIndex) {
  int angle = 0;
  if (command == "R") {
    angle = commandVal ~/ 90;
  }
  if (command == "L") {
    angle = (360 - commandVal) ~/ 90;
  }

  courseIndex = (courseIndex + angle) % 4;
  return courseIndex;
}

adjustWaypoint(String command, int commandVal, Map<String, int> waypoint) {
  if (command == "N") waypoint.update('y', (value) => value + commandVal);
  if (command == "S") waypoint.update('y', (value) => value - commandVal);
  if (command == "E") waypoint.update('x', (value) => value + commandVal);
  if (command == "W") waypoint.update('x', (value) => value - commandVal);

  //Turn commands
  if (command == "R" || command == "L") {
    int angle = 0;
    if (command == "R") {
      angle = commandVal ~/ 90;
    }
    if (command == "L") {
      angle = (360 - commandVal) ~/ 90;
    }
    switch (angle) {
      case 1:
        {
          var oldX = waypoint['x']!;
          var oldY = waypoint['y']!;
          waypoint.update('x', (value) => oldY);
          waypoint.update('y', (value) => -oldX);
        }
        break;
      case 2:
        {
          var oldX = waypoint['x']!;
          var oldY = waypoint['y']!;
          waypoint.update('x', (value) => -oldX);
          waypoint.update('y', (value) => -oldY);
        }
        break;
      case 3:
        {
          var oldX = waypoint['x']!;
          var oldY = waypoint['y']!;
          waypoint.update('x', (value) => -oldY);
          waypoint.update('y', (value) => oldX);
        }
        break;
    }
  }

  return waypoint;
}

moveToWaypoint(int commandVal, Map<String, int> coord, Map<String, int> waypoint) {
  coord.update('x', (value) => value + (commandVal * waypoint['x']!));
  coord.update('y', (value) => value + (commandVal * waypoint['y']!));

  return coord;
}
