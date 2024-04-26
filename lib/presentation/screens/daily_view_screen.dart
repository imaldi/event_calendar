import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Appointment {
  final String subject;
  final DateTime startTime;
  final DateTime endTime;

  Appointment({required this.subject, required this.startTime, required this.endTime});
}

class DailyViewScreen extends StatefulWidget {
  @override
  _DailyViewScreenState createState() => _DailyViewScreenState();
}

class _DailyViewScreenState extends State<DailyViewScreen> {
  final List<Appointment> _appointments = [
    Appointment(
      subject: 'Meeting',
      startTime: DateTime(2023, 5, 22, 9, 0),
      endTime: DateTime(2023, 5, 22, 10, 0),
    ),
    Appointment(
      subject: 'Lunch',
      startTime: DateTime(2023, 5, 22, 12, 0),
      endTime: DateTime(2023, 5, 22, 13, 0),
    ),
    // Add more appointments as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.timelineDay,
      backgroundColor: Colors.white,
      dataSource: _getDataSource(),
      initialDisplayDate: DateTime(2023, 5, 22),
      timeSlotViewSettings: const TimeSlotViewSettings(
        startHour: 8,
        endHour: 20,
      ),
    );
  }

  _getDataSource() {
    final List<Appointment> appointments = _appointments;
    return AppointmentDataSource(appointments);
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
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
    return appointments![index].subject;
  }
}