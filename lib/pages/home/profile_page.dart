import 'package:flutter/material.dart';
import 'package:flutterapp01/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: background01,
        title: Text(
          "Profile",
          style: primaryTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 87),
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/image-profile.png",
                    width: 145,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Chris Evan",
                  style: primaryTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "chrisevan@gmail.com",
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget menuItem(String text) {
      return Container(
        margin: const EdgeInsets.only(
          top: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: regular,
              ),
            ),
            const Icon(
              Icons.chevron_right,
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          decoration: BoxDecoration(
            color: background01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: defaultMargin),
              Text(
                "Account",
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/edit-profile');
                },
                child: menuItem(
                  "Edit Profile",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/sign-in', (route) => false);
                },
                child: menuItem(
                  "Log Out",
                ),
              ),
              menuItem(
                "Help",
              ),
              SizedBox(
                height: defaultMargin,
              ),
              Text(
                "General",
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              menuItem(
                "Privacy & Policy",
              ),
              menuItem(
                "Term of Service",
              ),
              menuItem(
                "Rate App",
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}
