import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void add_task(BuildContext context, bool isCompleted,
    List<Map<String, dynamic>> tasks, StateSetter setState) {
  String title = '';
  String description = '';
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add New Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              cursorColor: Colors.grey,
              onChanged: (value) {
                title = value;
              },
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 135, 135, 135)),
                  labelText: 'Title'),
            ),
            TextField(
              cursorColor: Colors.grey,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 135, 135, 135)),
                  labelText: 'Description (optional)'),
              onChanged: (value) {
                description = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              if (title.isNotEmpty) {
                Map<String, dynamic> newTask = {
                  'title': title,
                  'description': description,
                  'iscompleted': isCompleted,
                };

                setState(() {
                  tasks.add(newTask);
                  GetStorage().write('task', tasks);
                });

                Navigator.of(context).pop();
              }
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}

defaultbg() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
          height: 100,
          width: 100,
          child: Lottie.asset("./assets/bg.json", fit: BoxFit.cover)),
      Text("No tasks available", style: GoogleFonts.poppins(fontSize: 18)),
    ],
  ));
}
