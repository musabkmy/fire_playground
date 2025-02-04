import 'package:fire_playground/features/create_event/constants.dart';
import 'package:fire_playground/features/create_event/models/event_date_and_location_model.dart';
import 'package:fire_playground/features/create_event/models/event_location_type.dart';
import 'package:fire_playground/features/create_event/providers/create_event_provider.dart';
import 'package:fire_playground/features/create_event/providers/page_controller_provider.dart';
import 'package:fire_playground/features/create_event/shared_layout/form_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDateAndLocationLayout extends StatefulWidget {
  static const String id = 'EventDateAndLocationLayout';
  const EventDateAndLocationLayout({super.key});

  @override
  State<EventDateAndLocationLayout> createState() =>
      _EventDateAndLocationLayoutState();
}

class _EventDateAndLocationLayoutState
    extends State<EventDateAndLocationLayout> {
  final GlobalKey<FormState> _dateAndLocationFormKey = GlobalKey<FormState>();
  DateTime? _selectedDate;

  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;

  EventLocationType? _selectedLocationOption;
  final _locationDescriptionController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 60)),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (picked != null && picked != _selectedStartTime) {
      setState(() {
        _selectedStartTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    if (_selectedStartTime != null) {
      final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(
              hour: _selectedStartTime!.hour + 2,
              minute: _selectedStartTime!.minute));

      if (picked != null && picked != _selectedEndTime) {
        setState(() {
          _selectedEndTime = picked;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: Text('Please select the start time first'),
          // duration: Duration(seconds: 2),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dateAndLocation =
        Provider.of<CreateEventProvider>(context).dateAndLocation;
    if (dateAndLocation != null) {
      _selectedDate = dateAndLocation.date;
      _selectedStartTime = dateAndLocation.startTime;
      _selectedEndTime = dateAndLocation.endTime;
      _selectedLocationOption = dateAndLocation.eventLocationType;
      _locationDescriptionController.text = dateAndLocation.location;
    } else {
      debugPrint('something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final pageControllerProvider = Provider.of<PageControllerProvider>(context);
    return Consumer2<CreateEventProvider, PageControllerProvider>(
        builder: (context, createEventProvider, pageControllerProvider, _) {
      return FormLayout(
          formKey: _dateAndLocationFormKey,
          unfocus: FocusScope.of(context).unfocus,
          formFields: [
            _buildEventDateLayout(context),
            _buildEventTimeLayout(context),
            _buildEventLocationLayout(context),
          ],
          onPressedAction: (_dateAndLocationFormKey.currentState != null &&
                  _selectedDate != null &&
                  _selectedStartTime != null &&
                  _selectedEndTime != null &&
                  _selectedLocationOption != null &&
                  _dateAndLocationFormKey.currentState!.validate())
              ? () {
                  createEventProvider.dateAndLocation =
                      EventDateAndLocationModel(
                          date: _selectedDate!,
                          startTime: _selectedStartTime!,
                          endTime: _selectedEndTime!,
                          eventLocationType: _selectedLocationOption!,
                          location: _locationDescriptionController.text);
                  pageControllerProvider.nextPage();
                }
              : null,
          actionButtonLabel: 'Next',
          hasPrevious: true);
    });
  }

  Column _buildEventLocationLayout(BuildContext context) {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Text(
          'Location',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        ...EventLocationType.values.map((option) {
          return Column(
            spacing: 4,
            children: [
              Theme(
                data:
                    Theme.of(context).copyWith(splashColor: Colors.transparent),
                child: RadioListTile<EventLocationType>(
                  title: Text(
                    option.label,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  activeColor: Colors.blueAccent,
                  value: option,
                  contentPadding: EdgeInsets.all(0),
                  groupValue: _selectedLocationOption,
                  onChanged: (EventLocationType? value) {
                    setState(() {
                      _selectedLocationOption = value;
                    });
                  },
                ),
              ),
              if (_selectedLocationOption == option)
                TextFormField(
                  // key: Key(option.label),
                  controller: _locationDescriptionController,
                  decoration: InputDecoration(
                    labelText: option.hint,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ${option.hint}';
                    }
                    return null;
                  },
                ),
            ],
          );
        }),
      ],
    );
  }

  Row _buildEventTimeLayout(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'From',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 145,
              child: OutlinedButton(
                style: buttonStyle,
                onPressed: () => _selectStartTime(context),
                child: _buildDateTimeFormat(
                  timeFormat(context, _selectedStartTime) ?? '--:--',
                  Icons.access_time_rounded,
                ),
              ),
            ),
          ],
        ),
        Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 145,
              child: OutlinedButton(
                style: buttonStyle,
                onPressed: () => _selectEndTime(context),
                child: _buildDateTimeFormat(
                  timeFormat(context, _selectedEndTime) ?? '--:--',
                  Icons.access_time_rounded,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _buildEventDateLayout(BuildContext context) {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 200,
          child: OutlinedButton(
            style: buttonStyle,
            onPressed: () => _selectDate(context),
            child: _buildDateTimeFormat(
              dateFormat(_selectedDate) ?? 'Event Date',
              Icons.calendar_month,
            ),
          ),
        ),
      ],
    );
  }

  Row _buildDateTimeFormat(String label, IconData iconData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          label,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Icon(
          iconData,
          size: 24,
          color: Colors.black,
        ),
      ],
    );
  }
}
