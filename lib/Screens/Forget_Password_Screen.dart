import 'package:firebase1/Utiles/message_Utiles.dart';
import 'package:firebase1/constant/RoundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 182, 92, 122),
        title: const Text("Forget Password"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10))),
              )),
          const SizedBox(height: 50),
          RoundedButton(
              title: "Forget",
              ontap: () {
                auth
                    .sendPasswordResetEmail(
                        email: passwordController.text.toString())
                    .then((value) {
                  Navigator.pop(context);
                  Uitles().meesage(
                      'We send you link via email pleas check your email and reset passsword');
                }).onError((error, stackTrace) {
                  Uitles().meesage(error.toString());
                });
              })
        ],
      ),
    );
  }
}
