// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fire_playground/features/create_event/models/event_location_type.dart';

class EventDateAndLocationModel {
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final EventLocationType eventLocationType;
  final String location;

  EventDateAndLocationModel(
      {required this.date,
      required this.startTime,
      required this.endTime,
      required this.eventLocationType,
      required this.location});

  @override
  String toString() {
    return 'EventDateAndLocationModel(date: $date, startTime: $startTime, endTime: $endTime, eventLocationType: $eventLocationType, location: $location)';
  }
}
