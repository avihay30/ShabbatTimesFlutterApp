import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterandpython/Cities.dart';
import 'package:flutterandpython/functions/helper_functions.dart';
import 'package:flutterandpython/models/remainder.dart';
import 'package:flutterandpython/widgets/new_remainder.dart';
import 'package:flutterandpython/widgets/remainder_list.dart';
import 'package:flutterandpython/widgets/sub_appBar.dart';

import 'globals.dart' as globals;

class RemaindersPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RemaindersPage> with TickerProviderStateMixin {
  final List<Remainder> _userRemainders = [];
  String url;
  var data;
  var queryText = 'Quary';
  bool selected = false;

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addObserver(this);
  //   super.initState();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print(state);
  // }

  // @override
  // dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  void _deleteRemainder(String id) {
    setState(() {
      _userRemainders.removeWhere((remainder) => remainder.id == id);
    });
  }

  void _deleteRemainders(List<String> ids) {
    ids.forEach((remainderId) {
      _deleteRemainder(remainderId);
    globals.remaindersIdsToDelete = [];
    });
  }

  void _setRemaindersState() {
    setState(() {});
  }

  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget cityChosen,
    Widget remaindersListWidget,
  ) {
    return [remaindersListWidget];
  }

  List<Widget> _buildPortraitContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget cityChosen,
    Widget remaindersListWidget,
  ) {
    return [cityChosen, remaindersListWidget];
  }

  void _addNewRemainder(String remainderTitle, Duration chosenTime) {
    final newRemainder = Remainder(
      title: remainderTitle,
      durationTime: chosenTime,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userRemainders.add(newRemainder);
    });
  }

  void _startAddNewRemainder(BuildContext ctx) {
    globals.defaultCity == Cities.None
        ? setState(() {
            globals.cityChooseSelected = true;
            switchColorOfCityChosenForError();
          })
        : showModalBottomSheet(
            context: ctx,
            builder: (context) {
              return GestureDetector(
                onTap: () {},
                child: NewRemainder(_addNewRemainder),
                behavior: HitTestBehavior.opaque,
              );
            },
          );
  }

  FloatingActionButton floatingActionButtonMod() {
    if (globals.remaindersIdsToDelete.isNotEmpty) {
      return FloatingActionButton(
          child: Icon(Icons.delete),
          backgroundColor: Colors.red,
          onPressed: () {
            _deleteRemainders(globals.remaindersIdsToDelete);
            // setState(() {
            // });
            });
    }
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => _startAddNewRemainder(context),
    );
  }

  Widget _buildAppBarWithFunctionality() {
    const String _title = 'שבתזכורת';
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(_title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewRemainder(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(_title),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewRemainder(context),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    print('build() MyHomePageState');
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _buildAppBarWithFunctionality();
    final cityChosen = SubAppBar();
    final remaindersListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: RemaindersList(_userRemainders, _deleteRemainder,
          _deleteRemainders, _setRemaindersState),
    );
    final pageBody = SafeArea(
        child: GestureDetector(
      // to disabe the chooseCity pop up when tap the screen
      onTap: () {
        setState(() {
          globals.cityChooseSelected = false;
        });
        print("tapped on screen");
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(
                mediaQuery,
                appBar,
                cityChosen,
                remaindersListWidget,
              ),
            if (!isLandscape)
              ..._buildPortraitContent(
                mediaQuery,
                appBar,
                cityChosen,
                remaindersListWidget,
              ),
          ],
        ),
      ),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: floatingActionButtonMod());

    // Scaffold(
    //     appBar: appBar,
    //     body: Center(
    //         child: Column(
    //       children: <Widget>[
    //         Padding(
    //           padding: const EdgeInsets.all(10.0),
    //           child: TextField(
    //             onChanged: (value) {
    //               url = Constants.URL + value.toString();
    //             },
    //             decoration: InputDecoration(
    //                 hintText: 'Search Anything Here',
    //                 suffixIcon: GestureDetector(
    //                     onTap: () async {
    //                       data = await getData(url);
    //                       // Map<String, dynamic> map = jsonDecode(Data);
    //                       // List<dynamic> data = map["result"];
    //                       // var DecodedData = data;
    //                       var decodedData = jsonDecode(data);
    //                       var resultData = decodedData['result'];
    //                       var recordData = resultData['records'];
    //                       setState(() {
    //                         // queryText = DecodedData['Query'];
    //                         queryText = jsonEncode(recordData);
    //                       });
    //                     },
    //                     child: Icon(Icons.search))),
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(10.0),
    //           child: Text(
    //             queryText,
    //             style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(10.0),
    //           child: Text(
    //             globals.defaultCity.toString(),
    //             style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
    //           ),
    //         ),
    //         FloatingActionButton(
    //                 child: Icon(Icons.add),
    //                 onPressed: () => _startAddNewRemainder(context),
    //               ),
    //       ],
    //     )
    //   )
    // );
  }
}
