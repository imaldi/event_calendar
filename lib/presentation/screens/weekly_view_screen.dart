import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class WeeklyViewScreen extends StatelessWidget {
  const WeeklyViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
          view: CalendarView.workWeek,
          timeSlotViewSettings: const TimeSlotViewSettings(
              startHour: 9,
              endHour: 16,
              nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),
        ));
  }
}
