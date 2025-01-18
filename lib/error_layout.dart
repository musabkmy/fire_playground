import 'package:flutter/material.dart';

class ErrorLayout extends StatelessWidget {
  const ErrorLayout({super.key, required this.errorDetails});
  final FlutterErrorDetails errorDetails;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorDetails.exceptionAsString(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
