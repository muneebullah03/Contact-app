import 'package:firebase1/Screens/login_Screen.dart';
import 'package:firebase1/Utiles/message_Utiles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 182, 92, 122),
        title: const Text('Home Screen'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                }).onError(
                  (error, stackTrace) {
                    Uitles().meesage(error.toString());
                  },
                );
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
    );
  }
}
