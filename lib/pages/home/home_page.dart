import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/folder_notes_page.dart';
import 'package:flutterapp01/pages/models/folder_model.dart';
import 'package:flutterapp01/pages/providers/folder_notifier.dart';
import 'package:flutterapp01/pages/widgets/folder_card.dart';
import 'package:flutterapp01/pages/widgets/task_list_view.dart';
import 'package:flutterapp01/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                        style: tertiaryTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: bold,
                        ),
                      ),
                      Text(
                        "Good Morning!",
                        style: tertiaryTextStyle.copyWith(
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
              style: tertiaryTextStyle.copyWith(
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
                    color: subtitleColor01,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "No folders available.\nAdd a new folder to get started!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: subtitleColor01,
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
          style: tertiaryTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
      );
    }

    Widget listOnGoingTask() {
      return Container(
        margin: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskListView(), // Menampilkan semua tugas tanpa filter tanggal
          ],
        ),
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
