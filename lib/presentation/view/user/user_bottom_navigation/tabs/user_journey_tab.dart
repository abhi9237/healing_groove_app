import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';


class UserJourneyTab extends StatelessWidget {
  const UserJourneyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Healing Journey',
          style: TextStyle(
            fontSize: 22,
            color: ColorConstant.lightBlackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Journey Progress Summary Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detox program progress',
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorConstant.greyColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          '65% Completed',
                          style: TextStyle(
                            fontSize: 20,
                            color: ColorConstant.appColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const LinearProgressIndicator(
                            value: 0.65,
                            minHeight: 8,
                            backgroundColor: Color(0xFFE2F7EB),
                            valueColor: AlwaysStoppedAnimation<Color>(ColorConstant.appColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2F7EB),
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorConstant.appColor, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.emoji_events_rounded,
                      color: ColorConstant.appColor,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Timeline header
            const Text(
              'Milestones & Schedule',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
            const SizedBox(height: 20),

            // Timeline Items
            _buildTimelineItem(
              title: 'Healing Profile Assessment',
              time: 'Completed',
              desc: 'Identified root stressors and structured initial diet parameters.',
              isFirst: true,
              isLast: false,
              isCompleted: true,
            ),
            _buildTimelineItem(
              title: 'Sound Resonance & Vibrations',
              time: 'Completed',
              desc: 'Introductory sound bath relaxation and chakra mapping.',
              isFirst: false,
              isLast: false,
              isCompleted: true,
            ),
            _buildTimelineItem(
              title: 'Ayurvedic Detox & Panchakarma',
              time: 'In Progress',
              desc: 'Active physical cleansing phase, diet restriction active.',
              isFirst: false,
              isLast: false,
              isCompleted: false,
              isActive: true,
            ),
            _buildTimelineItem(
              title: 'Integrative Mindful Living',
              time: 'Upcoming',
              desc: 'Yoga techniques and breath-work sessions for daily balance.',
              isFirst: false,
              isLast: true,
              isCompleted: false,
            ),

            const SizedBox(height: 100), // Spacing for floating bottom bar
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String time,
    required String desc,
    required bool isFirst,
    required bool isLast,
    required bool isCompleted,
    bool isActive = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator column
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? ColorConstant.appColor
                      : (isActive ? Colors.white : Colors.grey.shade300),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted || isActive
                        ? ColorConstant.appColor
                        : Colors.grey.shade300,
                    width: 2.5,
                  ),
                ),
                alignment: Alignment.center,
                child: isCompleted
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : (isActive
                        ? Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: ColorConstant.appColor,
                              shape: BoxShape.circle,
                            ),
                          )
                        : null),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.5,
                    color: isCompleted ? ColorConstant.appColor : Colors.grey.shade300,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),

          // Content card column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isActive
                                ? ColorConstant.appColor
                                : ColorConstant.lightBlackColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? const Color(0xFFE2F7EB)
                              : (isActive ? const Color(0xFFFFF3E0) : Colors.grey.shade100),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          time,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isCompleted
                                ? ColorConstant.appColor
                                : (isActive ? Colors.orange.shade700 : Colors.grey.shade600),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstant.greyColor.withOpacity(0.9),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
