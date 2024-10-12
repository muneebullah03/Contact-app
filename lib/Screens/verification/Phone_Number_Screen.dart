import 'package:firebase1/Screens/verification/Verification_Screen.dart';
import 'package:firebase1/Utiles/message_Utiles.dart';
import 'package:firebase1/constant/RoundedButton.dart';
import 'package:firebase1/constant/textformfeild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 182, 92, 122),
        title: const Text("PHONE NUMBER"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextFormField(
                prefixIcon: Icons.phone_android,
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                obscureText: false,
                labelText: 'Enter Phone Number',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: RoundedButton(
                loading: loading,
                title: 'Verify',
                ontap: () {
                  setState(() {
                    loading = true;
                  });
                  auth.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text,
                      verificationCompleted: (_) {
                        setState(() {
                          loading = false;
                        });
                      },
                      verificationFailed: (e) {
                        Uitles().meesage(e.toString());
                        setState(() {
                          loading = false;
                        });
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerificationScreen(
                                    verificationId: verificationId)));
                        setState(() {
                          loading = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (e) {
                        Uitles().meesage(e.toString());
                      });
                  setState(() {
                    loading = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
