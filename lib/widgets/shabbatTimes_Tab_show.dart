import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget shabbatTimeTabShow(String time, Size mediaQuerysize,
    MainAxisAlignment mainAxisAlignment, bool _visible) {
  return Opacity(
      opacity: _visible ? 1.0 : 0.0,
      child: Row(mainAxisAlignment: mainAxisAlignment, children: <Widget>[
        Container(
            width: mediaQuerysize.width / 3,
            height: mediaQuerysize.height / 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      time,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                Icon(Icons.access_time),
              ],
            ))
      ]));
}
