import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnquireNowController extends GetxController {
  final List<String> programs = [
    'Panchakarma Essential',
    'Immunity Boost',
    'Stress Management',
    'Detox & Weight Loss',
    'Panchakarma Essential',
    'Immunity Boost',
  ];

  int selectedProgramIndex = 2; // Default is 'Stress Management'
  DateTime? preferredStartDate;
  int guestCount = 1;
  final TextEditingController messageController = TextEditingController();

  String get formattedDate {
    if (preferredStartDate == null) {
      return 'mm/dd/yyyy';
    }
    final String month = preferredStartDate!.month.toString().padLeft(2, '0');
    final String day = preferredStartDate!.day.toString().padLeft(2, '0');
    final String year = preferredStartDate!.year.toString();
    return '$month/$day/$year';
  }

  void selectProgram(int index) {
    selectedProgramIndex = index;
    update();
  }

  void updateStartDate(DateTime date) {
    preferredStartDate = date;
    update();
  }

  void incrementGuests() {
    guestCount++;
    update();
  }

  void decrementGuests() {
    if (guestCount > 1) {
      guestCount--;
      update();
    }
  }

  void submitEnquiry(BuildContext context) {
    // Show a success message matching premium design
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Enquiry submitted successfully!',
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF08864F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
    // Go back
    Navigator.of(context).pop();
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
