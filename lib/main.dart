import 'package:flutter/material.dart';  // Add this import
import 'package:farm_track/screens/Authentications/login_screen.dart';


void main() {
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
      home: const LoginScreen(),
    );
  }
}
