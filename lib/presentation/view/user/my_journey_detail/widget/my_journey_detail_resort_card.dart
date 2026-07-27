import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import '../../../../../core/image_constant/image_constant.dart';
import 'package:healing/controller/my_journey_detail_controller.dart';

class MyJourneyDetailResortCard extends StatelessWidget {
  final MyJourneyDetailController controller;

  const MyJourneyDetailResortCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack with Overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: controller.imageUrl.isNotEmpty
                      ? Image.network(
                          controller.imageUrl,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            ImageConstant.resortImg,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          ImageConstant.resortImg,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                
                // TOP RATED Badge Overlay
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF08864F),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'TOP RATED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Resort Name & Location
            Text(
              controller.resortName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: ColorConstant.appColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    controller.location,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: ColorConstant.greyColor.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Rating and Avatars Row
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFEBB81A),
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  '${controller.rating} (${controller.reviewsCount} reviews)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ColorConstant.greyColor.withValues(alpha: 0.8),
                  ),
                ),
                const Spacer(),
                
                // Stacked Reviewer Avatars
                SizedBox(
                  width: 44,
                  height: 22,
                  child: Stack(
                    children: const [
                      Positioned(
                        left: 0,
                        child: CircleAvatar(
                          radius: 11,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=150',
                          ),
                        ),
                      ),
                      Positioned(
                        left: 14,
                        child: CircleAvatar(
                          radius: 11,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=150',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Divider
            Divider(color: Colors.grey.shade100, height: 1),
            const SizedBox(height: 12),
            
            // Contact rows
            _buildContactRow(
              icon: Icons.phone_outlined,
              text: controller.phone,
            ),
            const SizedBox(height: 10),
            _buildContactRow(
              icon: Icons.mail_outline_rounded,
              text: controller.email,
            ),
            const SizedBox(height: 10),
            _buildContactRow(
              icon: Icons.home_outlined,
              text: controller.address,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF475569),
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorConstant.greyColor.withValues(alpha: 0.9),
            ),
          ),
        ),
      ],
    );
  }
}
