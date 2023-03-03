import 'package:flutter/material.dart';
import 'package:todo/pages/home.dart';
import 'package:todo/pages/note_screen.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(primaryColor: Colors.blueGrey),
      initialRoute: '/',
      routes: {'/': (context) => Home(), '/note': (context) => NoteScreen()},
    ));
