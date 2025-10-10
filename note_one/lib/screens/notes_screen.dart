import 'package:flutter/material.dart';
import 'package:note_one/database/notes_database.dart';
import 'package:note_one/screens/note_dialogue.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    final fetchNotes = await NotesDatabase.instance.getNotes();

    setState(() {
      notes = fetchNotes;
    });

    final List<Color> noteColors = [
      
    ]

    void showNoteDialogue({int? id, String? title, String? content, int colorIndex = 0}) {
      showDialog(context: context, builder: dialogueContext) {
        return NoteDialogue (
          colorIndex: colorIndex,
          noteColors: noteColors,
          onNoteSaved: noteId: id,title: title: title: ,content: content: ,
        )
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('NotesApp',
        style: TextStyle(color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w500),),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},
      backgroundColor: Colors.white,
      child: const Icon(Icons.add,
      color: Colors.black87,),),

      body: notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_add_outlined,
                    size: 80,
                    color: Colors.grey[600],
                  ),

                  const SizedBox(height: 20),

                  Text('No Notes Found ', style: TextStyle(fontSize: 20)),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];

                  return Text(note['title']);
                },
              ),
            ),
    );
  }
}
