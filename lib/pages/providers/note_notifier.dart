import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NoteNotifier extends ValueNotifier<List<Note>> {
  NoteNotifier() : super([]);

  void addNote(Note note) {
    value = [...value, note];
    notifyListeners();
  }

  void removeNoteAt(int index) {
    value = List.from(value)..removeAt(index);
    notifyListeners();
  }

  void updateNoteAt(int index, Note updatedNote) {
    value = List.from(value)
      ..[index] = updatedNote; // Gantikan note lama dengan note baru
    notifyListeners();
  }

  void moveNotesToFolder(List<int> noteIndexes, String folderName) {
    value = List.from(value);
    for (var index in noteIndexes) {
      value[index] = Note(
        title: value[index].title,
        content: value[index].content,
        color: value[index].color,
        lastEdited: value[index].lastEdited,
        folderName: folderName,
      );
    }
    notifyListeners();
  }
}

// Notifier global yang bisa diakses di seluruh aplikasi
final noteNotifier = NoteNotifier();
