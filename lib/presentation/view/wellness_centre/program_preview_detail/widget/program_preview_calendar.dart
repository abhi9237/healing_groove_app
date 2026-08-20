import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';

class ProgramPreviewCalendar extends StatefulWidget {
  final DocModel program;
  final Set<DateTime> availableDates;

  const ProgramPreviewCalendar({
    super.key,
    required this.program,
    required this.availableDates,
  });

  @override
  State<ProgramPreviewCalendar> createState() => _ProgramPreviewCalendarState();
}

class _ProgramPreviewCalendarState extends State<ProgramPreviewCalendar> {
  late DateTime _currentDisplayedMonth;

  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  static const List<String> _weekDays = ['SU', 'MO', 'TU', 'WE', 'TH', 'FR', 'SA'];

  @override
  void initState() {
    super.initState();
    // Default to the current month
    final now = DateTime.now();
    _currentDisplayedMonth = DateTime(now.year, now.month, 1);
  }

  void _prevMonth() {
    setState(() {
      _currentDisplayedMonth = DateTime(
        _currentDisplayedMonth.year,
        _currentDisplayedMonth.month - 1,
        1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      _currentDisplayedMonth = DateTime(
        _currentDisplayedMonth.year,
        _currentDisplayedMonth.month + 1,
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final year = _currentDisplayedMonth.year;
    final month = _currentDisplayedMonth.month;

    // Calendar grid calculations (1 = Mon, 7 = Sun)
    // To match Sun as first column, we convert weekday to 0-indexed where 0 = Sun
    final firstWeekday = DateTime(year, month, 1).weekday; 
    final emptySlots = firstWeekday == 7 ? 0 : firstWeekday; // Sun is 7 in DateTime, maps to 0 empty slots
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final itemCount = emptySlots + daysInMonth;

    final monthName = _monthNames[month - 1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Availability Calendar Title Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF), // very light blue
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xFF1D4ED8),
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Availability Calendar',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Optimized for desktop editor. Select dates in full view.',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 11.5,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Calendar Card Box
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.01),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header Row (Month & Arrows)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$monthName $year',
                    style: const TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _prevMonth,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.chevron_left_rounded,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _nextMonth,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.chevron_right_rounded,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Days of week row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _weekDays.map((day) {
                  return SizedBox(
                    width: 32,
                    child: Text(
                      day,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              // Grid of days
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
                  
                  final today = DateTime.now();
                  final todayDateOnly = DateTime(today.year, today.month, today.day);
                  final cellDateOnly = DateTime(year, month, day);
                  final isPast = cellDateOnly.isBefore(todayDateOnly);

                  // Check if this date is in our set of available dates
                  final isAvailable = widget.availableDates.any(
                    (d) => d.year == cellDate.year && d.month == cellDate.month && d.day == cellDate.day,
                  );

                  Color cellBgColor = Colors.transparent;
                  Color cellTextColor = const Color(0xFF4A4A4A);
                  FontWeight cellFontWeight = FontWeight.normal;

                  if (isPast) {
                    if (isAvailable) {
                      cellBgColor = ColorConstant.lightGreenColor;
                      cellTextColor = ColorConstant.appColor;
                      cellFontWeight = FontWeight.bold;
                    } else {
                      cellTextColor = Colors.grey.shade400;
                    }
                  } else {
                    if (isAvailable) {
                      cellBgColor = ColorConstant.appColor;
                      cellTextColor = Colors.white;
                      cellFontWeight = FontWeight.bold;
                    } else {
                      cellTextColor = const Color(0xFF4A4A4A);
                    }
                  }

                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: cellBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$day',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 12.5,
                        fontWeight: cellFontWeight,
                        color: cellTextColor,
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
