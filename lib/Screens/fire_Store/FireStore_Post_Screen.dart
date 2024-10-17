import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/Utiles/message_Utiles.dart';
import 'package:firebase1/constant/RoundedButton.dart';
import 'package:firebase1/constant/textformfeild.dart';
import 'package:flutter/material.dart';

class FirestorePostScreen extends StatefulWidget {
  const FirestorePostScreen({super.key});

  @override
  State<FirestorePostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<FirestorePostScreen> {
  TextEditingController postContoller = TextEditingController();
  final fireStoreRef = FirebaseFirestore.instance.collection('users');

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 182, 92, 122),
        title: const Text('FIRESTORE SCREEN'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: CustomTextFormField(
              mixline: 3,
              controller: postContoller,
              labelText: 'Whats in your Mind!',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RoundedButton(
                loading: loading,
                title: 'Post',
                ontap: () {
                  setState(() {
                    loading = true;
                  });
                  final id = DateTime.now().microsecondsSinceEpoch.toString();
                  fireStoreRef.doc(id).set({
                    'title': postContoller.text.toString(),
                    'id': id
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    Navigator.pop(context);
                    Uitles().meesage('Post added');
                  }).onError(
                    (error, stackTrace) {
                      setState(() {
                        loading = false;
                      });
                      Uitles().meesage(error.toString());
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
