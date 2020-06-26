import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterandpython/functions/helper_functions.dart';
import 'package:flutterandpython/models/remainder.dart';
import 'package:flutterandpython/globals.dart' as globals;

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
  double slideAmount;
  Color _bgColor;

  static AnimationController controller;

  // void setupAnimation() {
  //   controller = AnimationController(
  //     duration: const Duration(seconds: 1),
  //     vsync: this,
  //   );

  //   controller.forward();
  // }

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    // controller = AnimationController(
    //   duration: const Duration(seconds: 1),
    //   vsync: this,
    // );

    // controller.forward();
    super.initState();
  }

  Widget remainderCard() {
    return Positioned.fill(
        child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      // color: Colors.black,
      elevation: 5,
      margin: EdgeInsets.symmetric(),
      child: ListTile(
        // leading: CircleAvatar(
        //   backgroundColor: _bgColor,
        //   radius: 30,
        //   child: Padding(
        //     padding: const EdgeInsets.all(6),
        //     child: FittedBox(
        //       child: Text('\$${widget.remainder.amount}'),
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
    return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BackdropFilter(
            filter: imageFilter == null
                ? ImageFilter.blur(sigmaX: 0, sigmaY: 0)
                : imageFilter,
            child: GestureDetector(
                onTap: continueSelection,
                onLongPress: toggleSelection,
                child: Container(color: Colors.black.withOpacity(0)))));
  }

  Widget backgroundOptions() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 8.5,
      width: size.width / 9,
      child:
      Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.amberAccent,
      ),
      margin: EdgeInsets.only(left: size.width / 70, top: size.height / 170),
      child: ClipRRect(
      // borderRadius: BorderRadius.circular(20.0),
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
        Expanded(child: Container(
          // color: Colors.blue,
          child: 
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.edit),
          splashColor: Colors.grey,
        ))),
                Expanded(child: Container(
          // color: Colors.green,
          child: 
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.alarm_off),
        ),))
      ]),
    )));
  }

  @override
  Widget build(BuildContext context) {
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
              backgroundOptions(),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                transform: isSelected
                    ? Matrix4.translationValues(slideAmount, 0, 0)
                    : Matrix4.translationValues(0, 0, 0),
                child: Stack(children: <Widget>[
                  remainderCard(),
                  creatingBlurOnSelction()
                ]),
              )
            ])));
  }

  void continueSelection() {
    if (globals.remaindersIdsToDelete.isNotEmpty) {
      return toggleSelection();
    } else
      print("you should long press to select");
  }

  void toggleSelection() {
    final size = MediaQuery.of(context).size;
    setState(() {
      if (isSelected) {
        // subtracking items from selection
        imageFilter = null;
        slideAmount = 0.0;
        isSelected = false;
        globals.remaindersIdsToDelete.remove(widget.remainder.id);
        print("this is after sub " + globals.remaindersIdsToDelete.toString());
        widget.setRemaindersState();
      } else {
        // adding items to selection
        imageFilter = ImageFilter.blur(sigmaX: 1, sigmaY: 1);
        slideAmount = size.width / 8;
        isSelected = true;
        globals.remaindersIdsToDelete.add(widget.remainder.id);
        print("this is after add " + globals.remaindersIdsToDelete.toString());
        widget.setRemaindersState();
      }
    });
  }
}
