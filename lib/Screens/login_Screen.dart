import 'package:firebase1/Screens/Forget_Password_Screen.dart';
import 'package:firebase1/Screens/Home_Screen.dart';
import 'package:firebase1/Screens/SignUp_Screen.dart';
import 'package:firebase1/Screens/verification/Phone_Number_Screen.dart';
import 'package:firebase1/Utiles/message_Utiles.dart';
import 'package:firebase1/constant/RoundedButton.dart';
import 'package:firebase1/constant/textformfeild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  void login() {
    setState(() {
      loading = true;
    });
    auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      Uitles().meesage(value.user!.email.toString());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }).onError(
      (error, stackTrace) {
        setState(() {
          loading = false;
        });
        Uitles().meesage(error.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 177, 181, 184),
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 182, 92, 122),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: SafeArea(
          child: Form(
            key: formKey, // Form key to validate the fields
            child: Column(
              children: [
                const SizedBox(height: 90),
                const Center(
                  child: Text(
                    'LOGIN SCREEN',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextFormField(
                    prefixIcon: Icons.email,
                    controller:
                        emailController, // Use the correct emailController here
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgetPasswordScreen()));
                      },
                      child: const Text('Forgot Password!')),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextFormField(
                    prefixIcon: Icons.lock,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true, // Secure the password field
                    labelText: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 100),
                RoundedButton(
                  loading: loading,
                  ontap: () {
                    // Validate the form before submission
                    if (formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  title: 'Login',
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()),
                        );
                      },
                      child: const Text(
                        'Sign Up!',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                RoundedButton(
                    loading: loading,
                    title: 'Login with Phone',
                    ontap: () {
                      setState(() {
                        loading = true;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PhoneNumberScreen()));
                      setState(() {
                        loading = false;
                      });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
