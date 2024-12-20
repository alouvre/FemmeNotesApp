import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/models/note_model.dart';

class EditNotePage extends StatefulWidget {
  final Note note;
  final Function(Note) onSave;

  const EditNotePage({
    super.key,
    required this.note,
    required this.onSave,
  });

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final updatedNote = Note(
      title: titleController.text.trim(),
      content: contentController.text.trim(),
      color: widget.note.color,
      lastEdited: DateTime.now().toString(),
    );

    widget.onSave(updatedNote);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: contentController,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Content'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveNote,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
