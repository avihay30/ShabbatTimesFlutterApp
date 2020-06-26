import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterandpython/models/remainder.dart';
import 'package:flutterandpython/widgets/remainder_item.dart';

class RemaindersList extends StatelessWidget {
  final List<Remainder> remainders;
  final Function deleteRemainder;
  final Function deleteRemainders;
  final Function setRemaindersState;

  RemaindersList(this.remainders, this.deleteRemainder, this.deleteRemainders,
      this.setRemaindersState);

  @override
  Widget build(BuildContext context) {
    print('build() TransactionList');

    var mediaQuery = MediaQuery.of(context);
    final double itemHeight =
        ((mediaQuery.size.height - mediaQuery.padding.top) / 7);
    final double itemWidth = mediaQuery.size.width / 2;
    return remainders.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  '!לא הוספת עדיין תזכורות לשבת',
                  style: Theme.of(context).textTheme.title,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'add an image path here for no items in list',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : LimitedBox(
      maxWidth: 2,
      maxHeight: 88,
      child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
            children: remainders
                .map((remainder) => RemainderItem(
                      key: ValueKey(remainder.id),
                      remainder: remainder,
                      deleteRemainder: deleteRemainder,
                      deleteRemainders: deleteRemainders,
                      setRemaindersState: setRemaindersState,
                    ))
                .toList(),
        ));
  }
}
