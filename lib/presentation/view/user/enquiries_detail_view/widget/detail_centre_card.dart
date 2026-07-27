import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/common/common_methods.dart';
import 'package:intl/intl.dart' as f;

class DetailCentreCard extends StatelessWidget {
  final DocModel detailData;

  const DetailCentreCard({
    super.key,
    required this.detailData,
  });

  @override
  Widget build(BuildContext context) {
    final String centreName = detailData.center?.name ?? detailData.title ?? detailData.name ?? 'Wellness Centre';

    final String locationStr = getLocation(
      address: detailData.location?.address ?? detailData.center?.location?.address,
      city: detailData.location?.city ?? detailData.center?.location?.city,
      state: detailData.location?.state ?? detailData.center?.location?.state,
      country: detailData.location?.country ?? detailData.center?.location?.country,
    );

    String submittedAt = '';
    if (detailData.createdAt != null) {
      try {
        final date = DateTime.parse(detailData.createdAt!).toLocal();
        submittedAt = f.DateFormat('d/M/yyyy, hh:mm:ss a').format(date);
      } catch (e) {
        submittedAt = detailData.createdAt!;
      }
    }

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Centre Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circular Location Pin Icon Container
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: Color(0xFFECFDF3), // Mint green circular background
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.location_on_rounded,
                    color: ColorConstant.appColor,
                    size: 26,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Centre details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CENTRE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.appColor.withValues(alpha: 0.7),
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      centreName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    if (locationStr.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        '• $locationStr',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorConstant.greyColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(
              color: Colors.grey.shade100,
              thickness: 1,
              height: 1,
            ),
          ),

          // Row 2: Submitted At Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circular Clock Icon Container
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F4F7), // Light grey circular background
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.access_time_rounded,
                    color: Color(0xFF667085),
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Submitted time details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SUBMITTED AT',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.greyColor,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      submittedAt,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
