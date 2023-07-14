import 'package:flutter/material.dart';
import 'package:todoapp/auth/authscreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text("To-Do"),
      centerTitle: true,
     
    ),
     body: const AuthScreen());
  }
}
