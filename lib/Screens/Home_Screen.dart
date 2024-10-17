import 'package:firebase1/Screens/Post_Screen.dart';
import 'package:firebase1/Screens/login_Screen.dart';
import 'package:firebase1/Utiles/message_Utiles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController editingController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
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
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10))),
                onChanged: (value) {
                  setState(() {});
                },
              )),
          const SizedBox(height: 20),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animated, index) {
                  final title = snapshot.child('title').value.toString();
                  final id = snapshot.child('id').value.toString();
                  if (searchController.text.isEmpty) {
                    return Card(
                      child: ListTile(
                        title: Text(title),
                        subtitle: Text(id),
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
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
                                  ref.child(id).remove();
                                },
                                child: const ListTile(
                                  leading: Icon(Icons.delete),
                                  subtitle: Text('Delete'),
                                ))
                          ],
                        ),
                      ),
                    );
                  } else if (title.toLowerCase().contains(
                      searchController.text.toLowerCase().toString())) {
                    return Card(
                      child: ListTile(
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          )
          // Expanded(
          //   child: StreamBuilder(
          //       stream: ref.onValue,
          //       builder: (context, AsyncSnapshot<DatabaseEvent> snapshoot) {
          //         if (!snapshoot.hasData ||
          //             snapshoot.data!.snapshot.value == null) {
          //           return const Center(child: CircularProgressIndicator());
          //         } else {
          //           Map<dynamic, dynamic> map =
          //               snapshoot.data!.snapshot.value as dynamic;
          //           List<dynamic> list = [];
          //           list.clear();
          //           list = map.values.toList();
          //           return ListView.builder(
          //               itemCount: snapshoot.data!.snapshot.children.length,
          //               itemBuilder: (context, index) {
          //                 String title = list[index]['title'].toString();
          //                 String id = list[index]['id'].toString();
          //                 return Padding(
          //                   padding: const EdgeInsets.symmetric(horizontal: 10),
          //                   child: Card(
          //                     child: ListTile(
          //                       title: Text(title),
          //                       subtitle: Text(id),
          //                     ),
          //                   ),
          //                 );
          //               });
          //         }
          //       }),
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PostScreen()));
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
                    ref.child(id).update({
                      'title': editingController.text.toString()
                    }).then((value) {
                      Uitles().meesage('Post Updated');
                    }).onError(
                      (error, stackTrace) {
                        Uitles().meesage(error.toString());
                      },
                    );
                  },
                  icon: const Text('update'))
            ],
            content: Container(
              child: TextFormField(
                controller: editingController,
              ),
            ),
          );
        });
  }
}
