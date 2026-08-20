import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../../common/common_text_form_filled.dart';
import '../../../../../controller/wellnesscentrecontroller/add_new_program_controller.dart';
import '../../../../../core/color_constant/color_constant.dart';

class ProgramSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final ProgramStatus selectedState;
  final List<ProgramStatus> status;
  final ValueChanged<ProgramStatus?> onStateChanged;

  const ProgramSearchBar({
    super.key,
    required this.searchController,
    required this.selectedState,
    required this.status,
    required this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        CommonSearchTextFilled(controller: searchController,
          hintText:"Search services..." ,
        ),

        const SizedBox(height: 12),

        // Availability State Picker
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ProgramStatus>(
              value: selectedState,
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
              items: status.map((state) {
                return DropdownMenuItem<ProgramStatus>(
                  value: state,
                  child: Text(state.text ?? ''),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  onStateChanged(value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
