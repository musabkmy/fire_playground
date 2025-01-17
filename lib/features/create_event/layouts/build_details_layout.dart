import 'package:fire_playground/features/create_event/models/event_category.dart';
import 'package:flutter/material.dart';

class BuildDetailsLayout extends StatefulWidget {
  const BuildDetailsLayout({
    super.key,
  });

  @override
  State<BuildDetailsLayout> createState() => _BuildDetailsLayoutState();
}

class _BuildDetailsLayoutState extends State<BuildDetailsLayout> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  EventCategory? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: [
            _buildTitleForm(),
            _buildCategoryForm(),
            _buildDescriptionForm(),
            SizedBox(height: 24),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: MaterialButton(
                color: Colors.blueAccent,
                height: 48,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form submitted successfully')),
                    );
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
          'Select a category',
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

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.controller,
    required this.title,
    this.labelText,
    this.validator,
    this.textInputType = TextInputType.text,
  });

  final TextEditingController controller;
  final String title;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextFormField(
          key: Key(title),
          controller: controller,
          keyboardType: textInputType,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
