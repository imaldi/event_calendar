
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'event_model.g.dart';

@HiveType(typeId: 0)
class Event extends HiveObject {
  Event({
      this.eventTitle,
      this.startTime,
      this.endTime,
      this.background,
      this.isAllDay,
      this.description});

  @HiveField(0)
  String? eventTitle;
  @HiveField(1)
  DateTime? startTime;
  @HiveField(2)
  DateTime? endTime;
  @HiveField(3)
  Color? background;
  @HiveField(4)
  bool? isAllDay;
  @HiveField(5)
  String? description;
}