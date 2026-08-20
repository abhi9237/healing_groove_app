import 'package:flutter/material.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/common/common_methods.dart';
import 'package:intl/intl.dart' as f;
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/my_journey_controller.dart';

class MyJourneyCard extends StatelessWidget {
  final DocModel booking;
  final MyJourneyController controller;

  const MyJourneyCard({
    super.key,
    required this.booking,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final String status = (booking.status ?? 'REQUESTED').toUpperCase();
    
    // Status color selection
    Color badgeColor;
    if (status == 'CONFIRMED') {
      badgeColor = const Color(0xFF08864F);
    } else if (status == 'COMPLETED') {
      badgeColor = const Color(0xFF495560);
    } else if (status == 'CANCELLED') {
      badgeColor = const Color(0xFFD32F2F);
    } else {
      // REQUESTED, etc.
      badgeColor = const Color(0xFFE58B0E);
    }

    final String displayId = booking.bookingId != null
        ? booking.bookingId.toString()
        : (booking.id != null ? booking.id.toString() : '');

    final String locationStr = getLocation(
      address: booking.center?.location?.address,
      city: booking.center?.location?.city,
      state: booking.center?.location?.state,
      country: booking.center?.location?.country,
    );

    String formattedDate = '';
    if (booking.startDate != null) {
      try {
        final parsedDate = DateTime.parse(booking.startDate!).toLocal();
        formattedDate = f.DateFormat('d/M/yyyy').format(parsedDate);
      } catch (e) {
        formattedDate = booking.startDate!;
      }
    }

    final int durationDays = booking.package?.duration ?? 0;
    final int guestCount = booking.guests != null && booking.guests!.isNotEmpty
        ? booking.guests!.length
        : (booking.groupSize ?? 1);

    final String imageUrl = booking.center?.image?.url ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            ImageConstant.imageNotFound,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          ImageConstant.imageNotFound,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                
                // Status Badge Overlay
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Details Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Booking ID
                  Text(
                    'Booking #$displayId',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.lightBlackColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Location and Resort Info
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: ColorConstant.greyColor.withValues(alpha: 0.5),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${booking.center?.name ?? ''} •',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: ColorConstant.greyColor.withValues(alpha: 0.8),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              locationStr,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: ColorConstant.greyColor.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Meta Info Row (Date, Duration, Guests)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Date Info
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: ColorConstant.greyColor.withValues(alpha: 0.6),
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.greyColor.withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ),
                      
                      // Duration Info
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: ColorConstant.greyColor.withValues(alpha: 0.6),
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '$durationDays days',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.greyColor.withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ),
                      
                      // Guests Info
                      Row(
                        children: [
                          Icon(
                            Icons.people_outline_rounded,
                            color: ColorConstant.greyColor.withValues(alpha: 0.6),
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '$guestCount Guest${guestCount > 1 ? 's' : ''}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.greyColor.withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Action Buttons
                  Row(
                    children: [
                      // View Details Button
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () =>
                                controller.viewDetails(context, booking),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.appColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'View Details',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Message Guide Button
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () =>
                                controller.messageGuide(context, displayId),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  color: ColorConstant.lightBlackColor,
                                  size: 16,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Message Guide',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstant.lightBlackColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
