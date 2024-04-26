import 'package:event_calendar/data/data_source/meeting_data_source.dart';
import 'package:event_calendar/data/models/event_model.dart';
import 'package:event_calendar/presentation/screens/add_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  final Box<Event> eventBox = Hive.box<Event>('eventBox');

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
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
            valueListenable: eventBox.listenable(),
            builder: (context, box, widget) {
              eventBox.values.forEach((element) {print("StartTime: ${element.startTime}");});
              // print("List events: ${}");
              return SfCalendar(
                view: CalendarView.day,
                firstDayOfWeek: DateTime.monday,
                dataSource: EventDataSource(
                    eventBox.values.toList()
                  // _getDataSource()
                ),
                timeSlotViewSettings: TimeSlotViewSettings(
                  startHour: 7,
                  endHour: 18,
                  timeIntervalWidth: 8
                ),
      
                // monthViewSettings: const MonthViewSettings(
                //     appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
              );
            }
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          final eventBox = Hive.box<Event>('eventBox');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEventScreen(eventBox: eventBox),
            ),
          );
        },
          child: Icon(Icons.add),),
      ),
    );
  }

}
