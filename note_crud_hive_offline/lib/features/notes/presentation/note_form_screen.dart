import 'package:flutter/material.dart';

import '../data/note_model.dart';
import '../data/notes_db.dart';

class NoteFormScreen extends StatefulWidget {
  final NoteModel? note;
  const NoteFormScreen({super.key, this.note});

  @override
  State<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool get isEdit => widget.note != null;

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      _titleCtrl.text = widget.note!.title;
      _descCtrl.text = widget.note!.description;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  String _makeId() => DateTime.now().microsecondsSinceEpoch.toString();

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final note = NoteModel(
      id: isEdit ? widget.note!.id : _makeId(),
      title: _titleCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      createdAt: isEdit ? widget.note!.createdAt : DateTime.now(),
    );

    if (isEdit) {
      await NotesDb.updateNote(note);
    } else {
      await NotesDb.addNote(note);
    }

    if (!mounted) return;
    Navigator.pop(context, true); // ✅ changed=true
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Note' : 'Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Title লাগবে';
                  if (v.trim().length < 3) return 'কমপক্ষে 3 অক্ষর';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Description লাগবে';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  child: Text(isEdit ? 'Update' : 'Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
