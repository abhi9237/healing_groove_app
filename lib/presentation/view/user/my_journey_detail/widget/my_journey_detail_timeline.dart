import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/my_journey_detail_controller.dart';

class MyJourneyDetailTimeline extends StatelessWidget {
  final MyJourneyDetailController controller;

  const MyJourneyDetailTimeline({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final steps = controller.timelineSteps;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              children: const [
                Icon(
                  Icons.timeline_rounded,
                  color: ColorConstant.appColor,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Journey Timeline',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Vertical steps
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: steps.length,
              itemBuilder: (context, index) {
                final step = steps[index];
                final bool isLast = index == steps.length - 1;
                
                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Circle & Connecting Line
                      Column(
                        children: [
                          _buildStepIndicator(step, index),
                          if (!isLast)
                            Expanded(
                              child: Container(
                                width: 2,
                                color: step['isCompleted']
                                    ? const Color(0xFF08864F)
                                    : Colors.grey.shade200,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      
                      // Text Description & Badge
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      step['title'],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: step['status'] == 'UPCOMING'
                                            ? Colors.grey.shade400
                                            : ColorConstant.lightBlackColor,
                                      ),
                                    ),
                                  ),
                                  _buildStatusBadge(step['status']),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                step['subtitle'],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: step['status'] == 'UPCOMING'
                                      ? Colors.grey.shade400
                                      : ColorConstant.greyColor.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(Map<String, dynamic> step, int index) {
    Color bgColor;
    Color iconColor;
    IconData icon;
    
    if (step['isCompleted']) {
      bgColor = const Color(0xFFE2F7EB);
      iconColor = const Color(0xFF08864F);
      icon = Icons.check_circle_rounded;
    } else if (step['status'] == 'CANCELLED') {
      bgColor = const Color(0xFFF1F5F9);
      iconColor = Colors.grey;
      icon = Icons.cancel_outlined;
    } else if (step['isActive']) {
      bgColor = const Color(0xFFFFF7ED);
      iconColor = const Color(0xFFE58B0E);
      icon = Icons.credit_card_outlined;
    } else {
      bgColor = const Color(0xFFF1F5F9);
      iconColor = Colors.grey.shade400;
      icon = index == 2 ? Icons.airplanemode_active_rounded : Icons.check_circle_outline_rounded;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: step['isCompleted']
              ? const Color(0xFF08864F)
              : (step['status'] == 'CANCELLED' ? Colors.grey : (step['isActive'] ? const Color(0xFFE58B0E) : Colors.grey.shade200)),
          width: 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        color: iconColor,
        size: 16,
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    if (status == 'UPCOMING') return const SizedBox.shrink();
    
    Color bgColor;
    Color textColor;
    if (status == 'DONE') {
      bgColor = const Color(0xFFE2F7EB);
      textColor = const Color(0xFF08864F);
    } else if (status == 'CANCELLED') {
      bgColor = const Color(0xFFF1F5F9);
      textColor = Colors.grey;
    } else {
      bgColor = const Color(0xFFFFF7ED);
      textColor = const Color(0xFFE58B0E);
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
