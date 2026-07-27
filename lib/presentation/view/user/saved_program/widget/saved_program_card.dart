import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_button.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';

import '../../../../../core/image_constant/image_constant.dart';

class SavedProgramCard extends StatelessWidget {
  final int id;
  final String title;
  final double rating;
  final int ratingCount;
  final String location;
  final String duration;
  final String nextAvailable;
  final String imagePath;
  final String programName;
  final bool isVerified;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTapViewDetail;

  const SavedProgramCard({
    super.key,
    required this.id,
    required this.title,
    required this.rating,
    required this.ratingCount,
    required this.location,
    required this.duration,
    required this.nextAvailable,
    required this.imagePath,
    required this.programName,
    required this.isVerified,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onTapViewDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: imagePath.isNotEmpty
                    ? SizedBox(
                        width: context.width,
                        height: 200,
                        child: CustomImageView(
                          url: imagePath,
                          fit: BoxFit.cover,
                          height: 200,
                          width: MediaQuery.sizeOf(context).width,
                          errorWidget: (_, _, _) => Image.asset(
                            height: 200,
                            ImageConstant.imageNotFound,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      )
                    : Image.asset(
                        height: 200,
                        width: context.width,
                        ImageConstant.imageNotFound,
                        fit: BoxFit.fitWidth,
                      ),
              ),

              if (isVerified)
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.appColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'VERIFIED',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Top-Right Favorite Heart Icon (Green filled when active, unfilled otherwise)
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: onFavoriteTap,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isFavorite
                          ? ColorConstant.appColor
                          : Colors.grey.shade600,
                      size: 22,
                    ),
                  ),
                ),
              ),

              // Bottom-Left Program Badge
              Positioned(
                bottom: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    programName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
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
                // Title and Rating row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.lightBlackColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Rating Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2F6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: ColorConstant.appColor,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$rating ($ratingCount)',
                            style: const TextStyle(
                              color: ColorConstant.lightBlackColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Location row
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: ColorConstant.appColor,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 14,
                        color: ColorConstant.greyColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Duration & Next Available Row
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DURATION',
                          style: TextStyle(
                            fontSize: 11,
                            color: ColorConstant.greyColor.withValues(
                              alpha: 0.6,
                            ),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          duration,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.lightBlackColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                CommonButton(
                  buttonText: 'View Details',
                  onTap: onTapViewDetail,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
