import 'package:firebase1/Screens/Home_Screen.dart';
import 'package:firebase1/Screens/login_Screen.dart';
import 'package:firebase1/Utiles/message_Utiles.dart';
import 'package:firebase1/constant/RoundedButton.dart';
import 'package:firebase1/constant/textformfeild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool laoding = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() {
    setState(() {
      laoding = true;
    });
    auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        laoding = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }).onError(
      (error, stackTrace) {
        setState(() {
          laoding = false;
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
          title: const Text('SignUp Screen'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 182, 92, 122),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Column(children: [
                const SizedBox(height: 90),
                const Center(
                    child: Text(
                  'SIGNUP SCREEN',
                  style: TextStyle(fontSize: 30),
                )),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextFormField(
                    prefixIcon: Icons.email,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextFormField(
                    prefixIcon: Icons.password,
                    controller: passwordController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Password',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                RoundedButton(
                  loading: laoding,
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      signUp();
                    }
                  },
                  title: 'SignUp',
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ));
  }
}
