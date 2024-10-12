import 'package:firebase1/Servicess/splash_Screen_Servicess.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenServicess splashScreenServicess = SplashScreenServicess();
  @override
  void initState() {
    super.initState();
    splashScreenServicess.Islog(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Center(
        child: Text(
          'Firebase Project',
          style: TextStyle(fontSize: 30),
        ),
      )),
    );
  }
}
