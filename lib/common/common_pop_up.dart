import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../core/color_constant/color_constant.dart';
import '../presentation/model/common/doc_model.dart';

class UpdateStatusPopUp extends StatefulWidget {
  final String bookingId;
  final String guestName;
  final String initialStatus;
  final Future<void> Function(
    int? doctor,
    String? type,
    String? dateTime,
    String status,
  )
  onSave;
  final List<DocModel>? doctors;
  final RxBool? isLoading;

  const UpdateStatusPopUp({
    super.key,
    required this.bookingId,
    required this.guestName,
    required this.initialStatus,
    required this.onSave,
    this.isLoading,
    this.doctors,
  });

  @override
  State<UpdateStatusPopUp> createState() => _UpdateStatusPopUpState();
}

class _UpdateStatusPopUpState extends State<UpdateStatusPopUp> {
  int? _selectedDoctorId;
  String? _selectedType;
  String? _selectedConsultationType;
  DateTime? _selectedDateTime;
  late String _selectedStatus;
  late final List<DocModel> _doctors;

  final List<Map<String, dynamic>> _consultationTypes = [
    {'title': 'In-Person Consultation', 'type': 'in-person'},
    {'title': 'Tele Consultation', 'type': 'tele'},
  ];

  final List<Map<String, dynamic>> _statusOptions = [
    {
      'status': 'Confirmed',
      'icon': Icons.check_circle_outline_rounded,
      'color': const Color(0xFF08864F),
      'type': 'confirmed',
    },
    {
      'status': 'In Progress',
      'icon': Icons.access_time_rounded,
      'color': const Color(0xFF1D4ED8),
      'type': 'in_progress',
    },
    {
      'status': 'Completed',
      'icon': Icons.check_circle_outline_rounded,
      'color': const Color(0xFF08864F),
      'type': 'completed',
    },
    {
      'status': 'Cancelled',
      'icon': Icons.cancel_outlined,
      'color': const Color(0xFFEF4444),
      'type': 'cancelled',
    },

  ];

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.initialStatus;
    _doctors = widget.doctors != null && widget.doctors!.isNotEmpty
        ? List<DocModel>.from(widget.doctors!)
        : [];

    // Filter out duplicates by ID if any
    final seen = <int>{};
    _doctors.retainWhere((doc) => doc.id != null && seen.add(doc.id!));

    _selectedDoctorId = _doctors.isNotEmpty ? _doctors[0].id : null;
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorConstant.appColor,
              onPrimary: Colors.white,
              onSurface: ColorConstant.lightBlackColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      if (!context.mounted) return;
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: ColorConstant.appColor,
                onPrimary: Colors.white,
                onSurface: ColorConstant.lightBlackColor,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayDateTimeText = _selectedDateTime != null
        ? DateFormat('MM/dd/yyyy, hh:mm a').format(_selectedDateTime!)
        : "mm /dd /yyyy , --:-- --";

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          // Close button x top right
          Positioned(
            right: 12,
            top: 12,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.close_rounded,
                color: Colors.grey.shade400,
                size: 24,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Details
                const Text(
                  "Update Booking Status",
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${widget.bookingId}  |  ${widget.guestName}",
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 12.5,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(color: Color(0xFFF1F5F9), thickness: 1.2),
                const SizedBox(height: 12),

                // Form Scroll Area
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 1. Assign doctor
                        const Text(
                          "Assign doctor",
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.lightBlackColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.2,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              hint: Text(
                                "— Select Doctor —",
                                style: TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 14.5,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              value:
                                  _doctors.any((d) => d.id == _selectedDoctorId)
                                  ? _selectedDoctorId
                                  : null,
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey.shade500,
                              ),
                              isExpanded: true,
                              items: _doctors.map((doc) {
                                return DropdownMenuItem<int>(
                                  value: doc.id,
                                  child: Text(
                                    doc.name ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'Afacad',
                                      fontSize: 14.5,
                                      color: ColorConstant.lightBlackColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectedDoctorId = val;
                                  log('selectedDoctorId: $_selectedDoctorId');
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 2. Consultation type
                        const Text(
                          "Consultation type",
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.lightBlackColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.2,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text(
                                "— Select Type —",
                                style: TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 14.5,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              value: _selectedType,
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey.shade500,
                              ),
                              isExpanded: true,
                              items: _consultationTypes.map((type) {
                                return DropdownMenuItem<String>(
                                  value: type['title'],
                                  child: Text(
                                    type['title'] ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'Afacad',
                                      fontSize: 14.5,
                                      color: ColorConstant.lightBlackColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectedType = val;
                                  _selectedConsultationType = _consultationTypes
                                      .firstWhere(
                                        (type) => type['title'] == val,
                                      )['type'];
                                  log(
                                    'selectedType ${_selectedConsultationType}',
                                  );
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 3. Slot date & time
                        const Text(
                          "Slot date & time",
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.lightBlackColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () => _pickDateTime(context),
                          child: Container(
                            height: 52,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 1.2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  displayDateTimeText,
                                  style: TextStyle(
                                    fontFamily: 'Afacad',
                                    fontSize: 14.5,
                                    color: _selectedDateTime != null
                                        ? ColorConstant.lightBlackColor
                                        : Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 4. New status selection list
                        const Text(
                          "New status",
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.lightBlackColor,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Column(
                          children: List.generate(_statusOptions.length, (
                            index,
                          ) {
                            final item = _statusOptions[index];
                            final String statusName = item['status'] as String;
                            final String statusType = item['type'] as String;
                            final IconData icon = item['icon'] as IconData;
                            final Color color = item['color'] as Color;

                            final isSelected =
                                _selectedStatus.toLowerCase() ==
                                    statusType.toLowerCase();

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedStatus = statusType;
                                  log('_selectedStatus ${_selectedStatus}');
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isSelected
                                        ? ColorConstant.appColor
                                        : const Color(0xFFE2E8F0),
                                    width: isSelected ? 1.8 : 1.2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(icon, color: color, size: 20),
                                    const SizedBox(width: 12),
                                    Text(
                                      statusName,
                                      style: const TextStyle(
                                        fontFamily: 'Afacad',
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.lightBlackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                const Divider(color: Color(0xFFF1F5F9), thickness: 1.2),
                const SizedBox(height: 16),

                // Save & Cancel Actions Row
                Row(
                  children: [
                    // Cancel
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFFE2E8F0),
                              width: 1.2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.lightBlackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Save Updates
                    Expanded(
                      child: Obx(
                        () => widget.isLoading?.value == true
                            ? const Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: ColorConstant.appColor,
                                    strokeWidth: 2.5,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await widget.onSave(
                                      _selectedDoctorId,
                                      _selectedConsultationType,
                                      _selectedDateTime != null
                                          ? DateFormat(
                                              'MM/dd/yyyy, hh:mm a',
                                            ).format(_selectedDateTime!)
                                          : null,
                                      _selectedStatus,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConstant.appColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    "Save updates",
                                    style: TextStyle(
                                      fontFamily: 'Afacad',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
