// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fire_playground/features/create_event/models/event_date_and_location_model.dart';
import 'package:fire_playground/features/create_event/models/event_details_model.dart';
import 'package:fire_playground/features/create_event/models/event_speaker_model.dart';

class CreateEventModel {
  EventDetailsModel? eventDetails;
  EventDateAndLocationModel? eventDateAndLocation;
  List<EventSpeakerModel> speakers;

  CreateEventModel(
      {this.eventDetails, this.eventDateAndLocation, this.speakers = const []});

  @override
  String toString() =>
      'CreateEventModel(eventDetails: $eventDetails,\n eventDateAndLocation: $eventDateAndLocation,\n speakers: $speakers)';
}
