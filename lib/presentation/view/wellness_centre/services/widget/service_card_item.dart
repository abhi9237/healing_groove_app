import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';

class ServiceCardItem extends StatelessWidget {
  final DocModel service;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  const ServiceCardItem({
    super.key,
    required this.service,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    final String name = service.name ?? service.title ?? 'Unnamed Service';
    final String category = service.speciality ?? 'GENERAL';
    final String description = service.description ?? 'No description provided.';
    final String priceText = '₹${service.basePrice ?? 0}';
    final IconData icon = Icons.spa_outlined; // Fallback icon as it was dynamically set

    final isSignature = category.toLowerCase() == 'signature';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Category Icon Circle
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isSignature
                      ? const Color(0xFFEFF6FF) // blue for signature
                      : const Color(0xFFE8F5E9), // green for normal
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isSignature ? const Color(0xFF1D4ED8) : ColorConstant.appColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),

              // Title and Tag
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isSignature
                            ? const Color(0xFFFFF7ED) // light orange
                            : const Color(0xFFE8F5E9), // light green
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: isSignature
                              ? ColorConstant.orangeColor
                              : ColorConstant.appColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Right Actions (Edit, Delete)
              Row(
                children: [
                  GestureDetector(
                    onTap: onEditTap,
                    child: Icon(
                      Icons.edit_outlined,
                      color: Colors.grey.shade400,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: onDeleteTap,
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red.shade300,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Description Paragraph
          Text(
            description,
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 13.5,
              color: Colors.grey.shade600,
              height: 1.35,
            ),
          ),

          const SizedBox(height: 20),

          // Bottom Info Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left price details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "INVESTMENT",
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    priceText,
                    style: const TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 16.5,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.appColor,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}
