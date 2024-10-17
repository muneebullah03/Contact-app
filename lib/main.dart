import 'package:firebase1/Screens/Splash_Screen.dart'; // Ensure this file exists and is correct
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter binding is initialized
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyDe0tGLPH_NcphbnHTLTJTlTZ992vlMeJE',
        appId: "1:143222569764:web:a11a7bc7e7cecda3a051b1",
        messagingSenderId: "143222569764",
        projectId: 'project4-80304'),
  ); // Initialize Firebase
  runApp(const MyApp()); // Run your app
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner
      home: SplashScreen(), // Set SplashScreen as home
    );
  }
}
