import 'package:flutter/material.dart';
import 'package:todo/pages/home.dart';
import 'package:todo/pages/note_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(
        colorScheme: ColorScheme.dark().copyWith(primary: Colors.blue)),
    initialRoute: '/',
    routes: {'/': (context) => Home(), '/note': (context) => NoteScreen()},
  ));
}
