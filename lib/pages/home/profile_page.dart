import 'package:flutter/material.dart';
import 'package:flutterapp01/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: background01,
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
                  style: secondaryTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "chrisevan@gmail.com",
                  style: tertiaryTextStyle.copyWith(
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
              style: tertiaryTextStyle.copyWith(
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
                style: secondaryTextStyle.copyWith(
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
                style: secondaryTextStyle.copyWith(
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

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}
