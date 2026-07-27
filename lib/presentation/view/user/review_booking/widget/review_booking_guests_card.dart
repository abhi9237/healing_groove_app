import 'package:flutter/material.dart';
import 'package:healing/controller/book_program_controller.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class ReviewBookingGuestsCard extends StatelessWidget {
  final BookProgramController controller;

  const ReviewBookingGuestsCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final guestCount = controller.guests.isEmpty ? 1 : controller.guests.length;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.people_outline_rounded,
                      color: ColorConstant.appColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'GUESTS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.appColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '$guestCount ${guestCount == 1 ? 'Guest' : 'Guests'}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.appColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey.shade200, height: 1),

          // Guest List
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: List.generate(
                controller.guests.length,
                (index) {
                  final guest = controller.guests[index];
                  final name = guest.nameController.text.trim().isNotEmpty
                      ? guest.nameController.text.trim()
                      : '';
                  final age = guest.ageController.text.trim().isNotEmpty
                      ? guest.ageController.text.trim()
                      : '';
                  final gender = guest.selectedGender.isNotEmpty
                      ? guest.selectedGender
                      : '';
                  final initialLetter = name.isNotEmpty ? name[0].toUpperCase() : 'A';

                  final isMale = gender.toLowerCase() == 'male';

                  return Container(
                    margin: EdgeInsets.only(
                      bottom: index == controller.guests.length - 1 ? 0 : 12,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F8F5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        // Avatar Circle with initial
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD8EBE1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            initialLetter,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.appColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Name and Subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.lightBlackColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '$age yrs • $gender',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Gender Icon
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: isMale ? const Color(0xFFEEF2FF) : const Color(0xFFFCE7F3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isMale ? Icons.male_rounded : Icons.female_rounded,
                            color: isMale ? const Color(0xFF6366F1) : const Color(0xFFEC4899),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
