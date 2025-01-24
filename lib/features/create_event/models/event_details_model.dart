// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}
