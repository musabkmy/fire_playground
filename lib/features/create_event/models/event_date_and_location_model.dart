// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'startTime': startTime.hour * 60 + startTime.minute,
      'endTime': endTime.hour * 60 + endTime.minute,
      'eventLocationType': eventLocationType.label,
      'location': location,
    };
  }

  factory EventDateAndLocationModel.fromMap(Map<String, dynamic> map) {
    return EventDateAndLocationModel(
      date: (map['date'] as Timestamp).toDate(),
      startTime: TimeOfDay(
          hour: (map['startTime'] as int) ~/ 60,
          minute: (map['startTime'] as int) % 60),
      endTime: TimeOfDay(
          hour: (map['endTime'] as int) ~/ 60,
          minute: (map['endTime'] as int) % 60),
      eventLocationType: EventLocationType.values.firstWhere(
        (e) => e.label == map['eventLocationType'] as String,
        orElse: () => throw ArgumentError('Invalid EventCategory: $json'),
      ),
      location: map['location'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventDateAndLocationModel.fromJson(String source) =>
      EventDateAndLocationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
