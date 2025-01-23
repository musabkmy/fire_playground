import 'package:fire_playground/features/create_event/constants.dart';
import 'package:fire_playground/features/create_event/models/event_location_type.dart';
import 'package:fire_playground/features/create_event/shared_layout/app_text_form_field.dart';
import 'package:flutter/material.dart';

class EventDateAndLocationLayout extends StatefulWidget {
  static const String id = 'EventDateAndLocationLayout';
  const EventDateAndLocationLayout({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  State<EventDateAndLocationLayout> createState() =>
      _EventDateAndLocationLayoutState();
}

class _EventDateAndLocationLayoutState
    extends State<EventDateAndLocationLayout> {
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
  Widget build(BuildContext context) {
    // final pageControllerProvider = Provider.of<PageControllerProvider>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
          ),
          Row(
            spacing: 16,
            children: [
              Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
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
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
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
          ),
          Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Text(
                'Location',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              ...EventLocationType.values.map((option) {
                return Column(
                  spacing: 4,
                  children: [
                    Theme(
                      data: Theme.of(context)
                          .copyWith(splashColor: Colors.transparent),
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
                            _locationDescriptionController.text = '';
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
                      ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
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
