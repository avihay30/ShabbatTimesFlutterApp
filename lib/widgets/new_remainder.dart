import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:flutterandpython/functions/helper_functions.dart';
// import 'package:intl/intl.dart';

import '../widgets/adaptive_flat_button.dart';

class NewRemainder extends StatefulWidget {
  final Function addRemainder;

  NewRemainder(this.addRemainder) {
    print('Constructor NewRemainder Widget');
  }

  @override
  _NewRemainderState createState() {
    print('createState NewRemainder Widget');
    return _NewRemainderState();
  }
}

class _NewRemainderState extends State<NewRemainder> {
  final _titleController = TextEditingController();
  Duration _selectedTime;

  _NewRemainderState() {
    print('Constructor NewRemainder State');
  }

  @override
  void initState() {
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(NewRemainder oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  void _submitData() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _selectedTime == null) {
      return;
    }

    widget.addRemainder(
      enteredTitle,
      _selectedTime,
    );

    Navigator.of(context).pop();
  }

  void _durationTimePicker() async {
    Duration resultingDuration = await showDurationPicker(
      context: context,
      initialTime: _selectedTime == null
      ? new Duration(minutes: 15)
      : _selectedTime,
      snapToMins: 5.0,
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _selectedTime = pickedTime;
      });
    return;});
    print('selected time: ' + _selectedTime.toString());
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text("הזמן הנבחר: $resultingDuration")
      ));
  }

//   // Function to call future
// void runDurationTimePicker() {
//   _durationTimePicker()
//   .then((pickedTime) {
//       if (pickedTime == null) {
//         return;
//       }
//       setState(() {
//         _selectedTime = pickedTime;
//       });
//     });
// }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'שם התזכורת'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              // TextField(
              //   decoration: InputDecoration(labelText: 'Amount'),
              //   controller: _amountController,
              //   keyboardType: TextInputType.number,
              //   onSubmitted: (_) => _submitData(),
              //   // onChanged: (val) => amountInput = val,
              // ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedTime == null
                            ? 'זמן לא נבחר!'
                            : 'זמן נבחר: ${formatDuration(_selectedTime)} שעות לפני שבת',
                      ),
                    ),
                    AdaptiveFlatButton('בחר זמן', _durationTimePicker)
                  ],
                ),
              ),
              RaisedButton(
                child: Text('הוסף תזכורת'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
