import 'package:flutter/material.dart';
import 'package:flutterapp01/theme.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String time;
  final String description;

  const TaskCard({
    super.key,
    this.title = "Untitled Task",
    this.time = "No Time Set",
    this.description = "No Description",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 130,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: secondaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20), // Padding yang konsisten
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: tertiaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: medium,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Image.asset(
                  "assets/icon-clock-white.png", // Icon clock
                  width: 16, // Sesuaikan ukuran gambar
                  height: 16,
                ),
                const SizedBox(width: 8), // Spasi antara icon dan teks
                Text(
                  time,
                  style: tertiaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: light,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: tertiaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: light,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
