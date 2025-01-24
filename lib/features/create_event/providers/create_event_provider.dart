import 'package:fire_playground/features/create_event/models/create_event_model.dart';
import 'package:fire_playground/features/create_event/models/event_date_and_location_model.dart';
import 'package:fire_playground/features/create_event/models/event_details_model.dart';
import 'package:fire_playground/features/create_event/models/event_speaker_model.dart';
import 'package:flutter/material.dart';

class CreateEventProvider extends ChangeNotifier {
  final CreateEventModel _createEventModel;

  CreateEventProvider() : _createEventModel = CreateEventModel();

  set eventDetails(EventDetailsModel? eventDetails) {
    _createEventModel.eventDetails = eventDetails;
    // notifyListeners();
  }

  EventDetailsModel? get eventDetails => _createEventModel.eventDetails;

  bool isEventDetailsCreated() => _createEventModel.eventDetails != null;

  set dateAndLocation(EventDateAndLocationModel? eventDateAndLocation) {
    _createEventModel.eventDateAndLocation = eventDateAndLocation;
    // notifyListeners();
  }

  EventDateAndLocationModel? get dateAndLocation =>
      _createEventModel.eventDateAndLocation;

  bool isEventDateAndLocationCreated() =>
      _createEventModel.eventDateAndLocation != null;

  set speakers(List<EventSpeakerModel> speakers) {
    _createEventModel.speakers = speakers;
    debugPrint(_createEventModel.toString());
    // notifyListeners();
  }

  List<EventSpeakerModel> get speakers => _createEventModel.speakers;

  bool isSpeakersEmpty() => _createEventModel.speakers.isEmpty;
}
