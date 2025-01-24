import 'package:fire_playground/features/auth/login.dart';
import 'package:fire_playground/features/auth/signup.dart';
import 'package:fire_playground/features/create_event/create_event.dart';
import 'package:fire_playground/features/create_event/providers/create_event_provider.dart';
import 'package:fire_playground/features/create_event/providers/page_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        // await user.sendEmailVerification();
        debugPrint('User is signed in!');
        debugPrint(user.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PageControllerProvider()),
          ChangeNotifierProvider(create: (_) => CreateEventProvider()),
        ],
        child: MaterialApp(
          restorationScopeId: 'app',
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: CreateEvent(),
          routes: {
            "signup": (context) => SignUp(),
            "login": (context) => Login(),
            "CreateEvent": (context) => CreateEvent(),
          },
        ));
  }
}
