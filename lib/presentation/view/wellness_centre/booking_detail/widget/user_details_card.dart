import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import '../../../../../presentation/model/common/doc_model.dart';
import '../../../../../presentation/model/common/guests_model.dart';

class UserDetailsCard extends StatelessWidget {
  final DocModel booking;

  const UserDetailsCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final List<GuestsModel> guestsList = booking.guests ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "GUEST DETAILS",
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: ColorConstant.appColor,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: guestsList.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: guestsList.length,
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(color: Color(0xFFF1F5F9), thickness: 1, height: 1),
                  ),
                  itemBuilder: (context, index) {
                    final guest = guestsList[index];
                    return _buildGuestItem(guest.fullName ?? 'Guest', guest.age, guest.gender ?? '—', index + 1);
                  },
                )
              : _buildFallbackGuestItem(booking),
        ),
      ],
    );
  }

  Widget _buildGuestItem(String name, int? ageVal, String gender, int guestIndex) {
    final String ageStr = ageVal != null ? '$ageVal years' : '—';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Guest Name Header
        Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: ColorConstant.appColor.withValues(alpha: 0.1),
              child: Text(
                "$guestIndex",
                style: const TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.appColor,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 15.5,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Age & Gender Info Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildInfoField(
                icon: Icons.calendar_today_rounded,
                label: "AGE",
                value: ageStr,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoField(
                icon: Icons.wc_rounded,
                label: "GENDER",
                value: gender,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFallbackGuestItem(DocModel booking) {
    final String name = booking.user?.name ?? 'Guest';
    final int? ageVal = booking.user?.age ?? booking.age;
    final String gender = booking.user?.gender ?? booking.gender ?? '—';

    return _buildGuestItem(name, ageVal, gender, 1);
  }

  Widget _buildInfoField({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.grey.shade400,
          size: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
