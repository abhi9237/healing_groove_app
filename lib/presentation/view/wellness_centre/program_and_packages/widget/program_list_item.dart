import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import '../../../../../core/color_constant/color_constant.dart';

class ProgramListItem extends StatelessWidget {
  final DocModel program;
  final VoidCallback onPreviewTap;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;
  final bool isDeleting;

  const ProgramListItem({
    super.key,
    required this.program,
    required this.onPreviewTap,
    required this.onEditTap,
    required this.onDeleteTap,
    this.isDeleting = false,
  });

  @override
  Widget build(BuildContext context) {
    final String name = program.name ?? program.title ?? '';
    final String rawStatus = (program.approvalStatus ?? program.status ?? 'draft').toLowerCase();
    
    final String status;
    if (rawStatus == 'pending_approval' || rawStatus == 'pending') {
      status = 'Pending Approval';
    } else if (rawStatus == 'draft') {
      status = 'Draft Mode';
    } else if (rawStatus == 'live') {
      status = 'Live';
    } else {
      status = rawStatus.toUpperCase();
    }

    final String description = program.description ?? '';
    final String category = 'Wellness';
    final String duration = program.durationText ?? (program.duration != null ? '${program.duration} days' : '1 day');
    final int? rawPrice = program.services?.fold<int>(
      0,
          (sum, service) => sum + (service.basePrice ?? 0),
    );
    log('${program.price  }');
    log('${program.basePrice  }');
    log('${program.minPrice  }');
    final String price = '₹$rawPrice';
    final String doctorsCount = '${program.doctors?.length ?? 0} Doctors';
    final IconData icon = Icons.spa_outlined;

    final isPending = status.toLowerCase().contains('pending');

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
          // Header: Icon + Name + Status tag
          Row(
            children: [
              // Icon Box
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9), // light green
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: ColorConstant.appColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),

              // Title & Status
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isPending
                            ? const Color(0xFFFFF7ED) // Orange background
                            : const Color(0xFFF1F5F9), // Grey background
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: isPending
                              ? const Color(0xFFC2410C) // Orange text
                              : Colors.grey.shade600, // Grey text
                        ),
                      ),
                    ),
                  ],
                ),
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
              color: Colors.grey.shade700,
              height: 1.35,
            ),
          ),

          const SizedBox(height: 20),

          // Details Grid (2 columns, 2 rows)
          Row(
            children: [
              // Row 1 / Col 1
              Expanded(
                child: _buildGridItem(
                  icon: icon,
                  value: category,
                ),
              ),
              // Row 1 / Col 2
              Expanded(
                child: _buildGridItem(
                  icon: Icons.access_time_rounded,
                  value: duration,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Row 2 / Col 1
              Expanded(
                child: _buildGridItem(
                  icon: Icons.account_balance_wallet_outlined,
                  value: price,
                ),
              ),
              // Row 2 / Col 2
              Expanded(
                child: _buildGridItem(
                  icon: Icons.people_outline_rounded,
                  value: doctorsCount,
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(
              color: Color(0xFFF1F5F9),
              thickness: 1.2,
              height: 1,
            ),
          ),

          // Bottom Action Row
          Row(
            children: [
              // Preview Details Button
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: onPreviewTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF08864F),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.visibility_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Preview Details",
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Edit Button
              GestureDetector(
                onTap: onEditTap,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.grey.shade700,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Delete Button
              GestureDetector(
                onTap: isDeleting ? null : onDeleteTap,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
                  ),
                  child: isDeleting
                      ? const Center(
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ),
                        )
                      : Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red.shade600,
                          size: 18,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem({required IconData icon, required String value}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Color(0xFFEFF6FF), // very light blue background
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: const Color(0xFF1D4ED8), // blue icon
            size: 14,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Afacad',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: ColorConstant.lightBlackColor,
          ),
        ),
      ],
    );
  }
}
