import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/controller/usercontroller/view_detail_controller.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import '../../../../../common/common_methods.dart';
import '../../../../../core/route/route_constant/route_constant.dart';

class ViewDetailPricingCard extends StatelessWidget {
  final ViewDetailController controller;
  const ViewDetailPricingCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'STARTING FROM',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: ColorConstant.greyColor.withValues(alpha: 0.6),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            controller.calculateServicePrice(
              controller.centerProgramDetail.packages
                  ?.firstOrNull
                  ?.services ??
                  [],
            ),
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: ColorConstant.appColor,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'per person / package',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: ColorConstant.greyColor.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 20),

          // Enquire Now Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.push(
                  RouteConstant.enquireNow,
                  extra: {
                    'center': controller.centerDetail,
                    'packages': controller.centerProgramDetail.packages,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.appColor,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Enquire Now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Cancellation text
          Text(
            'Free cancellation up to 14 days',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ColorConstant.greyColor.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 12),

          // // Divider
          // Divider(color: Colors.grey.shade100, height: 1),
          // const SizedBox(height: 12),
          //
          // // Talk to Care Guide Link
          // InkWell(
          //   onTap: () {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(
          //         content: Text('Connecting to a Care Guide...'),
          //         duration: Duration(seconds: 2),
          //       ),
          //     );
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: const [
          //       Icon(
          //         Icons.chat_bubble_outline_rounded,
          //         color: ColorConstant.appColor,
          //         size: 18,
          //       ),
          //       SizedBox(width: 8),
          //       Text(
          //         'Talk to Care Guide',
          //         style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.bold,
          //           color: ColorConstant.appColor,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
