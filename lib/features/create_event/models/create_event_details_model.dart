import 'package:fire_playground/features/create_event/models/event_category.dart';

class CreateEventDetailsModel {
  final String title;
  final EventCategory eventCategory;
  final String description;

  CreateEventDetailsModel(
      {required this.title,
      required this.eventCategory,
      required this.description});
}
