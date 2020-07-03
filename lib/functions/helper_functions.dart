import 'package:flutter/material.dart';
import 'package:flutterandpython/Cities.dart';
import 'package:flutterandpython/Constans.dart';
import 'package:flutterandpython/globals.dart' as globals;
import 'package:flutterandpython/models/remainder.dart';

String formatDuration(Duration duration) {
  // as: hh/mm
  String formattedDuration = duration.toString().substring(0, 4);
  if (duration.toString().substring(4, 5) != ":") {
    formattedDuration = duration.toString().substring(0, 5);
  }
  return formattedDuration;
}

String convertCitiesEnumsToHebrew(Cities cityToConvert) {
  // from Cities.Jerusalem --> ירושלים
  print("city index: " +
      cityToConvert.index.toString() +
      ", value: " +
      cityToConvert.toString());
  return listOfCitiesInHebrew[cityToConvert.index];
}

Cities convertHebrewCityToEnum(String cityToConvert) {
  return Cities.values[listOfCitiesInHebrew.keys
      .firstWhere(((k) => listOfCitiesInHebrew[k] == cityToConvert))];
}

void switchColorOfCityChosenForError() {
  if (globals.defaultCity == Cities.None ||
      globals.borderOfCityChosenColor == Colors.red) {
    // exclude the case after choosing city the border will remain red
    globals.noCityChosen
        ? globals.borderOfCityChosenColor = Colors.red
        : globals.borderOfCityChosenColor = Colors.blueAccent;

    globals.noCityChosen = !globals.noCityChosen;
  }
}

void editRemainderValues(Remainder previousRemainder, Remainder newRemainder) {
  int remainderIndex = globals.userRemainders.indexOf(previousRemainder);
  globals.userRemainders[remainderIndex] = newRemainder;
}
