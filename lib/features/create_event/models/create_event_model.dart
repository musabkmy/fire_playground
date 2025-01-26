// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fire_playground/features/create_event/models/event_date_and_location_model.dart';
import 'package:fire_playground/features/create_event/models/event_details_model.dart';
import 'package:fire_playground/features/create_event/models/event_speaker_model.dart';

class CreateEventModel {
  EventDetailsModel? eventDetails;
  EventDateAndLocationModel? eventDateAndLocation;
  List<EventSpeakerModel> speakers;

  CreateEventModel(
      {this.eventDetails, this.eventDateAndLocation, this.speakers = const []});

  bool isCreateEventModelCreated() =>
      eventDetails != null &&
      eventDateAndLocation != null &&
      speakers.isNotEmpty;

  @override
  String toString() =>
      'CreateEventModel(eventDetails: $eventDetails,\n eventDateAndLocation: $eventDateAndLocation,\n speakers: $speakers)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventDetails': eventDetails?.toMap(),
      'eventDateAndLocation': eventDateAndLocation?.toMap(),
      'speakers': speakers.map((x) => x.toMap()).toList(),
    };
  }

  factory CreateEventModel.fromMap(Map<String, dynamic> map) {
    return CreateEventModel(
      eventDetails: map['eventDetails'] != null
          ? EventDetailsModel.fromMap(
              map['eventDetails'] as Map<String, dynamic>)
          : null,
      eventDateAndLocation: map['eventDateAndLocation'] != null
          ? EventDateAndLocationModel.fromMap(
              map['eventDateAndLocation'] as Map<String, dynamic>)
          : null,
      speakers: List<EventSpeakerModel>.from(
        map['speakers'].map<EventSpeakerModel>(
          (x) => EventSpeakerModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateEventModel.fromJson(String source) =>
      CreateEventModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
