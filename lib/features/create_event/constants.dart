import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String? dateFormat(DateTime? dateTime) => dateTime == null
    ? null
    : '${DateFormat(DateFormat.ABBR_MONTH).format(dateTime)} ${dateTime.day}, ${dateTime.year}';

String? timeFormat(BuildContext context, TimeOfDay? time) =>
    time?.format(context);

ButtonStyle buttonStyle = OutlinedButton.styleFrom(
  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);
