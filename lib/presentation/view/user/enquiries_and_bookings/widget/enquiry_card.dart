import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/common/common_methods.dart';
import 'package:intl/intl.dart' as f;
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/enquiries_and_bookings_controller.dart';

class EnquiryCard extends StatelessWidget {
  final DocModel enquiry;
  final VoidCallback? onTap;

  const EnquiryCard({
    super.key,
    required this.enquiry,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EnquiriesAndBookingsController>();

    final String statusText = capitalizeFirstLetter(enquiry.status ?? 'pending');
    final String relativeTime = controller.timeAgo(enquiry.updatedAt ?? enquiry.createdAt);

    final String title = enquiry.center?.name ?? enquiry.title ?? enquiry.name ?? 'Wellness Centre';

    final String locationStr = getLocation(
      address: enquiry.location?.address ?? enquiry.center?.location?.address,
      city: enquiry.location?.city ?? enquiry.center?.location?.city,
      state: enquiry.location?.state ?? enquiry.center?.location?.state,
      country: enquiry.location?.country ?? enquiry.center?.location?.country,
    );

    String formattedDate = '';
    final dateStr = enquiry.startDate ?? enquiry.createdAt;
    if (dateStr != null) {
      try {
        final parsedDate = DateTime.parse(dateStr).toLocal();
        formattedDate = f.DateFormat('d/M/yyyy').format(parsedDate);
      } catch (e) {
        formattedDate = dateStr;
      }
    }

    // Determine colors and icons based on status
    Color statusBgColor;
    Color statusTextColor;
    IconData statusIcon;

    switch (statusText.toLowerCase()) {
      case 'converted':
        statusBgColor = const Color(0xFFECFDF3);
        statusTextColor = const Color(0xFF027A48);
        statusIcon = Icons.check_circle_outline_rounded;
        break;
      case 'under review':
        statusBgColor = const Color(0xFFF2F4F7);
        statusTextColor = const Color(0xFF344054);
        statusIcon = Icons.help_outline_rounded;
        break;
      case 'pending':
      default:
        statusBgColor = const Color(0xFFEFF8FF);
        statusTextColor = const Color(0xFF175CD3);
        statusIcon = Icons.access_time_rounded;
        break;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade100, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: ID Tag and Status Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Enquiry ID Tag
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF3), // Mint/light green
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'ENQ-${enquiry.id}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF027B49), // Medium-dark green
                      ),
                    ),
                  ),

                  // Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          statusIcon,
                          size: 15,
                          color: statusTextColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: statusTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Title and Chevron Right
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.lightBlackColor,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: ColorConstant.appColor,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Location Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      locationStr,
                      style: const TextStyle(

                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorConstant.greyColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Divider
              Divider(
                color: Colors.grey.shade100,
                thickness: 1,
                height: 1,
              ),
              const SizedBox(height: 10),

              // Footer Row: Date and Updated At
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorConstant.greyColor,
                        ),
                      ),
                    ],
                  ),

                  // Updated At
                  Text(
                    relativeTime,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
