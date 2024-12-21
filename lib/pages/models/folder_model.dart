import 'package:flutterapp01/pages/models/note_model.dart';

class FolderModel {
  final String name;
  final List<Note> notes;

  FolderModel({
    required this.name,
    List<Note>? notes,
  }) : notes = notes ?? []; // Inisialisasi sebagai list yang dapat dimodifikasi
}
