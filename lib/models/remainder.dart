import 'package:flutter/foundation.dart';

class Remainder {
  final String id;
  final String title;
  final Duration durationTime;
  final bool isTaskDone;
  final bool isAlarmOn;

  Remainder({
    @required this.id,
    @required this.title,
    @required this.durationTime,
    @required this.isTaskDone,
    @required this.isAlarmOn
  });
}
