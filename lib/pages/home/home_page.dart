import 'package:femme_notes_app/pages/models/task_model.dart';
import 'package:femme_notes_app/pages/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:femme_notes_app/pages/folder_notes_page.dart';
import 'package:femme_notes_app/pages/models/folder_model.dart';
import 'package:femme_notes_app/pages/providers/folder_notifier.dart';
import 'package:femme_notes_app/pages/widgets/folder_card.dart';
import 'package:femme_notes_app/theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TaskModel> getNonExpiredTasks(List<TaskModel> tasks) {
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(Duration(days: 1));
    return tasks.where((task) {
      DateTime taskDate = DateTime.parse(task.date);
      return taskDate.isAfter(today.subtract(Duration(days: 1))) &&
          taskDate.isBefore(tomorrow.add(Duration(days: 1)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Dialog untuk menambahkan folder baru
    void _showAddFolderDialog() {
      final TextEditingController folderNameController =
          TextEditingController();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Folder"),
            content: TextField(
              controller: folderNameController,
              decoration: const InputDecoration(
                hintText: "Enter folder name",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog tanpa menyimpan
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  final folderName = folderNameController.text.trim();
                  if (folderName.isNotEmpty) {
                    // Tambahkan folder ke folderNotifier
                    folderNotifier.addFolder(FolderModel(name: folderName));
                    Navigator.pop(context); // Tutup dialog setelah menyimpan
                  }
                },
                child: const Text("Add"),
              ),
            ],
          );
        },
      );
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: 50,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey Chris,",
                        style: primaryTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: bold,
                        ),
                      ),
                      Text(
                        "Good Morning!",
                        style: primaryTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 54,
                  height: 54,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/image-profile.png",
                      ),
                    ),
                  ),
                )
              ],
            ),
            // Tambahkan Divider di bawah teks
            Container(
              margin:
                  const EdgeInsets.only(top: 8), // Jarak antara teks dan garis
              child: const Divider(
                color: Colors.grey, // Warna garis
                thickness: 1, // Ketebalan garis
              ),
            ),
          ],
        ),
      );
    }

    Widget noteFoldersTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          right: defaultMargin,
          left: defaultMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All Folders",
              style: primaryTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semibold,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.black,
                size: 28,
              ),
              onPressed:
                  _showAddFolderDialog, // Buka dialog saat tombol ditekan
            ),
          ],
        ),
      );
    }

    Widget listnoteFolders() {
      return ValueListenableBuilder<List<FolderModel>>(
        valueListenable: folderNotifier,
        builder: (context, folders, _) {
          if (folders.isEmpty) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 34),
                  Icon(
                    Icons.folder_open,
                    size: 40,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "No folders available.\nAdd a new folder to get started!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 34),
                ],
              ),
            );
          }

          return Container(
            margin: const EdgeInsets.only(top: 8, left: 20),
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: folders.length,
              itemBuilder: (context, index) {
                final folder = folders[index];
                return FolderCard(
                  name: folder.name,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FolderNotesPage(
                          folderName: folder.name,
                          notes: folder.notes,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      );
    }

    Widget taskOnGoingTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          right: defaultMargin,
          left: defaultMargin,
        ),
        child: Text(
          "Ongoing Tasks",
          style: primaryTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
      );
    }

    Widget listOnGoingTask() {
      return Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          List<TaskModel> nonExpiredTasks =
              getNonExpiredTasks(taskProvider.tasks);
          if (nonExpiredTasks.isEmpty) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 34),
                  Icon(
                    Icons.task_alt,
                    size: 40,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "No ongoing tasks.\nAll caught up!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 34),
                ],
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.only(top: 8, left: 20),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: nonExpiredTasks.length,
              itemBuilder: (context, index) {
                final task = nonExpiredTasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text('Due: ${task.date}'),
                  onTap: () {},
                );
              },
            ),
          );
        },
      );
    }

    return ListView(
      children: [
        header(),
        noteFoldersTitle(),
        listnoteFolders(),
        taskOnGoingTitle(),
        listOnGoingTask(),
      ],
    );
  }
}
