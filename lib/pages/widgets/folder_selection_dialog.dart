import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/models/folder_model.dart';
import 'package:flutterapp01/pages/models/note_model.dart';
import 'package:flutterapp01/pages/providers/folder_notifier.dart';
import 'package:flutterapp01/pages/providers/note_notifier.dart';

class FolderSelectionDialog extends StatelessWidget {
  final Note note;
  final void Function(String folderName) onFolderSelected;

  const FolderSelectionDialog({
    super.key,
    required this.note,
    required this.onFolderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Folder'),
      content: ValueListenableBuilder<List<FolderModel>>(
        valueListenable: folderNotifier,
        builder: (context, folders, _) {
          // Jika folder kosong
          if (folders.isEmpty) {
            return const Text("No folders available.");
          }

          // Jika ada folder
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: folders.map((folder) {
                return ListTile(
                  title: Text(folder.name),
                  onTap: () {
                    print('Memindahkan catatan ke folder: ${folder.name}');
                    noteNotifier.moveNoteToFolder(note, folder.name);

                    // Callback untuk memberitahu folder yang dipilih
                    print(
                        'onFolderSelected dipanggil untuk folder: ${folder.name}');
                    onFolderSelected(folder.name);
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
