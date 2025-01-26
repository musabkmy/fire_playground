import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EventSpeakerModel {
  final String name;
  final String bio;

  EventSpeakerModel({required this.name, required this.bio});

  @override
  String toString() => 'EventSpeakerModel(name: $name, bio: $bio)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'bio': bio,
    };
  }

  factory EventSpeakerModel.fromMap(Map<String, dynamic> map) {
    return EventSpeakerModel(
      name: map['name'] as String,
      bio: map['bio'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventSpeakerModel.fromJson(String source) =>
      EventSpeakerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
