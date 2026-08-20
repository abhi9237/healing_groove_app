import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class CustomCalendarPicker extends StatefulWidget {
  final DateTime? initialSingleDate;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final bool isRangeMode;
  final Function(DateTime? singleDate, DateTime? startDate, DateTime? endDate, bool isRange) onApply;

  const CustomCalendarPicker({
    super.key,
    this.initialSingleDate,
    this.initialStartDate,
    this.initialEndDate,
    required this.isRangeMode,
    required this.onApply,
  });

  @override
  State<CustomCalendarPicker> createState() => _CustomCalendarPickerState();
}

class _CustomCalendarPickerState extends State<CustomCalendarPicker> {
  late bool _isRangeMode;
  DateTime? _selectedSingleDate;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  late DateTime _currentDisplayedMonth;

  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  static const List<String> _weekDays = ['SU', 'MO', 'TU', 'WE', 'TH', 'FR', 'SA'];

  @override
  void initState() {
    super.initState();
    _isRangeMode = widget.isRangeMode;
    _selectedSingleDate = widget.initialSingleDate;
    _selectedStartDate = widget.initialStartDate;
    _selectedEndDate = widget.initialEndDate;

    final today = DateTime.now();
    final initialDate = _isRangeMode 
        ? (_selectedStartDate ?? today)
        : (_selectedSingleDate ?? today);
    _currentDisplayedMonth = DateTime(initialDate.year, initialDate.month, 1);
  }

  bool _canGoBack() {
    final now = DateTime.now();
    final currentMonthStart = DateTime(now.year, now.month, 1);
    return _currentDisplayedMonth.isAfter(currentMonthStart);
  }

  void _prevMonth() {
    if (!_canGoBack()) return;
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

  void _onDateTapped(DateTime date) {
    setState(() {
      if (_isRangeMode) {
        if (_selectedStartDate == null) {
          _selectedStartDate = date;
          _selectedEndDate = null;
        } else if (_selectedEndDate == null) {
          if (date.isBefore(_selectedStartDate!)) {
            _selectedStartDate = date;
          } else {
            _selectedEndDate = date;
          }
        } else {
          _selectedStartDate = date;
          _selectedEndDate = null;
        }
      } else {
        _selectedSingleDate = date;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final year = _currentDisplayedMonth.year;
    final month = _currentDisplayedMonth.month;

    final firstWeekday = DateTime(year, month, 1).weekday;
    final emptySlots = firstWeekday == 7 ? 0 : firstWeekday;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final itemCount = emptySlots + daysInMonth;

    final monthName = _monthNames[month - 1];

    final today = DateTime.now();
    final todayDateOnly = DateTime(today.year, today.month, today.day);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header title
          const Text(
            'Select Dates',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
          const SizedBox(height: 16),

          // Mode Selector Toggle
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isRangeMode = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: !_isRangeMode ? ColorConstant.appColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Single Date',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: !_isRangeMode ? Colors.white : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isRangeMode = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: _isRangeMode ? ColorConstant.appColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Date Range',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _isRangeMode ? Colors.white : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Calendar Card
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
                // Header (Month & Navigation)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$monthName $year',
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _canGoBack() ? _prevMonth : null,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _canGoBack() ? const Color(0xFFE2E8F0) : Colors.grey.shade100,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.chevron_left_rounded,
                              size: 20,
                              color: _canGoBack() ? Colors.grey.shade700 : Colors.grey.shade300,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _nextMonth,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.chevron_right_rounded,
                              size: 20,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Days of Week Header
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
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),

                // Grid View of Days
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
                    final cellDateOnly = DateTime(year, month, day);
                    final isPast = cellDateOnly.isBefore(todayDateOnly);

                    Color cellBgColor = Colors.transparent;
                    Color cellTextColor = const Color(0xFF4A4A4A);
                    FontWeight cellFontWeight = FontWeight.normal;

                    if (isPast) {
                      cellTextColor = Colors.grey.shade300;
                    } else {
                      if (_isRangeMode) {
                        if (_selectedStartDate != null && _selectedEndDate != null) {
                          if (cellDateOnly.isAtSameMomentAs(_selectedStartDate!) ||
                              cellDateOnly.isAtSameMomentAs(_selectedEndDate!)) {
                            cellBgColor = ColorConstant.appColor;
                            cellTextColor = Colors.white;
                            cellFontWeight = FontWeight.bold;
                          } else if (cellDateOnly.isAfter(_selectedStartDate!) &&
                              cellDateOnly.isBefore(_selectedEndDate!)) {
                            cellBgColor = ColorConstant.appColor.withValues(alpha: 0.15);
                            cellTextColor = ColorConstant.appColor;
                            cellFontWeight = FontWeight.bold;
                          }
                        } else if (_selectedStartDate != null &&
                            cellDateOnly.isAtSameMomentAs(_selectedStartDate!)) {
                          cellBgColor = ColorConstant.appColor;
                          cellTextColor = Colors.white;
                          cellFontWeight = FontWeight.bold;
                        }
                      } else {
                        if (_selectedSingleDate != null &&
                            cellDateOnly.isAtSameMomentAs(_selectedSingleDate!)) {
                          cellBgColor = ColorConstant.appColor;
                          cellTextColor = Colors.white;
                          cellFontWeight = FontWeight.bold;
                        }
                      }
                    }

                    return GestureDetector(
                      onTap: isPast ? null : () => _onDateTapped(cellDateOnly),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: cellBgColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$day',
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 14,
                            fontWeight: cellFontWeight,
                            color: cellTextColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(
                      _selectedSingleDate,
                      _selectedStartDate,
                      _selectedEndDate,
                      _isRangeMode,
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.appColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
