import 'dart:io';

void main() {
  File myFile = File("../ConwayCubes.txt");
  List<String> input = myFile.readAsLinesSync();
}
