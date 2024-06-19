import 'package:flutter/material.dart';

void delete_task(index, context, tasks, StateSetter setState) {
  showDialog(
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
              Navigator.of(context).pop();
            },
            child: const Text(
              'No',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                tasks.removeAt(index);
                Navigator.of(context).pop();
              });
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
