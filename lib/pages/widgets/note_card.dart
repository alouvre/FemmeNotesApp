import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/edit_note_page.dart';
import 'package:flutterapp01/pages/models/note_model.dart';
import 'package:flutterapp01/pages/providers/note_notifier.dart';
import 'package:flutterapp01/pages/widgets/folder_selection_dialog.dart';
import 'package:flutterapp01/pages/providers/folder_notifier.dart';
import 'package:flutterapp01/theme.dart';
import 'package:intl/intl.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final int index;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onMove;
  final VoidCallback onSave;

  const NoteCard({
    super.key,
    required this.note,
    required this.index,
    required this.onDelete,
    required this.onEdit,
    required this.onMove,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(top: 16, left: 16, bottom: 8),
      decoration: BoxDecoration(
        color: background02,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul Note
              Expanded(
                child: Text(
                  note.title,
                  style: secondaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 5),
              // Menu Dropdown
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    showDialog(
                      context: context,
                      builder: (context) => EditNotePage(
                        note: note,
                        onSave: (updatedNote) {
                          noteNotifier.updateNoteAt(index, updatedNote);
                        },
                      ),
                    );
                  } else if (value == 'delete') {
                    noteNotifier.removeNoteCompletely(
                        note); // Hapus catatan secara global
                  } else if (value == 'move') {
                    print('Move to Folder selected'); // Debug
                    showDialog(
                      context: context,
                      builder: (context) {
                        print('Dialog Builder triggered'); // Debug
                        return FolderSelectionDialog(
                          note: note,
                          onFolderSelected: (folderName) {
                            print('Selected folder: $folderName'); // Debug
                            folderNotifier.addNoteToFolder(folderName, note);
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                  const PopupMenuItem(
                    value: 'move',
                    child: Text('Move to Folder'),
                  ),
                ],
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          // Konten Note
          Expanded(
            child: Text(
              note.content,
              style:
                  secondaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
              overflow: TextOverflow.ellipsis,
              maxLines: 6, // Batasi maksimal 6 baris
            ),
          ),
          const SizedBox(height: 16),
          // Tanggal Terakhir Diedit
          Text(
            "Last Edited: ${DateFormat('dd/MM/yyyy, HH:mm').format(DateTime.parse(note.lastEdited))}",
            style: secondaryTextStyle.copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
