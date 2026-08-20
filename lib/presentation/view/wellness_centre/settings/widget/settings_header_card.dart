import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class SettingsHeaderCard extends StatelessWidget {
  final String centerName;
  final String? featuredImageUrl;
  final dynamic newFeaturedImageFile;
  final VoidCallback onEditPhoto;

  const SettingsHeaderCard({
    super.key,
    required this.centerName,
    this.featuredImageUrl,
    this.newFeaturedImageFile,
    required this.onEditPhoto,
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
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF007A48), // Dark green
            Color(0xFF0A5C37), // Even darker green
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // Round profile with pencil overlay
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  color: Colors.grey.shade100,
                  image: imageProvider != null
                      ? DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: imageProvider == null
                    ? const Icon(
                        Icons.business_rounded,
                        size: 40,
                        color: Colors.grey,
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onEditPhoto,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: ColorConstant.appColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Center name
          Text(
            centerName.isEmpty ? 'Mohali Center' : centerName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Afacad',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),

          // Subtitle
          const Text(
            'Manage your center’s public identity, media, and contact details.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 13,
              color: Color(0xFFC2E8D7),
            ),
          ),
        ],
      ),
    );
  }
}
