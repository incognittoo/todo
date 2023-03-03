import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List todoList = [];
  late String _userNote;

  @override
  void initState() {
    super.initState();

    todoList.addAll(
        ['Записать курс', 'Выучить Flutter', 'Build ToDo List Application']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 63, 204),
        title: Text('Список дел'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(todoList[index]),
              child: Card(
                child: ListTile(
                  title: Text(todoList[index]),
                  onTap: () {
                    Navigator.pushNamed(context, '/note',
                        arguments: todoList[index]);
                  },
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_sharp,
                      color: Colors.deepOrange,
                    ),
                    onPressed: () {
                      setState(() {
                        todoList.removeAt(index);
                      });
                    },
                  ),
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  todoList.removeAt(index);
                });
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box),
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Новая заметка'),
                  content: TextField(
                    onChanged: (String value) {
                      _userNote = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            todoList.add(_userNote);
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text('Сохранить'))
                  ],
                );
              });
        },
      ),
    );
  }
}
