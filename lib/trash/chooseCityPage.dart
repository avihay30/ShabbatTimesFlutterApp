// import 'package:flutter/material.dart';
// import 'package:flutterandpython/Cities.dart';
// import 'package:flutterandpython/Constans.dart';
// import 'package:flutterandpython/baseAppBar.dart';
// import 'package:flutterandpython/functions/helper_functions.dart';
// import 'package:flutterandpython/remaindersPage.dart';
// import 'globals.dart' as globals;

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'AnimatedSize',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new ChooseCityPage(),
//     );
//   }
// }

// class ChooseCityPage extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<ChooseCityPage> with TickerProviderStateMixin  {
//   String dropdownValue = 'ירושלים';
  
//   double _height = 80.0;
//   double _width = 80.0;
//   var _color = Colors.blue;
//   bool _resized = false;
//   bool selected = false;

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: baseAppBar(),
//         body: new Center(
//           child: new Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               new AnimatedSize(
//                 curve: Curves.easeInOutBack,
//                 child: new GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       if (_resized) {
//                         _resized = false;
//                         _color = Colors.blue;
//                         _height = 80.0;
//                         _width = 80.0;
//                       } else {
//                         _resized = true;
//                         _color = Colors.blue;
//                         _height = 320.0;
//                         _width = 320.0;
//                       }
//                     });
//                   },
//                 child: new Container(
//                   width: _width,
//                   height: _height,
//                   color: _color,
                  
//                   child: Text(
//                   '${convertCitiesEnumsToHebrew(globals.defaultCity)}',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 ),
//               ),
//               vsync: this,
//               duration: new Duration(seconds: 1),
//             ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Text(
//                   "בחר איזור מגוריך",
//                   style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: DropdownButton<String>(
//                   value: dropdownValue,
//                   icon: Icon(Icons.arrow_downward),
//                   iconSize: 24,
//                   elevation: 16,
//                   style: TextStyle(color: Colors.deepPurple),
//                   underline: Container(
//                     height: 2,
//                     color: Colors.deepPurpleAccent,
//                   ),
//                   onChanged: (String newValue) {
//                     setState(() {
//                       dropdownValue = newValue;
//                     });
//                   },
//                   items: listOfCitiesInHebrew.values
//                     .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               RaisedButton(
//                   onPressed: () {
//                     setState(() {
//                       globals.defaultCity = convertHebrewCityToEnum(dropdownValue);
//                     });
//                     Navigator.push(
//                       context, 
//                       MaterialPageRoute(builder: (context) => RemaindersPage()),
//                       );
//                     // Navigator.pop(context);
//                   },
//                   textColor: Colors.white,
//                   padding: const EdgeInsets.all(0.0),
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: <Color>[
//                           Color(0xFF0D47A1),
//                           Color(0xFF1976D2),
//                           Color(0xFF42A5F5),
//                         ],
//                       ),
//                     ),
//                     padding: const EdgeInsets.all(10.0),
//                     child: const Text('החל שינויים', style: TextStyle(fontSize: 20)),
//                   )),
//             ])
//           )
//         );
//   }
// }
