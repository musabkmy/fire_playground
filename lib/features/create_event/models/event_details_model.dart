// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_playground/features/create_event/models/event_category.dart';

class EventDetailsModel {
  final String title;
  final EventCategory eventCategory;
  final String description;

  EventDetailsModel(
      {required this.title,
      required this.eventCategory,
      required this.description});

  EventDetailsModel copyWith({
    String? title,
    EventCategory? eventCategory,
    String? description,
  }) {
    return EventDetailsModel(
      title: title ?? this.title,
      eventCategory: eventCategory ?? this.eventCategory,
      description: description ?? this.description,
    );
  }

  @override
  String toString() =>
      'EventDetailsModel(title: $title, eventCategory: $eventCategory, description: $description)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'eventCategory': eventCategory.name,
      'description': description,
    };
  }

  factory EventDetailsModel.fromMap(Map<String, dynamic> map) {
    return EventDetailsModel(
      title: map['title'] as String,
      eventCategory: EventCategory.values.firstWhere(
        (e) => e.name == (map['eventCategory'] as String),
        orElse: () => throw ArgumentError('Invalid EventCategory: $json'),
      ),
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventDetailsModel.fromJson(String source) =>
      EventDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
