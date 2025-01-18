enum EventLocationType {
  virtual('Virtual', 'Meeting address'),
  physical('Physical', 'Link to the meeting');

  final String label;
  final String hint;

  const EventLocationType(this.label, this.hint);
}
