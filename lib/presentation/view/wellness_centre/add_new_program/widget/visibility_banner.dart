import 'package:flutter/material.dart';

class VisibilityBanner extends StatelessWidget {
  const VisibilityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB), // Amber 50 background
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFEF3C7), width: 1.2), // Amber 100 border
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.visibility_outlined,
            color: Color(0xFFD97706), // Amber 600 icon
            size: 22,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Program visibility",
                  style: TextStyle(
                           
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF92400E), // Amber 800 title
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Set \"Live\" to make the program visible to guests. Draft programs are only visible to you.",
                  style: TextStyle(
                           
                    fontSize: 13,
                    color: Color(0xFFB45309), // Amber 700 description
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
