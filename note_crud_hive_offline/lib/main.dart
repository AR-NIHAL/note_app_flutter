import 'package:flutter/material.dart';
import 'package:note_crud_hive_offline/features/notes/presentation/note_form_screen.dart';
import 'package:note_crud_hive_offline/features/notes/presentation/notes_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes Crud',
      theme: ThemeData(useMaterial3: true),
      home: NotesListScreen(),
    );
  }
}
