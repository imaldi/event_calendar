import 'package:event_calendar/presentation/data/data_source/meeting_data_source.dart';
import 'package:event_calendar/presentation/data/models/meeting_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MonthViewScreen extends StatelessWidget {
  const MonthViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
          view: CalendarView.month,
          firstDayOfWeek: DateTime.monday,
          dataSource: EventDataSource(_getDataSource()),
          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ));
  }


  List<Event> _getDataSource() {
    final List<Event> meetings = <Event>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
        Event(eventTitle: 'Conference', startTime:  startTime, endTime: endTime, background: const Color(0xFF0F8644), isAllDay:  false, description: "Oke"));
    return meetings;
  }
}
