
import 'package:flutter/material.dart';
import 'package:flutterandpython/remaindersPage.dart';

void main() {
  const String _title = 'שבתזכורת';

  runApp(MaterialApp(
    title: _title,
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.

    initialRoute: '/remaindersPage',
    routes: {
      '/remaindersPage': (context) => RemaindersPage()
    //   '/chooseCityPage': (context) => ChooseCityPage(),
    // },
    }));
}

// /// This Widget is the main application widget.
// class MyApp extends StatelessWidget {
//   static const String _title = 'שבתזכורת';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       // home: Scaffold(
//       //   appBar: AppBar(title: const Text(_title)),
//       //   body: Center(
//       //     child: MyStatefulWidget(),

//       // initialRoute: '/splashScreen',
//       routes: {
//         '/remaindersPage': (context) => RemaindersPage(),
//         '/chooseCityPage': (context) => ChooseCityPage(),
//       },
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text(_title)),
//       body: Center(
//         child:
//           if (globals.defaultCity == Cities.None) {
//             // First time
//             return navigationPageHome;
//           } else {
//             // Not first time
//             return navigationPageWel;
//           }
//       )
//     );
//     // if (globals.defaultCity == Cities.None) {
//     //   // First time
//     //   return navigationPageHome;
//     // } else {
//     //   // Not first time
//     //   return navigationPageWel;
//     // }

//   void navigationPageHome() {
//     Navigator.pushNamed(context, '/remaindersPage');
//   }

//   void navigationPageWel() {
//     Navigator.pushNamed(context, '/chooseCityPage');
//   }
// }

// class MyStatefulWidget extends StatefulWidget {
//   // MyStatefulWidget({Key key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyStatefulWidget> {
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Stack(
//       children: <Widget>[
//         Center(
//           child: Text("hi")
//         ),
//       ],
//     ),
//   );

// if (globals.defaultCity == Cities.None) {

//     Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ChooseCityPage()),
//         );
// }
// return RemaindersPage();
// }
// }
