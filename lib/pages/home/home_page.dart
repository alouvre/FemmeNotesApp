import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/home/notes_page.dart';
import 'package:flutterapp01/pages/models/folder_model.dart';
import 'package:flutterapp01/pages/providers/folder_notifier.dart';
import 'package:flutterapp01/pages/widgets/folder_card.dart';
import 'package:flutterapp01/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      if (folderNotifier.value.isEmpty) {
        folderNotifier.addFolder("General"); // Tambahkan folder default
      }
    }

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
                  if (folderNameController.text.trim().isNotEmpty) {
                    folderNotifier.addFolder(folderNameController.text.trim());
                  }
                  Navigator.pop(context); // Tutup dialog setelah menyimpan
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
              margin: EdgeInsets.only(top: 8), // Jarak antara teks dan garis
              child: Divider(
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
              icon: Icon(
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
                return FolderCard(
                  name: folders[index].name,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NotesPage(folderName: folders[index].name),
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

    return ListView(
      children: [
        header(),
        noteFoldersTitle(),
        listnoteFolders(),
        taskOnGoingTitle(),
      ],
    );
  }
}
