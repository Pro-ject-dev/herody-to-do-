import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void edit_task(
    title, description, index, context, tasks, StateSetter setState) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add New Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              cursorColor: Colors.grey,
              initialValue: title,
              onChanged: (value) {
                title = value;
              },
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 135, 135, 135)),
                  labelText: 'Title'),
            ),
            TextFormField(
              cursorColor: Colors.grey,
              initialValue: description,
              onChanged: (value) {
                description = value;
              },
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 135, 135, 135)),
                  labelText: 'Description (optional)'),
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
                tasks[index]['title'] = title;
                tasks[index]['description'] = description;
                setState(() {
                  GetStorage().write('task', tasks);
                });

                Navigator.of(context).pop();
              }
            },
            child: Text(
              'Edit',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
