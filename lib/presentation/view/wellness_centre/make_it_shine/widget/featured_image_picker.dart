import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/color_constant/color_constant.dart';
import '../../../../../controller/wellnesscentrecontroller/setup_center_detail_controller.dart';

class FeaturedImagePicker extends StatelessWidget {
  final SetupCenterDetailController controller;

  const FeaturedImagePicker({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Featured Image (optional)',
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B), // Grey text
          ),
        ),
        const SizedBox(height: 12),

        Obx(() {
          final imageFile = controller.featuredImage.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => controller.showImagePickerBottomSheet(context),
                child: Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFBFB),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: ColorConstant.appColor.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                  ),
                  child: imageFile != null
                      ? Stack(
                          children: [
                            // Image Preview
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.file(
                                imageFile,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Semi-transparent Overlay to ensure clear button is visible
                            Positioned(
                              top: 12,
                              right: 12,
                              child: GestureDetector(
                                onTap: () {
                                  controller.removeImage();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.upload_rounded,
                              color: ColorConstant.appColor,
                              size: 40,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Click to upload image',
                              style: TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.lightBlackColor,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'JPG, PNG, WebP — max 5 MB',
                              style: TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: 13,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // Choose file from device
              GestureDetector(
                onTap: () => controller.showImagePickerBottomSheet(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.upload_file_rounded,
                      color: ColorConstant.appColor,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Choose file from computer',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.appColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
