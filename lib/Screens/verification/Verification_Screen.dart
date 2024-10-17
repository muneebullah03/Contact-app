import 'package:firebase1/Screens/Home_Screen.dart';
import 'package:firebase1/Utiles/message_Utiles.dart';
import 'package:firebase1/constant/RoundedButton.dart';
import 'package:firebase1/constant/textformfeild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CodeVerificationScreen extends StatefulWidget {
  String verificationId;
  CodeVerificationScreen({super.key, required this.verificationId});

  @override
  State<CodeVerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<CodeVerificationScreen> {
  // ignore: non_constant_identifier_names
  TextEditingController OTPVerificationController = TextEditingController();
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: CustomTextFormField(
              controller: OTPVerificationController,
              labelText: 'Enter 6 Digit OTP',
              prefixIcon: Icons.phone,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: RoundedButton(
                loading: loading,
                title: 'Verify',
                ontap: () async {
                  setState(() {
                    loading = true;
                  });
                  final cradential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: OTPVerificationController.text);
                  try {
                    await auth.signInWithCredential(cradential);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  } catch (e) {
                    setState(() {
                      loading = false;
                      Uitles().meesage(e.toString());
                    });
                  }
                }),
          )
        ],
      ),
    );
  }
}
