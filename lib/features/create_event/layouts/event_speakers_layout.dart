import 'package:fire_playground/features/create_event/shared_layout/app_text_form_field.dart';
import 'package:flutter/material.dart';

class EventSpeakersLayout extends StatefulWidget {
  const EventSpeakersLayout({super.key});

  @override
  EventSpeakersLayoutState createState() => EventSpeakersLayoutState();
}

class EventSpeakersLayoutState extends State<EventSpeakersLayout> {
  final List<Map<String, String>> _speakers = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  int? _editingIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        spacing: 16,
        children: [
          AppTextFormField(
            controller: _nameController,
            title: 'Speaker Name',
          ),
          AppTextFormField(
            controller: _titleController,
            title: 'Bio',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _speakers.isEmpty
                  ? SizedBox()
                  : MaterialButton(
                      onPressed: _showBottomSheet,
                      child: Text(
                        '${_speakers.length} Speaker(s)',
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
              MaterialButton(
                onPressed: _saveSpeaker,
                child: Text(
                  _editingIndex == null ? 'Add Speaker' : 'Update Speaker',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Save or update a speaker
  void _saveSpeaker() {
    final name = _nameController.text.trim();
    final title = _titleController.text.trim();

    if (name.isNotEmpty && title.isNotEmpty) {
      setState(() {
        if (_editingIndex != null) {
          // Update existing speaker
          _speakers[_editingIndex!] = {'name': name, 'title': title};
          _editingIndex = null; // Reset editing index
        } else {
          // Add new speaker
          _speakers.add({'name': name, 'title': title});
        }
        // Clear text fields
        _nameController.clear();
        _titleController.clear();
      });
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.sizeOf(context).height * .5,
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red[10],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: _speakers.isEmpty
            ? Center(child: Text('No speakers added yet'))
            : ListView.builder(
                itemCount: _speakers.length,
                itemBuilder: (context, index) {
                  final speaker = _speakers[index];
                  return ListTile(
                    title: Text(speaker['name']!),
                    subtitle: Text(speaker['title']!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Edit button
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editSpeaker(index);
                            Navigator.pop(context);
                          },
                        ),
                        // Delete button
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteSpeaker(index);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  // Edit a speaker
  void _editSpeaker(int index) {
    setState(() {
      _editingIndex = index;
      _nameController.text = _speakers[index]['name']!;
      _titleController.text = _speakers[index]['title']!;
    });
  }

  // Delete a speaker
  void _deleteSpeaker(int index) {
    setState(() {
      _speakers.removeAt(index);
      if (_editingIndex == index) {
        _editingIndex = null;
        _nameController.clear();
        _titleController.clear();
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    super.dispose();
  }
}
