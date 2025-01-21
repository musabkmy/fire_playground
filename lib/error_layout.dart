import 'package:fire_playground/app.dart';
import 'package:flutter/material.dart';

class ErrorLayout extends StatefulWidget {
  final FlutterErrorDetails errorDetails;

  const ErrorLayout({super.key, required this.errorDetails});

  @override
  State<ErrorLayout> createState() => _ErrorLayoutState();
}

class _ErrorLayoutState extends State<ErrorLayout> {
  bool _hasError = true;

  void _retry() {
    setState(() {
      _hasError = false; // Reset the error state
    });
  }

  @override
  Widget build(BuildContext context) {
    return _hasError
        ? MaterialApp(
            home: Scaffold(
              appBar: AppBar(title: Text('Error')),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong!',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    SizedBox(height: 20),
                    Text(
                      widget.errorDetails.exceptionAsString(),
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _hasError = false;
                        });
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          )
        : MyApp();
  }
}
