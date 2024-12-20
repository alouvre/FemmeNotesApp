import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/models/task_model.dart';
import 'package:flutterapp01/pages/providers/task_notifier.dart';
import 'package:flutterapp01/pages/widgets/task_card.dart';
import 'package:flutterapp01/theme.dart';
import 'package:intl/intl.dart'; // Untuk memformat tanggal

class CalendarPage extends StatefulWidget {
  final Function(String)
      onDateSelected; // Callback untuk mengirim tanggal ke MainPage

  const CalendarPage({super.key, required this.onDateSelected});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          backgroundColor: background01,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 80, left: 30),
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's tasks",
                  style: primaryTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semibold,
                  ),
                ),
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
            ),
          ),
        ),
      );
    }

    Widget datePicker() {
      DateTime today = DateTime.now();

      // Membuat list tanggal untuk ditampilkan dalam bentuk horizontal
      List<Widget> dateWidgets = List.generate(30, (index) {
        // Menghitung tanggal berdasarkan hari ini
        DateTime date = today.add(Duration(days: index));
        String day = DateFormat('d').format(date); // Hari tanggal
        String weekday = DateFormat('E').format(date); // Singkatan Hari
        String month =
            DateFormat('MMM').format(date).toUpperCase(); // Bulan Kapital
        String formattedDate = DateFormat('yyyy-MM-dd').format(date);
        bool isSelected = formattedDate == selectedDate;

        return GestureDetector(
          onTap: () {
            // Mengirimkan formattedDate ke currentTasks
            setState(() {
              selectedDate = formattedDate; // Update tanggal yang dipilih
            });
          },
          child: Container(
            width: 55,
            height: 82,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: isSelected
                  ? Colors.black
                  : Colors.white, // Ganti dengan primaryColor
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  month,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: regular,
                    color: isSelected
                        ? Colors.white
                        : Colors.grey, // Ganti dengan tertiaryTextStyle
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: semibold,
                    color: isSelected
                        ? Colors.white
                        : Colors.grey, // Ganti dengan tertiaryTextStyle
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  weekday,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: regular,
                    color: isSelected
                        ? Colors.white
                        : Colors.grey, // Ganti dengan tertiaryTextStyle
                  ),
                ),
              ],
            ),
          ),
        );
      });

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Agar bisa scroll horizontal
        child: Row(
          children: dateWidgets,
        ),
      );
    }

    Widget listTasks() {
      return ValueListenableBuilder<List<Task>>(
        valueListenable: taskNotifier,
        builder: (context, tasks, _) {
          print("Current Tasks: ${tasks.length}"); // Debugging jumlah task

          // Filter tugas berdasarkan tanggal yang dipilih
          final filteredTasks =
              tasks.where((task) => task.date == selectedDate).toList();

          return filteredTasks.isEmpty
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: MediaQuery.of(context).size.height * 0.3),
                    child: Text(
                      'No tasks available.',
                      style: primaryTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return TaskCard(
                        title: task.title,
                        time: task.time,
                        description: task.description,
                      );
                    },
                  ),
                );
        },
      );
    }

    Widget content() {
      return SafeArea(
        child: Container(
          width: 390,
          margin: const EdgeInsets.only(top: 15, left: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                datePicker(), // Memilih tanggal
                listTasks(), // Menampilkan tugas berdasarkan tanggal
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: background01,
      resizeToAvoidBottomInset: false,
      appBar: header(),
      body: content(),
    );
  }
}