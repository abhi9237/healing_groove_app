import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final String name = doctor['name'] ?? '';
    final int id = doctor['id'] ?? 0;
    final String status = doctor['status'] ?? 'Approved';
    final String specialization = doctor['specialization'] ?? '';
    final String qualification = doctor['qualification'] ?? '';
    final int experience = doctor['experienceYears'] ?? 0;
    final int fee = doctor['consultationFee'] ?? 0;
    final String avatarUrl = doctor['avatarUrl'] ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Avatar, Name & ID, Status Badge)
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(avatarUrl),
                backgroundColor: Colors.grey.shade100,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    Text(
                      '$id',
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Subtitle list items (Specialization, Qualification, Experience)
          _buildDetailRow(Icons.psychology_outlined, specialization),
          const SizedBox(height: 8),
          _buildDetailRow(Icons.school_outlined, qualification),
          const SizedBox(height: 8),
          _buildDetailRow(Icons.work_outline_rounded, '$experience years experience'),
          const SizedBox(height: 16),

          // Consultation fee text
          Row(
            children: [
              const Text(
                'Consultation: ',
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              Text(
                '₹$fee',
                style: const TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF007A48),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Action buttons row (View, Edit, Delete)
          Row(
            children: [
              // View Button
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: onView,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF1F5F9), // light grey/white
                      foregroundColor: ColorConstant.lightBlackColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                      size: 16,
                      color: ColorConstant.lightBlackColor,
                    ),
                    label: const Text(
                      'View',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Edit Button
              InkWell(
                onTap: onEdit,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: ColorConstant.lightBlackColor,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Delete Button
              InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.redAccent,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey.shade600,
          size: 16,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }
}
