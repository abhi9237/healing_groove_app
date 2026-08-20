import 'package:flutter/material.dart';
import 'package:custom_image_view/custom_image_view.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/controller/usercontroller/enquire_now_controller.dart';
import '../../../../../core/color_constant/color_constant.dart';
import '../../../../../core/image_constant/image_constant.dart';

class EnquireNowResortCard extends StatelessWidget {
  final EnquireNowController controller;

  const EnquireNowResortCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Resort Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: controller.centerDetail?.image?.url != null &&
                    controller.centerDetail!.image!.url!.isNotEmpty
                ? CustomImageView(
                    url: controller.centerDetail!.image!.url!,
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Image.asset(
                      ImageConstant.resortImg,
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
                    ImageConstant.resortImg,
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 16),
          
          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enquiring for',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.appColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.centerDetail?.name ?? 'Serenity Wellness Center',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: ColorConstant.greyColor.withValues(alpha: 0.7),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      controller.centerDetail != null
                          ? getLocation(
                              city: controller.centerDetail?.location?.city,
                              country: controller.centerDetail?.location?.country,
                              state: controller.centerDetail?.location?.state,
                            )
                          : 'Kerala, India',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.greyColor.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
