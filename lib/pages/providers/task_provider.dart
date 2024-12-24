import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:femme_notes_app/pages/models/task_model.dart';
import 'package:femme_notes_app/config.dart';
import 'package:femme_notes_app/pages/providers/auth_provider.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  Future<void> fetchTasks(BuildContext context, String date) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.token;

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('${Config.apiUrl}/task?date=$date'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _tasks = (data['tasks'] as List)
          .map((task) => TaskModel.fromJson(task))
          .toList();
      if (_tasks.isEmpty) {
        notifyListeners();
      }
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  void setTasks(List<TaskModel> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  void deleteTask(int id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
