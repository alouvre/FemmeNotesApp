import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/providers/folder_notifier.dart';
import '../models/note_model.dart';

class NoteNotifier extends ValueNotifier<List<Note>> {
  NoteNotifier() : super([]);

  void addNote(Note note) {
    value = [...value, note];
    notifyListeners();
  }

  void removeNoteCompletely(Note note) {
    // Hapus dari daftar utama
    value = value.where((n) => n != note).toList();

    // Hapus dari folder
    folderNotifier.removeNoteFromAllFolders(note);

    notifyListeners(); // Harus dipanggil setelah perubahan
  }

  void updateNoteAt(int index, Note updatedNote) {
    value = List.from(value)
      ..[index] = updatedNote; // Gantikan note lama dengan note baru
    notifyListeners();
  }

  void moveNoteToFolder(Note note, String newFolderName) {
    // Tambahkan note ke folder baru
    folderNotifier.addNoteToFolder(newFolderName, note);

    // Perbarui UI
    notifyListeners();
  }
}

// Notifier global yang bisa diakses di seluruh aplikasi
final noteNotifier = NoteNotifier();
