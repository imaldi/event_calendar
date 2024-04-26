import 'package:event_calendar/data/data_source/meeting_data_source.dart';
import 'package:event_calendar/data/models/event_model.dart';
import 'package:event_calendar/presentation/screens/add_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class WeeklyViewScreen extends StatelessWidget {
  WeeklyViewScreen({Key? key}) : super(key: key);
  final Box<Event> eventBox = Hive.box<Event>('eventBox');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
            valueListenable: eventBox.listenable(),
            builder: (context, box, widget) {
              return SfCalendar(
                view: CalendarView.week,
                firstDayOfWeek: DateTime.monday,
                dataSource: EventDataSource(
                    eventBox.values.toList()
                  // _getDataSource()
                ),
                monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
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
