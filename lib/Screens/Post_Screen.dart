import 'package:firebase1/Utiles/message_Utiles.dart';
import 'package:firebase1/constant/RoundedButton.dart';
import 'package:firebase1/constant/textformfeild.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController postContoller = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref('Post');

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 182, 92, 122),
        title: const Text('POST SCREEN'),
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
                  databaseRef
                      .child(DateTime.now().millisecond.toString())
                      .child('comments')
                      .set({
                    'Id': DateTime.now().millisecond.toString(),
                    'title': postContoller.text.toString()
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    Uitles().meesage('Post added');
                    Navigator.pop(context);
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
