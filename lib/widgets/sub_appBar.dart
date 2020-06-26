import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterandpython/Cities.dart';
import 'package:flutterandpython/Constans.dart';
import 'package:flutterandpython/functions/helper_functions.dart';
import 'package:flutterandpython/globals.dart' as globals;
import 'package:flutterandpython/widgets/shabbatTimes_Tab_show.dart';

class SubAppBar extends StatefulWidget {
  @override
  SubAppBarState createState() {
    print('createState NewRemainder Widget');
    return SubAppBarState();
  }
}

class SubAppBarState extends State<SubAppBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext buildContext) {
    final size = MediaQuery.of(context).size;

    return Stack(children: <Widget>[
      Row(children: <Widget>[
        Expanded(
          child: shabbatTimeTabShow("<start_time>", size, MainAxisAlignment.start,
              globals.isShabbatTimesVisable),
        ),
        Expanded(
          child: shabbatTimeTabShow("<stop_time>", size, MainAxisAlignment.end,
              globals.isShabbatTimesVisable),
        ),
      ]),
      GestureDetector(
        onTap: () {
          setState(() {
            globals.cityChooseSelected = !globals.cityChooseSelected;
          });
        },
        child: Center(
            child: AnimatedSize(
                alignment: Alignment.center,
                duration: Duration(milliseconds: 1000),
                curve: Curves.fastLinearToSlowEaseIn,
                vsync: this,
                child: Container(
                    alignment: Alignment.center,
                    height: globals.cityChooseSelected
                        ? size.height / 10
                        : size.height / 20,
                    width: globals.cityChooseSelected
                        ? size.width / 2
                        : size.width / 3,
                    decoration: globals.cityChooseSelected
                        ? BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(75),
                                bottomRight: Radius.circular(75)),
                            color: Colors.blueAccent,
                            border:
                                Border.all(color: Colors.blueAccent, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 15,
                                offset: Offset(0, 0),
                              )
                            ],
                          )
                        : BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            color: Colors.blueAccent,
                            border: Border.all(
                                color: globals.borderOfCityChosenColor,
                                width: 2),
                            boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ]),
                    child: globals.cityChooseSelected
                        ? Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30)),
                                  color: Colors.cyan,
                                  border: Border.all(color: Colors.cyan)),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              child: Text(
                                ":בחר עיר מגורים",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              width:
                                  MediaQuery.of(context).copyWith().size.width /
                                      4,
                              height: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height /
                                  20,
                              decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border: Border.all(
                                    color: globals.borderOfCityChosenColor),
                              ),
                              child: DropdownButton<String>(
                                value: globals.defaultCity == Cities.None
                                    ? convertCitiesEnumsToHebrew(
                                        Cities.Jerusalem)
                                    : convertCitiesEnumsToHebrew(
                                        globals.defaultCity),
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.white),
                                dropdownColor: Colors.cyan,
                                underline: Container(
                                  height: 2,
                                  color: Colors.white70,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    switchColorOfCityChosenForError();
                                    globals.defaultCity =
                                        convertHebrewCityToEnum(newValue);
                                    switchColorOfCityChosenForError();
                                    print("this is the new city global:  " +
                                        globals.defaultCity.toString());
                                    globals.cityChooseSelected =
                                        !globals.cityChooseSelected;
                                    globals.isShabbatTimesVisable = true;
                                  });
                                },
                                items: listOfCitiesInHebrew.values
                                    .toList()
                                    .sublist(0, 4) // exclude ":בחר עיר מגורים"
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            )
                          ])
                        : Container(
                            alignment: Alignment.center,
                            child: Text(
                              '${convertCitiesEnumsToHebrew(globals.defaultCity)}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          )))),
      ),
    ]);
  }
}
