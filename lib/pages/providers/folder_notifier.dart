import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/models/folder_model.dart';
import 'package:flutterapp01/pages/models/note_model.dart';

class FolderNotifier extends ValueNotifier<List<FolderModel>> {
  FolderNotifier() : super([]);

  void addFolder(FolderModel folder) {
    value = [...value, folder];
    notifyListeners();
  }

  void addNoteToFolder(String folderName, Note note) {
    final folderIndex = value.indexWhere((folder) => folder.name == folderName);
    if (folderIndex != -1) {
      final folder = value[folderIndex];
      final updatedNotes = List<Note>.from(folder.notes)..add(note);
      value[folderIndex] = FolderModel(
        name: folder.name,
        notes: updatedNotes,
      );
      print('Note added to folder: ${folder.name}');
      notifyListeners();
    } else {
      print('Folder not found: $folderName');
    }
  }
}

final folderNotifier = FolderNotifier();
