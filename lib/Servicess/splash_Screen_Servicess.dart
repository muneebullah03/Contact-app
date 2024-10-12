import 'dart:async';

import 'package:firebase1/Screens/Home_Screen.dart';
import 'package:firebase1/Screens/login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreenServicess {
  void Islog(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User = auth.currentUser;
    if (User != null) {
      Timer(
        const Duration(seconds: 3),
        () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
      );
    } else {
      Timer(
        const Duration(seconds: 3),
        () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
      );
    }
  }
}
