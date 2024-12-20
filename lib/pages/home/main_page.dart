import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/add_task_page.dart';
import 'package:flutterapp01/pages/home/home_page.dart';
import 'package:flutterapp01/pages/home/notes_page.dart';
import 'package:flutterapp01/pages/home/calendar_page.dart';
import 'package:flutterapp01/pages/home/profile_page.dart';
import 'package:flutterapp01/pages/models/task_model.dart';
import 'package:flutterapp01/pages/providers/task_notifier.dart';
import 'package:flutterapp01/theme.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  // Tambahkan variabel untuk menyimpan selectedDate
  String selectedDate = DateTime.now().toIso8601String();

  // Fungsi untuk memperbarui selectedDate
  void updateSelectedDate(String date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget addButton() {
      return FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push<Task>(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskPage(),
            ),
          );

          if (newTask != null) {
            taskNotifier.addTask(newTask);
          }
        },
        backgroundColor: background03,
        shape: CircleBorder(),
        child: Image.asset(
          "assets/icon-add.png",
          width: 25,
        ),
      );
    }

    Widget customButtonNav() {
      return ClipRRect(
        child: BottomAppBar(
          padding: EdgeInsets.all(0),
          shape: CircularNotchedRectangle(),
          notchMargin: 13,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            backgroundColor: background03,
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                print(value);
                currentIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: [
              // Home
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Image.asset(
                    "assets/icon-home.png",
                    width: 24,
                    color: currentIndex == 0 ? secondaryColor : tertiaryColor,
                  ),
                ),
                label: '',
              ),
              // Notes
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 40,
                  ),
                  child: Image.asset(
                    "assets/icon-notes1.png",
                    width: 33,
                    color: currentIndex == 1 ? secondaryColor : tertiaryColor,
                  ),
                ),
                label: '',
              ),
              // Calendar
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 40,
                  ),
                  child: Image.asset(
                    "assets/icon-calendar.png",
                    width: 31,
                    color: currentIndex == 2 ? secondaryColor : tertiaryColor,
                  ),
                ),
                label: '',
              ),
              // Profile
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Image.asset(
                    "assets/icon-profile.png",
                    width: 21,
                    color: currentIndex == 3 ? secondaryColor : tertiaryColor,
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      );
    }

    Widget body() {
      switch (currentIndex) {
        case 0:
          return HomePage();
        case 1:
          return NotesPage();
        case 2:
          return CalendarPage(
            // Kirim fungsi updateSelectedDate ke CalendarPage
            onDateSelected: updateSelectedDate,
          );
        case 3:
          return ProfilePage();

        default:
          return SizedBox.shrink();
      }
    }

    return Scaffold(
      backgroundColor: background01,
      floatingActionButton: addButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customButtonNav(),
      body: body(),
    );
  }
}
