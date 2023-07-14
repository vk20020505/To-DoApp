import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/Screens/description.dart';
import './addTodo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class taskScreen extends StatefulWidget {
  const taskScreen({super.key});

  @override
  State<taskScreen> createState() => _taskScreenState();
}

class _taskScreenState extends State<taskScreen> {
  String userId = '';
  List<String> todoList = [];
  getUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    String uid = user!.uid;
    setState(() {
      userId = uid;
    });
  }

  @override
  void initState() {
    getUid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("TODO"), actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ]),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('tasks')
                .doc(userId)
                .collection('mytasks')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final data = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var date = (data[index]['TimeStamp'] as Timestamp).toDate();
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => descriptionBar(
                                      title: data[index]['Title'],
                                      description: data[index]
                                          ['Description'])));
                        },
                        leading: Checkbox(
                            value: todoList.contains(data[index]['Time'])
                                ? true
                                : false,
                            onChanged: (bool? value) {
                              setState(() {
                                if (todoList.contains(data[index]['Time'])) {
                                  todoList.remove(data[index]['Time']);
                                } else {
                                  todoList.add(data[index]['Time']);
                                }
                              });
                            }),
                        title: Text(
                          data[index]['Title'],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(DateFormat.yMd().add_jm().format(date)),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline_outlined,
                            size: 30,
                          ),
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('tasks')
                                .doc(userId)
                                .collection('mytasks')
                                .doc(data[index]['Time'])
                                .delete();
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          child: const Icon(
            Icons.add,
            size: 35,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddTask()));
          },
        ));
  }
}
