import 'package:farm_track/screens/home_screen.dart';
import 'package:farm_track/screens/subscreens/expense_overview_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // Add this import
import 'package:farm_track/screens/Authentications/login_screen.dart';

void main() {
  if (kIsWeb) {
    Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD98wxOX-D2WzZF7GMur_nbXAvx5LKkgRE",
            authDomain: "farmtrack-f0bd0.firebaseapp.com",
            projectId: "farmtrack-f0bd0",
            storageBucket: "farmtrack-f0bd0.appspot.com",
            messagingSenderId: "320354338303",
            appId: "1:320354338303:web:ef36fa6344f51effd113ca",
            measurementId: "G-ZWNHBTGX96"));
  } else {
    Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 221, 240, 218)),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
