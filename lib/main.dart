import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_playground/app.dart';
import 'package:fire_playground/error_layout.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //handle errors
  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
    runApp(ErrorLayout(errorDetails: details));
  };

  // Handle uncaught exceptions (e.g., from async code)
  PlatformDispatcher.instance.onError = (error, stack) {
    // Log the error or show a dialog
    debugPrint("Uncaught exception: $error\nStack trace: $stack");
    // Navigate to an error screen or show a dialog
    runApp(ErrorLayout(
        errorDetails: FlutterErrorDetails(exception: error, stack: stack)));
    return true; // Prevent the app from crashing
  };

  // Isolate.spawn(entryPoint, message)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // demoProjectId: "demo-project-id",
  );
  final db = FirebaseFirestore.instance;

  // final event = <String, dynamic>{
  //   "title": "Problem Solving",
  //   "category": "Workshop",
  //   "Description":
  //       "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum"
  // };

  // db.collection("events").add(event).then((DocumentReference doc) =>
  //     debugPrint('DocumentSnapshot added with ID: ${doc.id}'));

  try {
    await db.collection("events").get().then((event) {
      for (var doc in event.docs) {
        debugPrint("${doc.id} => ${doc.data()}");
      }
    });
  } catch (e) {
    debugPrint(e.toString());
  }

  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // await FirebaseAnalytics.instance.logBeginCheckout(
  //     value: 10.0,
  //     currency: 'USD',
  //     items: [
  //       AnalyticsEventItem(itemName: 'Socks', itemId: 'xjw73ndnw', price: 10.0),
  //     ],
  //     coupon: '10PERCENTOFF');
  runApp(MyApp());
}
