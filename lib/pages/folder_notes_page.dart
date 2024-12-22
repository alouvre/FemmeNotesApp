import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/edit_note_page.dart';
import 'package:flutterapp01/pages/models/note_model.dart';
import 'package:flutterapp01/pages/providers/folder_notifier.dart';
import 'package:flutterapp01/pages/providers/note_notifier.dart';
import 'package:flutterapp01/pages/widgets/folder_selection_dialog.dart';
import 'package:flutterapp01/theme.dart';
import 'package:flutterapp01/pages/widgets/note_card.dart';

class FolderNotesPage extends StatefulWidget {
  final String folderName;
  final List<Note> notes;

  const FolderNotesPage({
    super.key,
    required this.folderName,
    required this.notes,
  });

  @override
  State<FolderNotesPage> createState() => _FolderNotesPageState();
}

class _FolderNotesPageState extends State<FolderNotesPage> {
  void _deleteFolder(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Folder'),
        content: Text(
          'Are you sure you want to delete the folder ${widget.folderName}? '
          '\nAll notes in this folder will be removed from the folder but will remain in the main list.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Hapus folder dari FolderNotifier
              folderNotifier.value = folderNotifier.value
                  .where((folder) => folder.name != widget.folderName)
                  .toList();
              folderNotifier.notifyListeners();

              // Kembali ke halaman sebelumnya
              Navigator.pop(context); // Tutup dialog
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        title: Text(widget.folderName, style: primaryTextStyle),
        backgroundColor: background01,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                _deleteFolder(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete Folder'),
              ),
            ],
          ),
        ],
      );
    }

    Widget listNotes() {
      return ValueListenableBuilder<List<Note>>(
        valueListenable: noteNotifier,
        builder: (context, allNotes, child) {
          // Filter notes berdasarkan folderName
          final folderNotes = allNotes
              .where((note) => note.folderName == widget.folderName)
              .toList();

          return folderNotes.isEmpty
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: folderNotes.length,
                    itemBuilder: (context, index) {
                      final note = folderNotes[index];
                      return NoteCard(
                        note: note,
                        index: index,
                        onDelete: () {
                          noteNotifier.removeNoteCompletely(note);
                        },
                        onEdit: () {
                          showDialog(
                            context: context,
                            builder: (context) => EditNotePage(
                              note: note,
                              onSave: (updatedNote) {
                                noteNotifier.updateNoteAt(
                                    allNotes.indexOf(note), updatedNote);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                        onMove: () {
                          showDialog(
                            context: context,
                            builder: (context) => FolderSelectionDialog(
                              note: note,
                              onFolderSelected: (folderName) {
                                noteNotifier.moveNoteToFolder(note, folderName);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Note moved to $folderName')),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
        },
      );
    }

    return Scaffold(
      appBar: header(),
      body: listNotes(),
    );
  }
}
