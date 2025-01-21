class EventLocationType {
  EventLocationType._(this.label, this.hint);
  final String label;
  final String hint;

  static final _virtual = EventLocationType._('Virtual', 'Meeting address');
  static final _physical =
      EventLocationType._('Physical', 'Link to the meeting');

  static final values = [_virtual, _physical];
}
