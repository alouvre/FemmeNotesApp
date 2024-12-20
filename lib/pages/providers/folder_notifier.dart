import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/models/folder_model.dart';

class FolderNotifier extends ValueNotifier<List<FolderModel>> {
  FolderNotifier() : super([]);

  void addFolder(String name) {
    value = [...value, FolderModel(name: name)];
    notifyListeners();
  }

  // void editFolder(String id, String newName) {
  //   value = value.map((folder) {
  //     if (folder.name == id) {
  //       return FolderModel(id: folder.id, name: newName);
  //     }
  //     return folder;
  //   }).toList();
  //   notifyListeners();
  // }

  // void deleteFolder(String id) {
  //   value = value.where((folder) => folder.id != id).toList();
  //   notifyListeners();
  // }
}

final folderNotifier = FolderNotifier();
