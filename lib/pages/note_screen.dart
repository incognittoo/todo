import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late String _noteText;

  @override
  Widget build(BuildContext context) {
    final ModalRoute<Object?> modalRoute = ModalRoute.of(context)!;
    _noteText = modalRoute.settings.arguments as String;

    return Scaffold(
        body: SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'Заметка:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Text('$_noteText'),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Назад'))
            ],
          )
        ],
      ),
    ));
  }
}
