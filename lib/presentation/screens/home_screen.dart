import 'package:event_calendar/data/models/event_model.dart';
import 'package:event_calendar/presentation/screens/daily_view_screen.dart';
import 'package:event_calendar/presentation/screens/month_view_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // final eventBox = Hive.box<Event>('eventBox');
    // eventBox.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 128,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MonthViewScreen()));
                    }, child: const Text("Month View")),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                  width: double.maxFinite,
                  child: ElevatedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  DailyViewScreen()));
                  }, child: const Text("Day View"))),
              const SizedBox(
                height: 16,
              ),
              Container(
                  width: double.maxFinite,
                  child: ElevatedButton(onPressed: () {}, child: const Text("Week View"))),
            ],
          ),
        ),
      ),
    );
  }
}
