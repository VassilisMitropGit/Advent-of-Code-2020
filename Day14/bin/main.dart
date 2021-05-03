import 'dart:io';

void main() {
  File myFile = File("../DockingData.txt");
  List<String> input = myFile.readAsLinesSync();
  String mask = "";
  Map<int, BigInt> memory = {};
  BigInt sum = BigInt.zero;

  for (var line in input) {
    List<String> parsedLine = line.split(" ");

    if (parsedLine[0] == "mask") {
      mask = parsedLine[2];
    } else {
      int memoryIndex = int.parse(parsedLine[0].replaceAll(new RegExp(r'[^0-9]'), ''));
      memory[memoryIndex] = applyMask(mask, int.parse(parsedLine[2]));
    }
  }

  memory.forEach((key, value) {
    sum += value;
  });

  print(sum);
}

applyMask(String mask, int value) {
  var data = BigInt.from(value);
  data = convertMaskAND(mask) & data;
  data = convertMaskOR(mask) | data;
  return data;
}

convertMaskAND(String mask) {
  return BigInt.parse(mask.replaceAll(new RegExp(r'X'), "1"), radix: 2);
}

convertMaskOR(String mask) {
  return BigInt.parse(mask.replaceAll(new RegExp(r'X'), "0"), radix: 2);
}
