import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/settings_controller.dart';

class SettingsNotificationsCard extends StatelessWidget {
  const SettingsNotificationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title Row
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFFECFDF3),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.notifications_none_rounded,
                    color: ColorConstant.appColor,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'NOTIFICATIONS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.appColor,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Main Card containing rows
          GetBuilder<SettingsController>(
            init: SettingsController(),
            builder: (controller) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Row 1: Booking Updates
                    _buildToggleRow(
                      icon: Icons.confirmation_number_outlined, // Ticket icon representation
                      iconBgColor: const Color(0xFFEFF8FF),
                      iconColor: const Color(0xFF175CD3),
                      title: 'Booking updates',
                      subtitle: 'Real-time status changes',
                      value: controller.bookingUpdates,
                      onChanged: (val) => controller.toggleBookingUpdates(val),
                    ),
                    _buildDivider(),

                    // Row 2: Journey Reminders
                    _buildToggleRow(
                      icon: Icons.spa_outlined, // Meditating spa icon
                      iconBgColor: const Color(0xFFF9F5FF),
                      iconColor: const Color(0xFF7F56D9),
                      title: 'Journey reminders',
                      subtitle: 'Preparation & session tips',
                      value: controller.journeyReminders,
                      onChanged: (val) => controller.toggleJourneyReminders(val),
                    ),
                    _buildDivider(),

                    // Row 3: Wellness Offers
                    _buildToggleRow(
                      icon: Icons.auto_awesome_outlined, // Sparkles icon
                      iconBgColor: const Color(0xFFFEF3C7),
                      iconColor: const Color(0xFFB45309),
                      title: 'Wellness offers',
                      subtitle: 'Curated retreats & paths',
                      value: controller.wellnessOffers,
                      onChanged: (val) => controller.toggleWellnessOffers(val),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Left Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                icon,
                color: iconColor,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Details text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.greyColor,
                  ),
                ),
              ],
            ),
          ),

          // Custom Green Checkbox
          GestureDetector(
            onTap: () => onChanged(!value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: value ? ColorConstant.appColor : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: value ? ColorConstant.appColor : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: value
                  ? const Center(
                      child: Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(
        color: Colors.grey.shade100,
        thickness: 1,
        height: 1,
      ),
    );
  }
}
