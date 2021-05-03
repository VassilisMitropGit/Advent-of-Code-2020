import 'dart:io';

import 'dart:math';

void main() {
  File myFile = File("../DockingData.txt");
  List<String> input = myFile.readAsLinesSync();

  //Part 1
  calculatePart1Solution(input);

  //Part 2
  calculatePart2Solution(input);
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

calculatePart1Solution(List<String> input) {
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

applyMemoryMask(String mask, int value) {
  var bitValue = BigInt.from(value);
  return (convertMaskOR(mask) | bitValue).toRadixString(2);
}

countX(String mask) {
  return "X".allMatches(mask).length;
}

generateAllAddresses(String maskedAddress, String mask, int xCount) {
  var generatedAddresses = [];
  //padLeft with 0
  var fixedMaskedAddress = maskedAddress.padLeft(36, "0");
  for (var i = 0; i < pow(2, xCount); i++) {
    generatedAddresses.add(generateNewAddress(fixedMaskedAddress, mask, (i.toRadixString(2)).padLeft(xCount, "0")));
  }

  return generatedAddresses;
}

generateNewAddress(String fixedMaskedAddress, String mask, String replaceWith) {
  var index = 0;
  replaceWith.split('').forEach((element) {
    index = mask.indexOf("X", index);
    fixedMaskedAddress = fixedMaskedAddress.substring(0, index) + element + fixedMaskedAddress.substring(index + 1);
    index += 1;
  });

  return fixedMaskedAddress;
}

calculatePart2Solution(List<String> input) {
  var mask = "";
  Map<BigInt, int> memory = {};
  int sum = 0;
  for (var line in input) {
    List<String> parsedLine = line.split(" ");

    if (parsedLine[0] == "mask") {
      mask = parsedLine[2];
    } else {
      int memoryIndex = int.parse(parsedLine[0].replaceAll(new RegExp(r'[^0-9]'), ''));

      var addressesToWrite = generateAllAddresses(applyMemoryMask(mask, memoryIndex), mask, countX(mask));

      for (var address in addressesToWrite) {
        memory[BigInt.parse(address, radix: 2)] = int.parse(parsedLine[2]);
      }
    }
  }

  memory.forEach((key, value) {
    sum += value;
  });

  print(sum);
}
