import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_playground/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
