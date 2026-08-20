import 'package:flutter/material.dart';
import '../../../../../common/common_text_form_filled.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/enquiries_and_bookings_controller.dart';

class EnquiriesHeaderDescription extends StatelessWidget {
  const EnquiriesHeaderDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Track all your wellness centre enquiries and their current status.',
        style: TextStyle(
          fontFamily: 'Afacad',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: ColorConstant.greyColor,
          height: 1.3,
        ),
      ),
    );
  }
}

class EnquiriesSearchFilters extends StatelessWidget {
  final EnquiriesAndBookingsController controller;

  const EnquiriesSearchFilters({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonSearchTextFilled(
            controller: controller.searchController,
            onChanged: controller.updateSearchQuery,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedStatus,
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey.shade500,
                        size: 24,
                      ),
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstant.lightBlackColor,
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.updateStatusFilter(newValue);
                        }
                      },
                      items:
                          <String>[
                            'All Status',
                            'Pending',
                            'Converted',
                            'Under review',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),
              // const SizedBox(width: 12),
              // Container(
              //   width: 52,
              //   height: 52,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(16),
              //     border: Border.all(color: Colors.grey.shade200),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withValues(alpha: 0.02),
              //         blurRadius: 10,
              //         offset: const Offset(0, 4),
              //       ),
              //     ],
              //   ),
              //   child: Material(
              //     color: Colors.transparent,
              //     child: InkWell(
              //       borderRadius: BorderRadius.circular(16),
              //       onTap: () {
              //         // Just reset filters or show a simple toast as placeholder
              //       },
              //       child: const Center(
              //         child: Icon(
              //           Icons.filter_list_rounded,
              //           color: ColorConstant.lightBlackColor,
              //           size: 24,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
