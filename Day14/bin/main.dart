import 'dart:io';

void main() {
  File myFile = File("../DockingData.txt");
  List<String> input = myFile.readAsLinesSync();
}
