import 'package:flutter/material.dart';
import 'package:femme_notes_app/pages/models/task_model.dart';
import 'package:femme_notes_app/pages/providers/task_notifier.dart';
import 'package:femme_notes_app/theme.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  // Variabel untuk menyimpan pilihan pengingat
  String selectedRemind = "Choose remind time";
  String selectedRepeat = "None";

  // Controllers untuk input form
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    startTimeController.text = DateFormat.jm().format(DateTime.now());
    endTimeController.text =
        DateFormat.jm().format(DateTime.now().add(const Duration(hours: 1)));
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  void _showAlertDialog(String message, {bool isSuccess = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            isSuccess ? 'Success' : 'Error',
            style: TextStyle(
              color: isSuccess ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (isSuccess) Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _submitTask() {
    if (titleController.text.trim().isEmpty ||
        noteController.text.trim().isEmpty ||
        dateController.text.isEmpty ||
        startTimeController.text.isEmpty ||
        endTimeController.text.isEmpty) {
      _showAlertDialog('Please complete all fields');
      return;
    }

    final newTask = TaskModel(
      title: titleController.text.trim(),
      note: noteController.text.trim(),
      date: DateFormat('yyyy-MM-dd').format(
        DateFormat('dd/MM/yyyy').parse(dateController.text.trim()),
      ),
      startTask: startTimeController.text.trim(),
      endTask: endTimeController.text.trim(),
    );

    taskNotifier.addTask(newTask);
    _showAlertDialog('Task successfully added!', isSuccess: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        centerTitle: true,
        backgroundColor: background01,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleInput(),
              noteInput(),
              dateInput(),
              timeInput(context),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitTask,
                child: const Text("Add Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleInput() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
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
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: tertiaryColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: subtitleColor01),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: titleController,
                    style: primaryTextStyle,
                    decoration: InputDecoration.collapsed(
                      hintText: "Enter title here.",
                      hintStyle: subtitleTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget noteInput() {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Note",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: tertiaryColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: subtitleColor01),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: noteController,
                    style: primaryTextStyle,
                    decoration: InputDecoration.collapsed(
                      hintText: "Enter note here.",
                      hintStyle: subtitleTextStyle,
                    ),
                    maxLines:
                        8, // Membuat TextFormField bisa memiliki banyak baris
                    minLines: 1, // Set minimal 2 baris
                    keyboardType: TextInputType.multiline, // Keyboard multiline
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dateInput() {
    Future<void> selectDate() async {
      DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (selectedDate != null) {
        dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      }
    }

    // Set default date to current date
    void setCurrentDate() {
      DateTime now = DateTime.now();
      dateController.text = DateFormat('dd/MM/yyyy').format(now);
    }

    // Set the default date on widget load
    setCurrentDate();

    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Date",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: tertiaryColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: subtitleColor01),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: dateController,
                    style: primaryTextStyle,
                    decoration: InputDecoration.collapsed(
                      hintText: "Select a date.",
                      hintStyle: subtitleTextStyle,
                    ),
                    readOnly: true,
                    onTap: selectDate,
                  ),
                ),
                Image.asset(
                  "assets/icon-calendar-black.png",
                  width: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget timeInput(BuildContext context) {
    // Fungsi untuk memilih waktu
    Future<void> selectTime(
        BuildContext context, TextEditingController controller) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final now = DateTime.now();
        final selectedTime = DateTime(
          now.year,
          now.month,
          now.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        final formattedTime =
            DateFormat.jm().format(selectedTime); // Format AM/PM
        controller.text = formattedTime;
      }
    }

    // Set waktu saat ini untuk startTimeController
    void setCurrentTime() {
      final now = DateTime.now();
      final formattedTime = DateFormat.jm().format(now); // Format AM/PM
      startTimeController.text = formattedTime;
    }

    // Panggil _setCurrentTime saat widget dimuat
    setCurrentTime();

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Start Time Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start Time",
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => selectTime(context, startTimeController),
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: tertiaryColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: subtitleColor01),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: startTimeController,
                                style: primaryTextStyle,
                                decoration: InputDecoration.collapsed(
                                  hintText: "Start Time",
                                  hintStyle: subtitleTextStyle,
                                ),
                                readOnly: true, // Tidak bisa mengetik
                                onTap: () => selectTime(context,
                                    startTimeController), // Pemicu untuk memilih waktu
                              ),
                            ),
                            Image.asset(
                              "assets/icon-clock.png",
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              // End Time Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "End Time",
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => selectTime(context, endTimeController),
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: tertiaryColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: subtitleColor01),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: endTimeController,
                                style: primaryTextStyle,
                                decoration: InputDecoration.collapsed(
                                  hintText: "End Time",
                                  hintStyle: subtitleTextStyle,
                                ),
                                readOnly: true, // Tidak bisa mengetik
                                onTap: () => selectTime(context,
                                    endTimeController), // Pemicu untuk memilih waktu
                              ),
                            ),
                            Image.asset(
                              "assets/icon-clock.png",
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget createTaskButton() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.only(top: defaultMargin),
      child: TextButton(
        onPressed: () => _submitTask(),
        style: TextButton.styleFrom(
          backgroundColor: buttonColor01,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          "Create Task",
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
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: primaryTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: semibold,
                ),
              ),
              titleInput(),
              noteInput(),
              dateInput(),
              timeInput(context),
              createTaskButton(),
            ],
          ),
        ),
      ),
    );
  }
}
