
import 'package:event_calendar/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventTitle;
  }

  @override
  Color getColor(int index) {
    return Color(appointments![index].backgroundHex);
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
