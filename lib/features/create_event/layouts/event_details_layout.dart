import 'package:fire_playground/features/create_event/models/event_category.dart';
import 'package:fire_playground/features/create_event/models/event_details_model.dart';
import 'package:fire_playground/features/create_event/providers/create_event_provider.dart';
import 'package:fire_playground/features/create_event/providers/page_controller_provider.dart';
import 'package:fire_playground/features/create_event/shared_layout/app_text_form_field.dart';
import 'package:fire_playground/features/create_event/shared_layout/form_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetailsLayout extends StatefulWidget {
  const EventDetailsLayout({super.key});

  @override
  State<EventDetailsLayout> createState() => _EventDetailsLayoutState();
}

class _EventDetailsLayoutState extends State<EventDetailsLayout> {
  final _detailsFormKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  EventCategory? _selectedItem;

  @override
  Widget build(BuildContext context) {
    // final pageControllerProvider = Provider.of<PageControllerProvider>(context);
    // final createEventProvider = Provider.of<CreateEventProvider>(context);
    return Consumer2<PageControllerProvider, CreateEventProvider>(
        builder: (context, pageControllerProvider, createEventProvider, _) {
      return FormLayout(
          formKey: _detailsFormKey,
          formFields: [
            _buildTitleForm(),
            _buildCategoryForm(),
            _buildDescriptionForm(),
          ],
          onPressedAction: (_detailsFormKey.currentState != null &&
                  _selectedItem != null &&
                  _detailsFormKey.currentState!.validate())
              ? () {
                  createEventProvider.eventDetails = EventDetailsModel(
                      title: _titleController.text,
                      eventCategory: _selectedItem!,
                      description: _descriptionController.text);
                  pageControllerProvider.nextPage();
                }
              : null,
          actionButtonLabel: 'Next',
          hasPrevious: false);
    });
  }

  Widget _buildTitleForm() {
    return AppTextFormField(
        controller: _titleController,
        title: 'Title',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Title';
          }
          return null;
        });
  }

  Widget _buildCategoryForm() {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        DropdownButtonFormField<EventCategory>(
          items: EventCategory.values
              .map((item) =>
                  DropdownMenuItem(value: item, child: Text(item.name)))
              .toList(),
          decoration: InputDecoration(
            hintText: 'Select a category',
            border: OutlineInputBorder(),
          ),
          value: _selectedItem,
          validator: (value) {
            if (value == null) {
              return 'Please select a category';
            }
            return null;
          },
          onChanged: (EventCategory? newValue) {
            setState(() {
              _selectedItem = newValue;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDescriptionForm() {
    return AppTextFormField(
      controller: _descriptionController,
      title: 'Description',
      textInputType: TextInputType.multiline,
      maxLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter description';
        } else if (value.length < 20) {
          return 'Give more info';
        } else if (value.length > 90) {
          return 'You may need to be more concise';
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
