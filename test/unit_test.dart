// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/to/unit-testing

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'classes_test.dart';

void main() {
  bool haveCommonChar(String str1, String str2) {
    return str1.split('').any((char) => str2.contains(char));
  }

  int maxLength2(List<String> arr) {
    // Set<String> arrSet = arr.toSet();
    arr = arr.toSet().toList();
    List<String> arr2 = [];
    // int result = 0;
    for (int i = 0; i < arr.length; i++) {
      if (Set.from(arr[i].split('')).length == arr[i].length) {
        arr2.add(arr[i]);
      }
    }
    if (arr2.isEmpty) {
      return 0;
    } else if (arr2.length == 1) {
      return arr2.first.length;
    }
    debugPrint('arr2 $arr2');
    String s = '';
    int max = 0;
    int sum = 0;
    int j = 0;
    for (int i = 0; i < (1 << arr2.length); i++) {
      s = '';
      sum = 0;
      for (j = 0; j < arr2.length; j++) {
        if ((i >> j) & 1 == 1) {
          s += arr2[j];
          sum += arr2[j].length;
        }
      }
      debugPrint('$i: $s with $sum');
      // s = arr.join();
      if ((Set.from(s.split('')).length) == s.length && sum > max) {
        max = sum;
      }
    }
    return max;
  }

  // ["un","iq","ue"]
  int maxLength(List<String> arr) {
    LinkedHashMap<String, int> arrLen = LinkedHashMap();
    // int result = 0;
    for (int i = 0; i < arr.length; i++) {
      if (Set.from(arr[i].split('')).length == arr[i].length) {
        arrLen[arr[i]] = arr[i].length;
      }
    }
    if (arrLen.isEmpty) {
      return 0;
    } else if (arrLen.length == 1) {
      return arrLen.values.elementAt(0);
    }
    debugPrint(arrLen.toString());
    LinkedHashMap<String, int> arrRes = LinkedHashMap();
    debugPrint("arrLen.entries.first.key: ${arrLen.entries.first.key}");
    arrRes[arrLen.entries.first.key] = arrLen.entries.first.value;
    for (int i = 1; i < arrLen.length; i++) {
      debugPrint("arrRes.length: $arrRes");
      for (int j = 0; j < arrRes.length; j++) {
        if (!haveCommonChar(
            arrLen.keys.elementAt(i), arrRes.keys.elementAt(j))) {
          debugPrint(
              'not equal ${arrLen.keys.elementAt(i)}, ${arrRes.keys.elementAt(j)}');
          if (arrLen.values.elementAt(i) > arrRes.values.elementAt(j)) {
            // result += arrLen.values.elementAt(i) - arrRes.values.elementAt(j);
            arrRes.remove(arrRes.keys.elementAt(j));
            arrRes[arrLen.keys.elementAt(i)] = arrLen.values.elementAt(i);
          }
        } else {
          // result += arrLen.values.elementAt(i);
          arrRes[arrLen.keys.elementAt(i)] = arrLen.values.elementAt(i);
        }
        print('add: ${arrRes[arrLen.keys.elementAt(i)].toString()}');
      }
    }
    print('add: $arrRes');

    return arrRes.values.reduce((value, element) => value + element);
  }

  int numberOfSubset(List<int> subSets, int target) {
    int count = 0;
    int sum = 0;
    int j = 0;
    for (int i = 0; i < (1 << subSets.length); i++) {
      sum = 0;
      for (j = 0; j < subSets.length; j++) {
        if ((i >> j) & 1 == 1) {
          sum += subSets[j];
        }
      }
      if (sum == target) {
        count++;
      }
    }
    return count;
  }

  group('Plus Operator', () {
    test('should add two numbers together', () {
      // print(maxLength2(["un", "iq", "ue"]));
      print(maxLength2(["cha", "erci", "act", "mplzds"]));
    });

    test('Bitmask & Complete Search', () {
      int aUnit = 'a'.hashCode;
      int a2Unit = 'a'.hashCode;
      // int result = aUnit >> 1;
      // int putBack = result << 1;
      debugPrint(aUnit.toString());
      debugPrint(a2Unit.toString());
      // debugPrint(result.toString());
      // debugPrint(putBack.toString());
      debugPrint('${2 << 3}');
    });
  });

  test('search', () {
    var sb = StringBuffer();
    sb
      ..write('Use a StringBuffer for ')
      ..writeCharCode(12)
      ..writeAll(['efficient', 'string', 'creation'], ' ')
      ..write('.');

    var fullString = sb.toString();
    debugPrint(fullString);
    // assert(fullString == 'Use a StringBuffer for efficient string creation.');
    // print(3 % 2);
    // debugPrint(123.456.toStringAsPrecision(2));
    // ImplementLogger loo = ImplementLogger();
    // loo.moveCarForward();
    // print(numberOfSubset([1, 5, 2, 7, 3, 9], 6));
  });
}
