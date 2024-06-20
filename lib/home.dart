import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx/add_task.dart';
import 'package:getx/delete_task.dart';
import 'package:getx/edit_task.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> task = [];
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    initializeStorage();
  }

  Future<void> initializeStorage() async {
    try {
      await GetStorage.init();
      setState(() {
        task = GetStorage().read<List<Map<String, dynamic>>>('task') ?? [];
      });
    } catch (error) {
      setState(() {
        task = [];
      });
    }
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
        child: task.isEmpty
            ? defaultbg()
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: task.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color.fromARGB(14, 0, 0, 0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    child: ListTile(
                      title: Text(
                        task[index]['title'],
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          decoration: task[index]['iscompleted']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(
                        task[index]['description'],
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          decoration: task[index]['iscompleted']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            activeColor: Colors.black,
                            value: task[index]['iscompleted'] ?? false,
                            onChanged: (value) {
                              try {
                                setState(() {
                                  task[index]['iscompleted'] = value;
                                  GetStorage().write('task', task);
                                });
                              } catch (error) {
                                print('Error updating task status: $error');
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            onPressed: () {
                              try {
                                edit_task(
                                    task[index]['title'],
                                    task[index]['description'],
                                    index,
                                    context,
                                    task,
                                    setState);
                              } catch (error) {
                                print('Error editing task: $error');
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete,
                                color: Color.fromARGB(179, 0, 0, 0)),
                            onPressed: () {
                              try {
                                setState(() {
                                  delete_task(index, context, task, setState);
                                  GetStorage().write('task', task);
                                });
                              } catch (error) {
                                print('Error deleting task: $error');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
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
          try {
            add_task(context, isCompleted, task, setState);
          } catch (error) {
            print('Error adding task: $error');
          }
        },
      ),
    );
  }
}
