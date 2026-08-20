import 'package:flutter/material.dart';
import 'package:healing/controller/wellnesscentrecontroller/add_new_program_controller.dart';
import '../../../../../core/color_constant/color_constant.dart';

class AvailableDatesPicker extends StatelessWidget {
  final AddNewProgramController controller;

  const AvailableDatesPicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final displayedMonth = controller.currentDisplayedMonth;
    final year = displayedMonth.year;
    final month = displayedMonth.month;

    // Calendar grid calculations matching BookProgramSelectDate format
    final firstWeekday = DateTime(year, month, 1).weekday; // 1 = Mon, 7 = Sun
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final emptySlots = firstWeekday - 1;
    final itemCount = emptySlots + daysInMonth;

    final monthName = AddNewProgramController.monthNames[month - 1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Available Dates",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorConstant.lightBlackColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Select the specific dates when this program can start. Booked dates are shown in red and cannot be removed.",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade500,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 16),

        // Calendar Container Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => controller.prevMonth(),
                    icon: Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    '$monthName $year',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.nextMonth(),
                    icon: Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Days of week header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: controller.weekDays
                    .map((day) => _CalendarDayHeader(text: day))
                    .toList(),
              ),
              const SizedBox(height: 12),

              // Dynamic Month Grid View (7 columns)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: itemCount,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  if (index < emptySlots) {
                    return const SizedBox.shrink();
                  }

                  final day = index - emptySlots + 1;
                  final cellDate = DateTime(year, month, day);
                  final isSelected = controller.isDateSelected(cellDate);
                  
                  final now = DateTime.now();
                  final currentDate = DateTime(now.year, now.month, now.day);
                  final isPast = cellDate.isBefore(currentDate);

                  return GestureDetector(
                    onTap: isPast ? null : () => controller.selectDate(cellDate),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorConstant.appColor
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "$day",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isPast 
                              ? Colors.grey.shade400
                              : isSelected
                                  ? Colors.white
                                  : const Color(0xFF414943),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CalendarDayHeader extends StatelessWidget {
  final String text;
  const _CalendarDayHeader({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade400,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
