import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterandpython/functions/helper_functions.dart';
import 'package:flutterandpython/globals.dart' as globals;
import 'package:flutterandpython/models/remainder.dart';
import 'package:flutterandpython/widgets/background_item_options.dart';

class RemainderItem extends StatefulWidget {
  const RemainderItem({
    Key key,
    @required this.remainder,
    @required this.deleteRemainder,
    @required this.deleteRemainders,
    @required this.setRemaindersState,
  }) : super(key: key);

  final Remainder remainder;
  final Function deleteRemainder;
  final Function deleteRemainders;
  final Function setRemaindersState;

  @override
  _RemainderItemState createState() => _RemainderItemState();
}

class _RemainderItemState extends State<RemainderItem>
    with SingleTickerProviderStateMixin {
  var isSelected = false;
  var mycolor = Colors.white;
  // Color color;
  ImageFilter imageFilter;
  Color remainderDoneColor;
  Decoration boxBorderWhileBlur;
  double slideAmount;
  Color _bgColor;

  bool value = false;
  Function onChanged;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  void _editIsTaskDoneRemainder() {
    bool _isTaskDone = widget.remainder.isTaskDone;
    _isTaskDone = !_isTaskDone;
    final newRemainder = Remainder(
        title: widget.remainder.title,
        durationTime: widget.remainder.durationTime,
        id: widget.remainder.id,
        isTaskDone: _isTaskDone,
        isAlarmOn: widget.remainder.isAlarmOn);
    editRemainderValues(widget.remainder, newRemainder);
    widget.setRemaindersState();
  }

  void _setRemainderColorIfTaskIsDone(bool isSelected) {
    setState(() {
      isSelected
          ? remainderDoneColor = Colors.grey[300].withOpacity(0.35)
          : remainderDoneColor = Colors.transparent;
    });
  }

  Widget remainderCard() {
    // TODO: add icon for done/undone remainder
    return Positioned.fill(
        child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      // color: Colors.black,
      elevation: 5,
      margin: EdgeInsets.symmetric(),
      child: ListTile(
        // trailing:
        // Checkbox(
        //     value: value,
        //     onChanged: (bool newValue) {
        //       value = newValue;
        //     }),
        //   backgroundColor: _bgColor,
        //   radius: 15,
        //   child: Padding(
        //     padding: const EdgeInsets.all(0),
        //     child: FittedBox(
        //       child: Text('\$${widget.remainder.isTaskDone}'),
        //     ),
        //   ),
        // ),
        selected: isSelected,
        onTap: continueSelection,
        onLongPress: toggleSelection,
        title: Text(
          widget.remainder.title,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.end,
        ),
        subtitle: Text(
          "זמן תזכורת: ${formatDuration(widget.remainder.durationTime)} שעות לפני שבת",
        ),
        // trailing: MediaQuery.of(context).size.width > 460
        //     ? FlatButton.icon(
        //         icon: const Icon(Icons.delete),
        //         label: const Text('Delete'),
        //         textColor: Theme.of(context).errorColor,
        //         onPressed: () =>
        //             widget.deleteRemainder(widget.remainder.id),
        //       )
        //     : IconButton(
        //         icon: const Icon(Icons.delete),
        //         color: Theme.of(context).errorColor,
        //         onPressed: () =>
        //             widget.deleteRemainder(widget.remainder.id),
        //       ),
      ),
    ));
  }

  Widget creatingBlurOnSelction() {
    final size = MediaQuery.of(context).size;
    return Stack(children: <Widget>[
      ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
              filter: imageFilter == null
                  ? ImageFilter.blur(sigmaX: 0, sigmaY: 0)
                  : imageFilter,
              child: GestureDetector(
                  onTap: continueSelection,
                  onLongPress: toggleSelection,
                  child: Container(decoration: boxBorderWhileBlur
                      // color: Colors.black.withOpacity(0)
                      )))),
      ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: GestureDetector(
                  onTap: continueSelection,
                  onLongPress: toggleSelection,
                  child: Container(color: remainderDoneColor)))),
      Positioned(
          top: size.height / 140,
          left: size.width / 80,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: Checkbox.width * 1.3,
                width: Checkbox.width * 1.3,
                child: Container(
                    decoration: new BoxDecoration(
                      border: Border.all(
                        width: 1.8,
                      ),
                      borderRadius: new BorderRadius.circular(20),
                      color: Colors.amberAccent.withOpacity(0.7),
                    ),
                    child: new Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          value: widget.remainder.isTaskDone,
                          onChanged: (bool isSelected) {
                            _editIsTaskDoneRemainder();
                            _setRemainderColorIfTaskIsDone(isSelected);
                          },
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                        ))),
              )))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    print('build() item in title: ' + widget.remainder.title);
    print('this is title: ' +
        widget.remainder.title +
        ', is done? ' +
        widget.remainder.isTaskDone.toString());
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.black87,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 10,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Stack(children: <Widget>[
              BackgrounItemOptions(
                  remainder: widget.remainder,
                  setRemaindersState: widget.setRemaindersState),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                transform: isSelected
                    ? Matrix4.translationValues(globals.sliderAmount, 0, 0)
                    : Matrix4.translationValues(0, 0, 0),
                child: Stack(children: <Widget>[
                  remainderCard(),
                  creatingBlurOnSelction()
                ]),
              )
            ])));
  }

  void setSlideAmount() {
    final size = MediaQuery.of(context).size;
    if (globals.remaindersIdsToDelete.length < 1) {
      globals.sliderAmount = size.width / 8;
    } else
      globals.sliderAmount = 0.0;
  }

  void continueSelection() {
    if (globals.remaindersIdsToDelete.isNotEmpty) {
      return toggleSelection();
    } else
      print("you should long press to select");
  }

  void toggleSelection() {
    setState(() {
      setSlideAmount();
      if (isSelected) {
        // subtracking items from selection
        imageFilter = null;
        isSelected = false;
        boxBorderWhileBlur = null;
        globals.remaindersIdsToDelete.remove(widget.remainder.id);
        print("this is after sub " + globals.remaindersIdsToDelete.toString());
        widget.setRemaindersState();
      } else {
        // adding items to selection
        imageFilter = ImageFilter.blur(sigmaX: 1, sigmaY: 1);
        boxBorderWhileBlur = BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blueAccent, width: 1.3));
        isSelected = true;
        globals.remaindersIdsToDelete.add(widget.remainder.id);
        print("this is after add " + globals.remaindersIdsToDelete.toString());
        widget.setRemaindersState();
      }
    });
  }
}
