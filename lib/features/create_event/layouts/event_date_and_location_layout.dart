import 'package:fire_playground/features/create_event/providers/page_controller_provider.dart';
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
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageControllerProvider = Provider.of<PageControllerProvider>(context);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: [
            OutlinedButton(
                onPressed: () => _selectDate(context),
                child: Text(_selectedDate?.toIso8601String() ?? 'Event Date'))
          ],
        ),
      ),
    );
  }
}
