import 'package:flutter/material.dart';
import 'package:flutterapp01/pages/add_note_page.dart';
import 'package:flutterapp01/pages/add_task_page.dart';
import 'package:flutterapp01/pages/edit_profile_page.dart';
import 'package:flutterapp01/pages/sign_in_page.dart';
import 'package:flutterapp01/pages/sign_up_page.dart';
import 'package:flutterapp01/pages/splash_page.dart';
import 'package:flutterapp01/pages/home/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const MainPage(),
        '/sign-in': (context) => const SignInPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/add-task': (context) => const AddTaskPage(),
        '/add-note': (context) => const AddNotePage(),
        '/edit-profile': (context) => const EditProfilePage(),
      },
    );
  }
}
