import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterapp01/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushNamed(context, '/sign-in'),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background01,
      body: Center(
        child: Column(
          children: [
            // Container(
            //   width: 130,
            //   height: 150,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage("assets/image-splash.png"),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20), // Jarak antara gambar dan teks
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: MediaQuery.of(context).size.height * 0.45),
              child: Text(
                "Welcome to Femme Notes",
                style: secondaryTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
