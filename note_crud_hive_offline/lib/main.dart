import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/notes/presentation/notes_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //  Hive init
  await Hive.initFlutter();

  //  Open box (local database)
  await Hive.openBox('notesBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes CRUD',
      theme: ThemeData(useMaterial3: true),
      home: const NotesListScreen(),
    );
  }
}
