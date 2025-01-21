import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.controller,
    required this.title,
    this.labelText,
    this.validator,
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String title;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final int? maxLines;

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
          maxLines: maxLines,
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
