import 'package:flutter/material.dart';

class AddDoctorNotice extends StatelessWidget {
  const AddDoctorNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF007A48), // Solid green card
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.admin_panel_settings_outlined,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin Approval Required',
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'New doctors are created under your center. Profile changes are saved immediately.',
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 12,
                    color: Color(0xFFC2E8D7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
