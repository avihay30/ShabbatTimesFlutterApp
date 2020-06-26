import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgrounItemOptions extends StatelessWidget {

@override
Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height / 8.5,
        width: size.width / 9,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.amberAccent,
            ),
            margin:
                EdgeInsets.only(left: size.width / 70, top: size.height / 170),
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            // color: Colors.blue,
                            child: IconButton(
                      onPressed: () {}, // TODO: add funcionality to button
                      icon: Icon(Icons.edit),
                      splashColor: Colors.grey,
                    ))),
                    Expanded(
                        child: Container(
                      // color: Colors.green,
                      child: IconButton(
                        onPressed: () {}, // TODO: add funcionality to button
                        icon: Icon(Icons.alarm_off),
                      ),
                    ))
                  ]),
            )));
  }}