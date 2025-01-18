import 'package:fire_playground/features/create_event/models/event_location_type.dart';

class EventDateAndLocationModel {
  final DateTime date;
  final EventLocationType eventLocationType;
  final String location;

  EventDateAndLocationModel(
      {required this.date,
      required this.eventLocationType,
      required this.location});
}
