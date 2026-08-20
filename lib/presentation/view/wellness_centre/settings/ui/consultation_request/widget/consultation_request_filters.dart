import 'package:flutter/material.dart';
import 'package:healing/common/common_text_form_filled.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class ConsultationRequestFilters extends StatelessWidget {
  final TextEditingController searchController;
  final String selectedStatus;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onStatusChanged;

  const ConsultationRequestFilters({
    super.key,
    required this.searchController,
    required this.selectedStatus,
    required this.onSearchChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Input
        CommonSearchTextFilled(
          hintText: 'Search by enquiry ID or guest name...',
          controller: searchController,
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: 12),

        // Status Dropdown selector card
        Container(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedStatus,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey,
              ),
              isExpanded: true,
              style: const TextStyle(
                fontFamily: 'Afacad',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorConstant.lightBlackColor,
              ),
              onChanged: onStatusChanged,
              items: <String>[
                'All Status',
                'Pending',
                'Converted',
                'Under Review',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
