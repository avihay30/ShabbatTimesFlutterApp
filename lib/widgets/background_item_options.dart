import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterandpython/models/remainder.dart';
import 'package:flutterandpython/widgets/new_remainder.dart';
import 'package:flutterandpython/globals.dart' as globals;
import 'package:flutterandpython/widgets/remainder_item.dart';

class BackgrounItemOptions extends StatefulWidget {
  const BackgrounItemOptions({
    Key key,
    @required this.remainder}) : super(key: key);

  final Remainder remainder;

  // final Remainder remainder;

  // RemainderItem({this.remainder});



  @override
  _BackgrounItemOptionsState createState() => _BackgrounItemOptionsState();
}

class _BackgrounItemOptionsState extends State<BackgrounItemOptions> {

  void _addNewRemainder(String remainderTitle, Duration chosenTime) {
    final newRemainder = Remainder(
      title: remainderTitle,
      durationTime: chosenTime,
      id: widget.remainder.id,
    );

    setState(() {
      int remainderIndex = globals.userRemainders.indexOf(widget.remainder);
      globals.userRemainders[remainderIndex] = newRemainder;
    });
  }

  void _startAddNewRemainder(BuildContext ctx, Remainder remainder) {
    showModalBottomSheet(
        context: ctx,
        builder: (context) {
          return GestureDetector(
            onTap: () {},
            child: NewRemainder(addRemainder: _addNewRemainder, remainderToEdit: remainder),
            behavior: HitTestBehavior.opaque,
          );
        },
      );
  }

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
                      onPressed: () {
                        _startAddNewRemainder(context, widget.remainder);
                      }, // TODO: add funcionality to button
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