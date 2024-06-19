import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:getx/add_task.dart';
import 'package:getx/delete_task.dart';
import 'package:getx/edit_task.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<Map<String, dynamic>> tasks = [];
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    GetStorage.init();
    tasks = GetStorage().read<List<Map<String, dynamic>>>('task') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("To-do Application"),
        leading: Icon(Icons.note_alt_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            if (tasks.length == 0) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(152, 0, 0, 0)),
                  borderRadius: BorderRadius.circular(7),
                  color: Color.fromARGB(19, 0, 0, 0),
                ),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                child: ListTile(
                  title: Text(
                    tasks[index]['title'],
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      decoration: tasks[index]['iscompleted']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(
                    tasks[index]['description'],
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      decoration: tasks[index]['iscompleted']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        activeColor: Colors.black,
                        value: tasks[index]['iscompleted'] ?? false,
                        onChanged: (value) {
                          setState(() {
                            tasks[index]['iscompleted'] = value;
                            GetStorage().write('task', tasks);
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        onPressed: () {
                          edit_task(
                              tasks[index]['title'],
                              tasks[index]['description'],
                              index,
                              context,
                              tasks,
                              setState);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete,
                            color: Color.fromARGB(179, 0, 0, 0)),
                        onPressed: () {
                          setState(() {
                            delete_task(index, context, tasks, setState);
                            GetStorage().write('task', tasks);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              Center(child: Lottie.asset('./assets/bg.json'));
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {
          add_task(context, isCompleted, tasks, setState);
        },
      ),
    );
  }
}
