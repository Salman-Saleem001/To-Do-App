import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';

final kTextFieldStyle = TextStyle(
    color: Colors.grey.shade400, fontSize: 14.0, fontWeight: FontWeight.w600);

String getTime(String time) {
  DateTime dateTime = DateTime.parse(time);
  DateTime currentTime = DateTime(dateTime.year, dateTime.month, dateTime.day);
  if (currentTime.day - DateTime.now().day == 0) {
    return "${(dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour).abs()}:${dateTime.minute} ${dateTime.hour >= 12 ? "PM" : "AM"}";
  } else if (DateTime.now().day - currentTime.day == 1) {
    return 'Yesterday';
  } else {
    return DateTime.parse(time).toString().substring(0, 10);
  }
}

int getCharacterColor(String name) {
  if (name[0].codeUnitAt(0) >= 65 && name[0].codeUnitAt(0) <= 74) {
    return ColorX.red;
  } else if (name[0].codeUnitAt(0) >= 75 && name[0].codeUnitAt(0) <= 80) {
    return ColorX.green;
  } else if (name[0].codeUnitAt(0) >= 81 && name[0].codeUnitAt(0) <= 86) {
    return ColorX.primary;
  } else {
    return ColorX.grey;
  }
}

List<String> dropdownList = [
  '!  Importance',
  '!!!  Very Important',
  '!! Important',
  '! Less Important',
];
int getColor(String val) {
  if (val == dropdownList[0]) {
    return ColorX.grey;
  } else if (val == dropdownList[1]) {
    return ColorX.red;
  } else if (val == dropdownList[2]) {
    return ColorX.green;
  } else {
    return ColorX.primary;
  }
}
