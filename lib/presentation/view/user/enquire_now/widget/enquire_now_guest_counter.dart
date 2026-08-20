import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/enquire_now_controller.dart';

class EnquireNowGuestCounter extends StatelessWidget {
  final EnquireNowController controller;

  const EnquireNowGuestCounter({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header Row
          Row(
            children: const [
              Icon(
                Icons.people_outline_rounded,
                color: ColorConstant.appColor,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                'Number of Guests',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Counter Widget
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Decrement Button
                IconButton(
                  icon: const Icon(
                    Icons.remove_rounded,
                    color: ColorConstant.appColor,
                    size: 26,
                  ),
                  onPressed: controller.guestCount > 1
                      ? controller.decrementGuests
                      : null,
                  disabledColor: Colors.grey.shade300,
                ),
                
                // Guest Count Display
                Text(
                  '${controller.guestCount}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
                
                // Increment Button
                IconButton(
                  icon: const Icon(
                    Icons.add_rounded,
                    color: ColorConstant.appColor,
                    size: 26,
                  ),
                  onPressed: controller.incrementGuests,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
