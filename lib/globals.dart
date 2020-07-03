library globals;

import 'package:flutter/material.dart';
import 'package:flutterandpython/Cities.dart';
import 'package:flutterandpython/models/remainder.dart';

Cities defaultCity = Cities.None;
bool cityChooseSelected = false;
bool noCityChosen = true;
Color borderOfCityChosenColor = Colors.blueAccent;
bool isShabbatTimesVisable = false;
List<Remainder> userRemainders = [];
List<String> remaindersIdsToDelete = [];
double sliderAmount = 0.0;