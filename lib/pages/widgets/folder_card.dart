import 'package:flutter/material.dart';
import 'package:flutterapp01/theme.dart';

class FolderCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const FolderCard({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 14),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: background02,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 34),
              Icon(
                Icons.folder_open,
                size: 50,
                color: secondaryColor,
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                style: tertiaryTextStyle.copyWith(
                  fontSize: 12,
                  color: secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
