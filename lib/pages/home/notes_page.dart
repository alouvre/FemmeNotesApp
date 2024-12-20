import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/add_note_page.dart';
import 'package:flutterapp01/pages/edit_note_page.dart';
import 'package:flutterapp01/theme.dart';
import 'package:flutterapp01/pages/models/note_model.dart';
import 'package:flutterapp01/pages/providers/note_notifier.dart';
import 'package:flutterapp01/pages/widgets/note_card.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: AppBar(
          backgroundColor: background01,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          flexibleSpace: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 75, left: 30),
                child: Text(
                  "Notes",
                  style: primaryTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semibold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 8, left: 30, right: 30), // Jarak Divider
                child: Divider(
                  color: Colors.grey, // Warna garis
                  thickness: 1, // Ketebalan garis
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget addButton() {
      return FloatingActionButton(
        onPressed: () {
          // Buka halaman formulir input
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNotePage()),
          );
        },
        backgroundColor: secondaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
    }

    Widget listNotes() {
      return ValueListenableBuilder<List<Note>>(
        valueListenable: noteNotifier,
        builder: (context, notes, _) {
          // Urutkan catatan berdasarkan waktu terakhir diedit
          notes.sort((a, b) => b.lastEdited.compareTo(a.lastEdited));
          return notes.isEmpty
              ? Center(
                  child: Text(
                    "No notes yet.\nTap + to add one.",
                    style: primaryTextStyle.copyWith(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Dua kolom
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 3 / 4, // Atur proporsi kartu
                    ),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return NoteCard(
                        note: note,
                        onDelete: () => noteNotifier.removeNoteAt(index),
                        onEdit: () {
                          showDialog(
                            context: context,
                            builder: (context) => EditNotePage(
                              note: note,
                              onSave: (updatedNote) {
                                noteNotifier.updateNoteAt(index, updatedNote);
                              },
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

    Widget content() {
      return listNotes(); // GridView digunakan langsung tanpa SingleChildScrollView
    }

    return Scaffold(
      backgroundColor: background01,
      resizeToAvoidBottomInset: false,
      appBar: header(),
      body: content(),
      floatingActionButton: addButton(),
    );
  }
}
