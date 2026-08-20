import 'package:flutter/material.dart';
import 'package:healing/presentation/model/common/image_model.dart';
import '../../add_new_program/widget/basic_info_fields.dart';
import '../../../../../core/color_constant/color_constant.dart';

class SettingsGallery extends StatelessWidget {
  final List<ImageModel> gallery;
  final VoidCallback onAddImage;

  const SettingsGallery({
    super.key,
    required this.gallery,
    required this.onAddImage,
  });

  @override
  Widget build(BuildContext context) {
    final int count = gallery.length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.photo_library_outlined,
                    color: ColorConstant.appColor,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Gallery ($count/6)',
                    style: const TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onAddImage,
                child: const Text(
                  'ADD IMAGE',
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.appColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 2x3 Grid layout
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.15,
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
                // Upload trigger slot
                return InkWell(
                  onTap: onAddImage,
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
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.add,
                        color: Colors.grey.shade400,
                        size: 28,
                      ),
                    ),
                  ),
                );
              }

              // Subtract 1 since index 0 is the add button
              final galleryIndex = index - 1;

              if (galleryIndex < count) {
                // Show uploaded thumbnail image
                final item = gallery[galleryIndex];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    item.url ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade100,
                        child: const Icon(
                          Icons.broken_image_outlined,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                );
              } else {
                // Empty placeholder slot
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 12),

          // Footer subtext
          Center(
            child: Text(
              'Supported formats: JPG, PNG. Max 5MB each.',
              style: TextStyle(
                fontFamily: 'Afacad',
                fontSize: 11.5,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
