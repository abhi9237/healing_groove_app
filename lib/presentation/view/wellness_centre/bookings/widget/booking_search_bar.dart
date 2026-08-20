import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class BookingSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback? onFilterTap;

  const BookingSearchBar({
    super.key,
    required this.searchController,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search Input
        Expanded(
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFEDF2FD), // Very light blue/lavender tint
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              onTapOutside: (v){
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search by name, ID, or program",
                hintStyle: TextStyle(
                  fontSize: 14.5,
                  color: Colors.grey.shade500,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.grey.shade600,
                  size: 22,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
              style: const TextStyle(
                fontSize: 15,
                color: ColorConstant.lightBlackColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Filter Button
        GestureDetector(
          onTap: onFilterTap,
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
            ),
            child: Icon(
              Icons.tune_rounded,
              color: Colors.grey.shade700,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}
