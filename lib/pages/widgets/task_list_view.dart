import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/models/task_model.dart';
import 'package:flutterapp01/pages/providers/task_notifier.dart';
import 'package:flutterapp01/pages/widgets/task_card.dart';
import 'package:flutterapp01/theme.dart';

class TaskListView extends StatelessWidget {
  final String? dateFilter; // Optional, jika ingin filter berdasarkan tanggal

  const TaskListView({Key? key, this.dateFilter}) : super(key: key);

  void _editTask(BuildContext context, Task task) {
    // Controllers untuk text field
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog tanpa menyimpan
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Update task di TaskNotifier
                taskNotifier.value = taskNotifier.value.map((t) {
                  if (t == task) {
                    return Task(
                      title: titleController.text,
                      time: task.time,
                      description: descriptionController.text,
                      date: task.date,
                    );
                  }
                  return t;
                }).toList();

                Navigator.pop(context); // Tutup dialog setelah menyimpan
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Task>>(
      valueListenable: taskNotifier,
      builder: (context, tasks, _) {
        final filteredTasks = dateFilter != null
            ? tasks.where((task) => task.date == dateFilter).toList()
            : tasks;

        if (filteredTasks.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: MediaQuery.of(context).size.height * 0.15),
              child: Text(
                'No tasks available.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: subtitleColor01,
                ),
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredTasks.length,
          itemBuilder: (context, index) {
            final task = filteredTasks[index];
            return TaskCard(
              title: task.title,
              time: task.time,
              description: task.description,
              onEdit: () {
                _editTask(context, task);
              },
              onDelete: () {
                taskNotifier.value =
                    taskNotifier.value.where((t) => t != task).toList();
              },
            );
          },
        );
      },
    );
  }
}
