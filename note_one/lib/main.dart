import 'package:flutter/material.dart';
import 'package:note_one/screens/notes_screen.dart';

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Notes App",
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: NotesScreen(),
    );
  }
}
