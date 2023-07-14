import 'package:flutter/material.dart';

class descriptionBar extends StatelessWidget {
  final String title, description;
  const descriptionBar(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Description"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        height: MediaQuery.sizeOf(context).height * 0.5,
        width: MediaQuery.sizeOf(context).width,
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Title :",
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 25),
                ),
                const Divider(
                  thickness: 3,
                ),
                const Text(
                  "Description :",
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
