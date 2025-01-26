import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_playground/features/create_event/models/event_speaker_model.dart';
import 'package:fire_playground/features/create_event/providers/create_event_provider.dart';
import 'package:fire_playground/features/create_event/providers/page_controller_provider.dart';
import 'package:fire_playground/features/create_event/shared_layout/app_text_form_field.dart';
import 'package:fire_playground/features/create_event/shared_layout/form_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventSpeakersLayout extends StatefulWidget {
  const EventSpeakersLayout({super.key});

  @override
  EventSpeakersLayoutState createState() => EventSpeakersLayoutState();
}

class EventSpeakersLayoutState extends State<EventSpeakersLayout> {
  final _speakersFormKey = GlobalKey<FormState>();

  final List<EventSpeakerModel> _speakers = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  int? _editingIndex;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final speakers = Provider.of<CreateEventProvider>(context).speakers;
    if (speakers.isNotEmpty) {
      setState(() {
        _speakers.addAll(speakers);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CreateEventProvider, PageControllerProvider>(
        builder: (context, createEventProvider, pageControllerProvider, _) {
      return FormLayout(
        formKey: _speakersFormKey,
        unfocus: FocusScope.of(context).unfocus,
        onPressedAction: _speakers.isNotEmpty
            ? () {
                createEventProvider.speakers = _speakers;
                if (createEventProvider.isCreateEventModelCreated()) {
                  final db = FirebaseFirestore.instance;

                  db
                      .collection("events")
                      .add(createEventProvider.toFirestore())
                      .then((DocumentReference doc) => debugPrint(
                          'DocumentSnapshot added with ID: ${doc.id}'));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Please fill in all the required fields',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.redAccent,
                  ));
                }
              }
            : null,
        hasPrevious: true,
        actionButtonLabel: 'Create Event',
        formFields: [
          AppTextFormField(
            controller: _nameController,
            title: 'Speaker Name',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          AppTextFormField(
            controller: _titleController,
            title: 'Bio',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
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
      );
    });
  }

  // Save or update a speaker
  void _saveSpeaker() {
    final name = _nameController.text.trim();
    final title = _titleController.text.trim();

    if (name.isNotEmpty && title.isNotEmpty) {
      setState(() {
        if (_editingIndex != null) {
          _speakers[_editingIndex!] = EventSpeakerModel(name: name, bio: title);
          _editingIndex = null;
        } else {
          _speakers.add(EventSpeakerModel(name: name, bio: title));
        }
        FocusScope.of(context).unfocus();
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
                    title: Text(speaker.name),
                    subtitle: Text(speaker.bio),
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
      _nameController.text = _speakers[index].name;
      _titleController.text = _speakers[index].bio;
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
