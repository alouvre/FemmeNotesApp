import 'package:flutter/material.dart';
import 'package:flutterapp01/theme.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String time;
  final String description;
  final Function()? onEdit;
  final Function()? onDelete;

  const TaskCard({
    super.key,
    this.title = "Untitled Task",
    this.time = "No Time Set",
    this.description = "No Description",
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 140,
      margin: const EdgeInsets.only(top: 15, right: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: secondaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'Edit' && onEdit != null) {
                      onEdit!();
                    } else if (value == 'Delete' && onDelete != null) {
                      onDelete!();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: 'Delete',
                      child: Text('Delete'),
                    ),
                  ],
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
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
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: light,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: primaryTextStyle.copyWith(
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
