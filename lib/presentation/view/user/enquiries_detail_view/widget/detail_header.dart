import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:intl/intl.dart' as f;

class DetailHeader extends StatelessWidget {
  final DocModel detailData;

  const DetailHeader({
    super.key,
    required this.detailData,
  });

  @override
  Widget build(BuildContext context) {
    final String status = (detailData.status ?? 'PENDING').toUpperCase();
    final String title = detailData.subject ?? detailData.title ?? 'Consultation Request';

    String submittedDate = '';
    if (detailData.createdAt != null) {
      try {
        final date = DateTime.parse(detailData.createdAt!).toLocal();
        submittedDate = f.DateFormat('d/M/yyyy').format(date);
      } catch (e) {
        submittedDate = detailData.createdAt!;
      }
    }

    Color badgeColor;
    switch (status) {
      case 'CONVERTED':
        badgeColor = const Color(0xFF008B5C);
        break;
      case 'UNDER REVIEW':
        badgeColor = const Color(0xFF667085);
        break;
      case 'PENDING':
      default:
        badgeColor = const Color(0xFF175CD3);
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ENQUIRY DETAILS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: ColorConstant.appColor.withValues(alpha: 0.8),
                letterSpacing: 1.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                status,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: ColorConstant.lightBlackColor,
            letterSpacing: -0.5,
          ),
        ),
        if (submittedDate.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            'Submitted on $submittedDate',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorConstant.greyColor,
            ),
          ),
        ],
      ],
    );
  }
}
