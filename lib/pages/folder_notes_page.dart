import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/models/note_model.dart';
import 'package:flutterapp01/theme.dart';
import 'package:flutterapp01/pages/widgets/note_card.dart';

class FolderNotesPage extends StatelessWidget {
  final String folderName;
  final List<Note> notes;

  const FolderNotesPage({
    super.key,
    required this.folderName,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    Widget listNotes() {
      return notes.isEmpty
          ? Center(
              child: Text(
                "No notes in this folder.\nAdd a new note to get started!",
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return NoteCard(
                    note: note,
                    onDelete: () {
                      // Tambahkan logika untuk menghapus catatan
                    },
                    onEdit: () {
                      // Tambahkan logika untuk mengedit catatan
                    },
                  );
                },
              ),
            );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(folderName, style: primaryTextStyle),
        backgroundColor: background01,
      ),
      body: listNotes(),
    );
  }
}
