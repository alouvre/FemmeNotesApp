import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/models/note_model.dart';
import 'package:flutterapp01/pages/providers/note_notifier.dart';
import '../theme.dart';
import 'package:uuid/uuid.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final uuid = const Uuid();

  @override
  void dispose() {
    // Membersihkan controller saat widget dihancurkan
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _showAlertDialog(String message, {bool isSuccess = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isSuccess ? 'Success' : 'Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context); // Menutup dialog
                if (isSuccess) {
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _submitNote() {
    if (titleController.text.trim().isEmpty ||
        contentController.text.trim().isEmpty) {
      _showAlertDialog('Please complete all fields');
      return;
    }

    final newNote = Note(
      id: uuid.v4(),
      title: titleController.text.trim(),
      content: contentController.text.trim(),
      color: "0xFFFEB3C7",
      lastEdited: DateTime.now().toString(),
    );

    // Menambahkan note ke NoteNotifier
    noteNotifier.addNote(newNote);

    // Memberi feedback dan kembali ke halaman sebelumnya menggunakan AlertDialog
    _showAlertDialog('Note successfully added!', isSuccess: true);
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: background01,
        automaticallyImplyLeading: true,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 40),
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  "assets/image-profile.png",
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget titleInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title",
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter title here",
                hintStyle: subtitleTextStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget contentInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Content",
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: contentController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: "Enter content here",
                hintStyle: subtitleTextStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget saveButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: _submitNote,
          style: TextButton.styleFrom(
            backgroundColor: buttonColor01,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            "Save Note",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
        ),
      );
    }

    Widget content() {
      return SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Note",
                  style: primaryTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: semibold,
                  ),
                ),
                titleInput(),
                contentInput(),
                saveButton(),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: background01,
      appBar: header(),
      body: content(),
    );
  }
}
