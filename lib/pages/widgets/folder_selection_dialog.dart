import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/models/folder_model.dart';
import 'package:flutterapp01/pages/providers/folder_notifier.dart';

class FolderSelectionDialog extends StatelessWidget {
  final void Function(String folderName) onFolderSelected;

  const FolderSelectionDialog({
    super.key,
    required this.onFolderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Folder'),
      content: ValueListenableBuilder<List<FolderModel>>(
        valueListenable: folderNotifier,
        builder: (context, folders, _) {
          return folders.isEmpty
              ? const Text("No folders available.")
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: folders.map((folder) {
                      return ListTile(
                        title: Text(folder.name),
                        onTap: () => onFolderSelected(folder.name),
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
