import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:intl/intl.dart' as f;

class DetailRequirementsCard extends StatelessWidget {
  final DocModel detailData;

  const DetailRequirementsCard({super.key, required this.detailData});

  @override
  Widget build(BuildContext context) {
    final String enquiryType = detailData.speciality ?? detailData.sourceType ?? 'Consultation';
    final String selectedPackage = detailData.package?.name ?? 'My Custom Wellness Plan';

    String startDate = '';
    if (detailData.startDate != null) {
      try {
        final date = DateTime.parse(detailData.startDate!).toLocal();
        startDate = f.DateFormat('d/M/yyyy').format(date);
      } catch (e) {
        startDate = detailData.startDate!;
      }
    }

    final String startTime = detailData.slotTime?.toString() ?? '10:00 AM';
    final String duration = detailData.package?.duration != null ? '${detailData.package!.duration} days' : '1 day';

    return Container(
      padding: const EdgeInsets.all(20.0),
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row 1: Enquiry Type Header
              Row(
                children: [
                  const Icon(
                    Icons.eco_rounded, // Leaf/nature icon
                    color: ColorConstant.appColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'ENQUIRY TYPE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.appColor.withValues(alpha: 0.8),
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                enquiryType,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
              const SizedBox(height: 18),

              // Your Requirements Label
              Text(
                'YOUR REQUIREMENTS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.appColor.withValues(alpha: 0.7),
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 10),
              Divider(color: Colors.grey.shade100, thickness: 1, height: 1),
              const SizedBox(height: 16),

              // Selected Package Card (Green container)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: ColorConstant.appColor,
                  borderRadius: BorderRadius.circular(18),
                  gradient: CommonGradientColor.packageBackgroundGradient,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SELECTED PACKAGE',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withValues(alpha: 0.7),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selectedPackage,
                            style: const TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Start Date & Start Time Cards Row
              Row(
                children: [
                  // Start Date Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFF5F7FA,
                        ), // Light blue-grey tint background
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'START DATE',
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade500,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_rounded,
                                color: ColorConstant.appColor,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                startDate,
                                style: const TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstant.lightBlackColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Start Time Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F7FA),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'START TIME',
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade500,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                color: ColorConstant.appColor,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                startTime,
                                style: const TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstant.lightBlackColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Duration Container Card
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Row(
                  children: [
                    // Small stopwatch icon circle
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFFECFDF3),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.timer_outlined,
                          color: ColorConstant.appColor,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'DURATION',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.greyColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      duration,
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 140,
            child: CustomImageView(
              imagePath: ImageConstant.heartIcon,
              height: 60,
              width: 60,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
