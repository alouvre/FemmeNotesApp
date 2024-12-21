import 'package:flutterapp01/pages/models/note_model.dart';

class FolderModel {
  final String name;
  final List<Note> notes;

  FolderModel({
    required this.name,
    this.notes = const [],
  });
}
