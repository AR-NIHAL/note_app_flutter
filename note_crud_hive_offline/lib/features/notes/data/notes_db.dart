import 'package:hive/hive.dart';
import 'note_model.dart';

class NotesDb {
  static final Box _box = Hive.box('notesBox');

  // ✅ Create
  static Future<void> addNote(NoteModel note) async {
    await _box.put(note.id, note.toMap());
  }

  // ✅ Read (All)
  static List<NoteModel> getAllNotes() {
    final keys = _box.keys.toList();

    final notes = keys
        .map((key) {
          final data = _box.get(key);

          // safety: data null or not map হলে skip
          if (data == null) return null;

          return NoteModel.fromMap(Map<dynamic, dynamic>.from(data));
        })
        .whereType<NoteModel>()
        .toList();

    // latest first
    notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return notes;
  }

  //  Update
  static Future<void> updateNote(NoteModel note) async {
    await _box.put(note.id, note.toMap());
  }

  //  Delete
  static Future<void> deleteNote(String id) async {
    await _box.delete(id);
  }
}
