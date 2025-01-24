// ignore_for_file: public_member_api_docs, sort_constructors_first
class EventSpeakerModel {
  final String name;
  final String bio;

  EventSpeakerModel({required this.name, required this.bio});

  EventSpeakerModel copyWith({
    String? name,
    String? bio,
  }) {
    return EventSpeakerModel(
      name: name ?? this.name,
      bio: bio ?? this.bio,
    );
  }

  @override
  String toString() => 'EventSpeakerModel(name: $name, bio: $bio)';
}
