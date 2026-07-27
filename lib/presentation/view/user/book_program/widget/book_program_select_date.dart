import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healing/controller/book_program_controller.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class BookProgramSelectDate extends StatelessWidget {
  final BookProgramController controller;

  const BookProgramSelectDate({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final displayedMonth = controller.currentDisplayedMonth;
    final year = displayedMonth.year;
    final month = displayedMonth.month;

    // Calendar grid calculations
    final firstWeekday = DateTime(year, month, 1).weekday; // 1 = Mon, 7 = Sun
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final emptySlots = firstWeekday - 1;
    final itemCount = emptySlots + daysInMonth;

    final monthName = BookProgramController.monthNames[month - 1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row with Calendar Icon
        Row(
          children: const [
            Icon(
              Icons.calendar_month_rounded,
              color: ColorConstant.appColor,
              size: 22,
            ),
            SizedBox(width: 8),
            Text(
              'Select Date',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Calendar White Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Month Header Row: < Month Year >
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

              // Dynamic Month Grid View
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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

                  final isAvailable = controller.isDateAvailable(cellDate);
                  final isSelected = controller.isDateSelected(cellDate);

                  return GestureDetector(
                    onTap: isAvailable
                        ? () => controller.selectDate(cellDate)
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorConstant
                                  .appColor // AppColor for selected date
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$day',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected || isAvailable
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? Colors.white
                              : (isAvailable
                                    ? ColorConstant.lightBlackColor
                                    : Colors
                                          .grey
                                          .shade300), // Grey for unavailable dates
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Status Alert Pill Banner
        if (controller.selectedDate != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              (controller.seatsData.remaining ?? 0) >= 1000
                  ? 'All seats are available'
                  : (controller.seatsData.remaining ?? 0) <= 0
                  ? 'All seats are booked'
                  : '${controller.selectedDate!.year}-${controller.selectedDate!.month.toString().padLeft(2, '0')}-${controller.selectedDate!.day.toString().padLeft(2, '0')}: Available (${controller.seatsData.remaining} seat(s) left)',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: ColorConstant.appColor,
              ),
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
