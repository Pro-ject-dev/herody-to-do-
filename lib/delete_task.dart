import 'package:flutter/material.dart';

var status = false;
Future delete_task(index, context, tasks, StateSetter setState) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Delete Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text("Are you sure to delete this task ?")],
        ),
        actions: [
          TextButton(
            onPressed: () {
              status = false;
              Navigator.of(context).pop();
            },
            child: const Text(
              'No',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              status = true;
              Navigator.of(context).pop();
            },
            child: Text(
              'Yes',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
