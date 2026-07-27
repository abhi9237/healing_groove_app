import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';

class SettingsAccountOptions extends StatelessWidget {
  const SettingsAccountOptions({super.key});

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
                    Icons.person_outline_rounded,
                    color: ColorConstant.appColor,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'ACCOUNT',
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

          // Option 1: Profile & password
          _buildOptionCard(
            icon: Icons.person_outline_rounded,
            iconColor: ColorConstant.appColor,
            iconBgColor: const Color(0xFFECFDF3),
            title: 'Profile & password',
            subtitle: 'Name, contact, wellness goals, security',
            onTap: () {
              context.push(RouteConstant.editProfile);
            },
          ),
          const SizedBox(height: 12),
          _buildOptionCard(
            icon: Icons.favorite_border,
            iconColor: ColorConstant.appColor,
            iconBgColor: const Color(0xFFECFDF3),
            title: 'Saved Centers',
            subtitle: 'Save programs to review and book later',
            onTap: () {
              context.push(RouteConstant.savedProgram);
            },
          ),
          const SizedBox(height: 12),

          // Option 2: Help & support
          _buildOptionCard(
            icon: Icons.help_outline_rounded,
            iconColor: const Color(0xFF667085),
            iconBgColor: const Color(0xFFF2F4F7),
            title: 'Help & support',
            subtitle: 'Contact our team about bookings',
            onTap: () {
              context.push(RouteConstant.helpSupport);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
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
                  child: Center(child: Icon(icon, color: iconColor, size: 20)),
                ),
                const SizedBox(width: 14),

                // Text details
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

                // Arrow right
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey.shade400,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
