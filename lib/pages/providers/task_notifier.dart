import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskNotifier extends ValueNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void addTask(Task task) {
    value = [...value, task];
    notifyListeners();
  }
}

// Notifier global yang bisa diakses di seluruh aplikasi
final taskNotifier = TaskNotifier();
