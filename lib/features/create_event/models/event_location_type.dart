class EventLocationType {
  EventLocationType._(this.label, this.hint);
  final String label;
  final String hint;

  static final _physical = EventLocationType._('Physical', 'Meeting address');
  static final _virtual = EventLocationType._('Virtual', 'Link to the meeting');

  static final values = [_physical, _virtual];
}
