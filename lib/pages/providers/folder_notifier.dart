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

      // Cek apakah note sudah ada di folder
      if (!folder.notes.contains(note)) {
        final updatedNotes = List<Note>.from(folder.notes)..add(note);
        value[folderIndex] = FolderModel(
          name: folder.name,
          notes: updatedNotes,
        );
        print('Note added to folder: ${folder.name}');
        notifyListeners();
      }
    } else {
      print('Folder not found: $folderName');
    }
  }

  void removeNoteFromAllFolders(Note note) {
    for (var folder in value) {
      folder.notes.remove(note); // Hapus catatan dari setiap folder
    }
    notifyListeners();
  }

  void updateNote(Note updatedNote) {
    for (var i = 0; i < value.length; i++) {
      final folder = value[i];
      final noteIndex =
          folder.notes.indexWhere((note) => note.id == updatedNote.id);
      if (noteIndex != -1) {
        final updatedNotes = List<Note>.from(folder.notes);
        updatedNotes[noteIndex] = updatedNote;
        value[i] = FolderModel(name: folder.name, notes: updatedNotes);
      }
    }
    notifyListeners();
  }
}

final folderNotifier = FolderNotifier();
