import 'package:flutter/material.dart';
import '../../add_new_program/widget/basic_info_fields.dart';
import '../../../../../core/color_constant/color_constant.dart';

class SettingsFeaturedImage extends StatelessWidget {
  final dynamic newFeaturedImageFile;
  final String? featuredImageUrl;
  final VoidCallback onPick;

  const SettingsFeaturedImage({
    super.key,
    this.newFeaturedImageFile,
    this.featuredImageUrl,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;
    if (newFeaturedImageFile != null) {
      imageProvider = FileImage(newFeaturedImageFile);
    } else if (featuredImageUrl != null && featuredImageUrl!.isNotEmpty) {
      imageProvider = NetworkImage(featuredImageUrl!);
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9), // Light green
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 14,
                        color: ColorConstant.appColor,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Primary Listing Photo',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.appColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Dashed Upload Box
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: InkWell(
              onTap: onPick,
              borderRadius: BorderRadius.circular(16),
              child: CustomPaint(
                painter: DashedRectPainter(
                  color: Colors.grey.shade300,
                  strokeWidth: 1.5,
                  gap: 6.0,
                  rx: 16.0,
                  ry: 16.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: imageProvider != null
                        ? DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: imageProvider != null
                      ? null
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEFF6FF), // light blue
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add_a_photo_outlined,
                                color: Color(0xFF1D4ED8),
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Featured Image',
                              style: TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.lightBlackColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'No image uploaded yet',
                              style: TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
