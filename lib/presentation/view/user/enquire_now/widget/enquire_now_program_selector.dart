import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/enquire_now_controller.dart';

class EnquireNowProgramSelector extends StatelessWidget {
  final EnquireNowController controller;

  const EnquireNowProgramSelector({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header Row
          Row(
            children: const [
              Icon(
                Icons.spa_outlined,
                color: ColorConstant.appColor,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                'Select Healing Program',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Wrap of Program tags
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              controller.programs.length,
              (index) {
                final bool isSelected = controller.selectedProgramIndex == index;
                final String programName = controller.programs[index];
                
                return GestureDetector(
                  onTap: () => controller.selectProgram(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? ColorConstant.appColor : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? ColorConstant.appColor
                            : Colors.grey.shade300,
                        width: 1.2,
                      ),
                    ),
                    child: Text(
                      programName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : ColorConstant.lightBlackColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
