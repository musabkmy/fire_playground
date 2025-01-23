import 'package:fire_playground/features/create_event/models/create_event_model.dart';
import 'package:fire_playground/features/create_event/models/event_date_and_location_model.dart';
import 'package:fire_playground/features/create_event/models/event_details_model.dart';
import 'package:fire_playground/features/create_event/models/event_speaker_model.dart';
import 'package:flutter/material.dart';

class CreateEventProvider extends ChangeNotifier {
  final CreateEventModel _createEventModel;

  CreateEventProvider() : _createEventModel = CreateEventModel();

  set details(EventDetailsModel eventDetails) {
    _createEventModel.eventDetails = eventDetails;
    notifyListeners();
  }

  bool isDetailsNull() => _createEventModel.eventDetails == null;

  set dateAndLocation(EventDateAndLocationModel eventDateAndLocation) {
    _createEventModel.eventDateAndLocation = eventDateAndLocation;
    notifyListeners();
  }

  bool isDateAndLocationNull() =>
      _createEventModel.eventDateAndLocation == null;

  void addSpeaker(EventSpeakerModel speaker) {
    _createEventModel.speakers.add(speaker);
    notifyListeners();
  }

  bool isSpeakersEmpty() => _createEventModel.speakers.isEmpty;
}
