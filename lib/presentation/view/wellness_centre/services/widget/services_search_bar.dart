import 'package:flutter/material.dart';
import 'package:healing/common/common_text_form_filled.dart';
import '../../../../../core/color_constant/color_constant.dart';

class ServicesSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final String selectedFilter;
  final ValueChanged<String?> onFilterChanged;

  const ServicesSearchBar({
    super.key,
    required this.searchController,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Input Box
        // Container(
        //   height: 52,
        //   // padding: const EdgeInsets.symmetric(horizontal: 12),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(12),
        //     border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        //   ),
        //   child: TextField(
        //     controller: searchController,
        //     decoration: InputDecoration(
        //       hintText: "Search services...",
        //       hintStyle: TextStyle(
        //         fontFamily: 'Afacad',
        //         fontSize: 14.5,
        //         color: Colors.grey.shade400,
        //       ),
        //       prefixIcon: Icon(
        //         Icons.search_rounded,
        //         color: Colors.grey.shade400,
        //         size: 20,
        //       ),
        //       border: InputBorder.none,
        //       contentPadding: const EdgeInsets.symmetric(vertical: 14),
        //     ),
        //     style: const TextStyle(
        //       fontFamily: 'Afacad',
        //       fontSize: 15,
        //       color: ColorConstant.lightBlackColor,
        //     ),
        //   ),
        // ),

        CommonSearchTextFilled(controller: searchController,
        hintText:"Search services..." ,
        ),

        const SizedBox(height: 12),

        // Status Filter Picker Dropdown
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedFilter,
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey.shade500,
              ),
              style: const TextStyle(
                fontFamily: 'Afacad',
                fontSize: 14.5,
                color: ColorConstant.lightBlackColor,
              ),
              items: const [
                DropdownMenuItem<String>(
                  value: 'all',
                  child: Text('All Services'),
                ),
                DropdownMenuItem<String>(
                  value: 'active',
                  child: Text('Active Services'),
                ),
                DropdownMenuItem<String>(
                  value: 'inactive',
                  child: Text('Inactive Services'),
                ),
              ],
              onChanged: onFilterChanged,
            ),
          ),
        ),
      ],
    );
  }
}
