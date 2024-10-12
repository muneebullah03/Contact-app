import 'package:firebase1/Screens/Home_Screen.dart';
import 'package:firebase1/Utiles/message_Utiles.dart';
import 'package:firebase1/constant/RoundedButton.dart';
import 'package:firebase1/constant/textformfeild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  final String verificationId;

  const VerificationScreen({super.key, required this.verificationId});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController verificationController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextFormField(
                prefixIcon: Icons.phone_android,
                controller: verificationController,
                keyboardType: TextInputType.number, // Use number for OTP input
                obscureText: false, // Do not obscure OTP field
                labelText: 'Enter Verification Code', // Update the label text
              ),
            ),
            const SizedBox(height: 30),
            RoundedButton(
              loading: loading, // Pass loading state to button
              title: 'Verify',
              ontap: () async {
                String otp = verificationController.text.trim();

                // Validate the OTP field
                if (otp.isEmpty || otp.length < 6) {
                  Uitles().meesage('Please enter a valid 6-digit OTP');
                  return;
                }

                setState(() {
                  loading =
                      true; // Set loading to true when verification starts
                });

                final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: otp,
                );

                try {
                  // Sign in using the provided credential
                  await auth.signInWithCredential(credential);

                  setState(() {
                    loading = false; // Stop loading after successful sign-in
                  });

                  // Navigate to home screen on successful sign-in
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                } catch (e) {
                  setState(() {
                    loading = false; // Stop loading if an error occurs
                  });

                  // Provide a detailed error message to the user
                  Uitles().meesage('Verification failed: ${e.toString()}');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
