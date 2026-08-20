import 'package:flutter/material.dart';
import 'package:healing/controller/usercontroller/user_home_controller.dart';
import '../../../../../core/color_constant/color_constant.dart';

class UserHomeStats extends StatelessWidget {
  final UserHomeController controller;
  const UserHomeStats({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        // Subtitle text
        Center(
          child: Text(
            "Here's where things stand today.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorConstant.greyColor,
            ),
          ),
        ),
        const SizedBox(height: 18),
        // Stat cards row
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            children: [
              // Active Journeys Card
              _buildStatCard(
                title: 'ACTIVE\nJOURNEYS',
                value: controller.activeJourneyCount,
                icon: Icons.location_on_rounded,
                iconColor: ColorConstant.appColor,
                iconBgColor: const Color(0xFFE2F7EB),
              ),
              const SizedBox(width: 16),

              // My Packages Card
              _buildStatCard(
                title: 'MY\nPACKAGES',
                value: controller.myPackagesCount,
                icon: Icons.inventory_2_rounded,
                iconColor: const Color(0xFFC78E17),
                iconBgColor: const Color(0xFFFFF7E6),
              ),
              const SizedBox(width: 16),
              // My Packages Card
              _buildStatCard(
                title: 'Saved Centre',
                value: controller.savedCentreCount,
                icon: Icons.save,
                iconColor:  ColorConstant.appColor,
                iconBgColor: ColorConstant.appColor.withValues(alpha: 0.1),
              ),
              const SizedBox(width: 16),
              // My Packages Card
              _buildStatCard(
                title: 'Enquire Count',
                value: controller.enquireCount,
                icon: Icons.query_builder,
                iconColor: const Color(0xFFC78E17),
                iconBgColor: const Color(0xFFFFF7E6),
              ),

            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
  }) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.greyColor,
                    height: 1.2,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
        ],
      ),
    );
  }
}
