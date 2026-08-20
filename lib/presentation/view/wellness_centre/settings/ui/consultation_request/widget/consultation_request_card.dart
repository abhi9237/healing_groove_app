import 'package:flutter/material.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:intl/intl.dart' as f;

class ConsultationRequestCard extends StatelessWidget {
  final DocModel doc;
  final VoidCallback onViewDetails;

  const ConsultationRequestCard({
    super.key,
    required this.doc,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Status Pill configuration
    final String status = (doc.status ?? 'PENDING').toLowerCase();
    Color statusBgColor;
    Color statusTextColor;
    
    switch (status) {
      case 'converted':
        statusBgColor = const Color(0xFFE8F5E9); // light green
        statusTextColor = const Color(0xFF2E7D32); // dark green
        break;
      case 'under review':
        statusBgColor = const Color(0xFFF1F5F9); // light grey
        statusTextColor = const Color(0xFF475569); // dark grey
        break;
      case 'pending':
      default:
        statusBgColor = const Color(0xFFEFF6FF); // light blue
        statusTextColor = const Color(0xFF1D4ED8); // dark blue
        break;
    }

    // 2. Date Formatting
    String submittedDate = 'N/A';
    if (doc.createdAt != null) {
      try {
        final date = DateTime.parse(doc.createdAt!).toLocal();
        submittedDate = f.DateFormat('d/M/yyyy').format(date);
      } catch (_) {
        submittedDate = doc.createdAt!;
      }
    }

    // 3. Name Parsing
    String guestName = 'Pappu Kumar Yadav';
    if (doc.user?.name != null) {
      guestName = doc.user!.name!;
    } else if (doc.enquiries?.guestDetails != null && doc.enquiries!.guestDetails!.isNotEmpty) {
      guestName = doc.enquiries!.guestDetails!.first.name ?? 'Pappu Kumar Yadav';
    }

    // 4. Doctor Name Parsing
    String doctorName = 'Dr. Abhishek Shukla';
    if (doc.doctors != null && doc.doctors!.isNotEmpty) {
      doctorName = doc.doctors!.first.name ?? 'Dr. Abhishek Shukla';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row (ENQ-ID, Status Pill, Eye Icon)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'ENQ-${doc.id ?? '31'}',
                    style: const TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: statusTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onViewDetails,
                child: const Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Guest Name & Subtitle
          Text(
            guestName,
            style: const TextStyle(
              fontFamily: 'Afacad',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Consultation',
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),

          const Divider(color: Color(0xFFF1F5F9), height: 1),
          const SizedBox(height: 12),

          // Footer info (SUBMITTED, DOCTOR)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SUBMITTED',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    submittedDate,
                    style: const TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'DOCTOR',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    doctorName,
                    style: const TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
