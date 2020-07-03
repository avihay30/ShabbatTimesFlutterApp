import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterandpython/functions/helper_functions.dart';
import 'package:flutterandpython/models/remainder.dart';
import 'package:flutterandpython/widgets/new_remainder.dart';

class BackgrounItemOptions extends StatefulWidget {
  const BackgrounItemOptions(
      {Key key, @required this.remainder, @required this.setRemaindersState})
      : super(key: key);

  final Remainder remainder;
  final Function setRemaindersState;

  @override
  _BackgrounItemOptionsState createState() => _BackgrounItemOptionsState();
}

class _BackgrounItemOptionsState extends State<BackgrounItemOptions> {
  void _editRemainder(String remainderTitle, Duration chosenTime) {
    final newRemainder = Remainder(
        title: remainderTitle,
        durationTime: chosenTime,
        id: widget.remainder.id,
        isTaskDone: widget.remainder.isTaskDone,
        isAlarmOn: widget.remainder.isAlarmOn);

    setState(() {
      editRemainderValues(widget.remainder, newRemainder);
    });
  }

  void _startEditingRemainder(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: NewRemainder(
              addRemainder: _editRemainder, remainderToEdit: widget.remainder),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _editIsAlarmOnRemainder() {
    bool _isAlarmOn = widget.remainder.isAlarmOn;
    _isAlarmOn = !_isAlarmOn;
    final newRemainder = Remainder(
        title: widget.remainder.title,
        durationTime: widget.remainder.durationTime,
        id: widget.remainder.id,
        isTaskDone: widget.remainder.isTaskDone,
        isAlarmOn: _isAlarmOn);

    editRemainderValues(widget.remainder, newRemainder);
    widget.setRemaindersState();
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
                      onPressed: () => _startEditingRemainder(context),
                      icon: Icon(Icons.edit),
                      splashColor: Colors.grey,
                    ))),
                    Expanded(
                        child: Container(
                      // color: Colors.green,
                      child: IconButton(
                          onPressed: () => _editIsAlarmOnRemainder(),
                          icon: widget.remainder.isAlarmOn
                              ? Icon(Icons.alarm_on)
                              : Icon(Icons.alarm_off)),
                    ))
                  ]),
            )));
  }
}
