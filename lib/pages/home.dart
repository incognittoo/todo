import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List todoList = [];
  String _userNote = '';

  // void initFirebase() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  // }

  @override
  void initState() {
    super.initState();
    // initFirebase();

    todoList.addAll(
        ['Записать курс', 'Выучить Flutter', 'Build ToDo List Application']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 28, 91),
        title: Text('Список дел'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text('Нет заметок');
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        snapshot.data?.docs[index].get('title'),
                        style: TextStyle(
                            fontFamily: 'Tilt Neon',
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/note',
                          arguments: snapshot.data?.docs[index].get('title'),
                        );
                      },
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete_sharp,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('notes')
                              .doc(snapshot.data?.docs[index].id)
                              .delete();
                        },
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    FirebaseFirestore.instance
                        .collection('notes')
                        .doc(snapshot.data?.docs[index].id)
                        .delete();
                  },
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_box,
          color: Colors.white,
        ),
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
                          FirebaseFirestore.instance
                              .collection('notes')
                              .add({'title': _userNote});
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Сохранить',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                );
              });
        },
      ),
    );
  }
}
