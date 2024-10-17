import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/Screens/fire_Store/FireStore_Post_Screen.dart';
import 'package:firebase1/Screens/login_Screen.dart';
import 'package:firebase1/Utiles/message_Utiles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  State<FirestoreListScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<FirestoreListScreen> {
  TextEditingController editingController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final fireStoreRef =
      FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
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
      body: Column(
        children: [
          const SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
              stream: fireStoreRef,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error Occure');
                } else {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final id = snapshot.data!.docs[index].id;
                            final title =
                                snapshot.data!.docs[index]['title'].toString();
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                child: ListTile(
                                  title: Text(title),
                                  subtitle: Text(id),
                                  trailing: PopupMenuButton(
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                                value: 1,
                                                onTap: () {
                                                  showMyDialog(title, id);
                                                },
                                                child: const ListTile(
                                                  leading: Icon(Icons.edit),
                                                  subtitle: Text('Edit'),
                                                )),
                                            PopupMenuItem(
                                                value: 2,
                                                onTap: () {
                                                  ref
                                                      .doc(id)
                                                      .delete()
                                                      .then((value) {
                                                    Uitles().meesage(
                                                        'Post Deleted');
                                                  }).onError(
                                                    (error, stackTrace) {
                                                      Uitles().meesage(
                                                          error.toString());
                                                    },
                                                  );
                                                },
                                                child: const ListTile(
                                                  leading: Icon(Icons.delete),
                                                  subtitle: Text('Delete'),
                                                ))
                                          ]),
                                ),
                              ),
                            );
                          }));
                }
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FirestorePostScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editingController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Text('Cancel')),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref
                        .doc(id)
                        .set({'title': editingController.text.toString()}).then(
                            (value) {
                      Uitles().meesage('Post Updated');
                    }).onError(
                      (error, stackTrace) {
                        Uitles().meesage(error.toString());
                      },
                    );
                  },
                  icon: const Text('update'))
            ],
            content: TextFormField(
              controller: editingController,
            ),
          );
        });
  }
}
