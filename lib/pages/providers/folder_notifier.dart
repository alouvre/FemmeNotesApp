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
      value[folderIndex].notes.add(note); // Tambahkan catatan ke folder
      notifyListeners();
    }
  }
}

final folderNotifier = FolderNotifier();
