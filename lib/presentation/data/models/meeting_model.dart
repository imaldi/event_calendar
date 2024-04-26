
import 'package:flutter/material.dart';

class Event {
  Event({
      this.eventTitle,
      this.startTime,
      this.endTime,
      this.background,
      this.isAllDay,
      this.description});

  String? eventTitle;
  DateTime? startTime;
  DateTime? endTime;
  Color? background;
  bool? isAllDay;
  String? description;
}