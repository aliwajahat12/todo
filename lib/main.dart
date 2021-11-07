import 'package:flutter/material.dart';
import 'package:todo/Models/Task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController taskController;
  int id = 0;
  List<Todo> task = [];

  @override
  void initState() {
    taskController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  void addTaskToList() {
    setState(() {
      final todoTask = taskController.text;
      taskController.clear();
      task.add(Todo(id: id, task: todoTask));
      id++;
    });
  }

  void deleteTask(int id) {
    setState(() {
      task.removeWhere((element) => element.id == id);
    });
  }

  Widget taskDisplay(Todo todoString) {
    return ListTile(
      leading: const Icon(Icons.ac_unit),
      title: Text(todoString.task),
      trailing: IconButton(
          onPressed: () => deleteTask(todoString.id),
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: taskController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: addTaskToList, icon: const Icon(Icons.add))
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: task.length,
                  itemBuilder: ((context, i) {
                    return taskDisplay(task[i]);
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
