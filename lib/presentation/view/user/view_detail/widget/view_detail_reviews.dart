import 'package:flutter/material.dart';
import 'package:healing/controller/view_detail_controller.dart';
import 'package:healing/core/color_constant/color_constant.dart';

import '../../../../../common/common_methods.dart';
import '../../../../../common/common_widget.dart';

class ViewDetailReviews extends StatelessWidget {
  final ViewDetailController controller;
  const ViewDetailReviews({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final docs = controller.centerDetail.reviews?.docs;
    if (docs == null || docs.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Guest Reviews',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
          const SizedBox(height: 16),

          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index];
              return _buildReviewCard(
                name: data.authorName ?? '',
                date: getMonthYear(data.createdAt),
                rating: data.rating ?? 0,
                comment: data.text ?? '',
                avatarUrl:
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=150&auto=format&fit=crop',
              );
            },
          ),
          const SizedBox(height: 16),

          // Read All Reviews Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: ColorConstant.appColor,
                  width: 1.5,
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Read All Reviews',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.appColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard({
    required String name,
    required String date,
    required int rating,
    required String comment,
    required String avatarUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4FD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatar(name: name),

              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.greyColor.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),

              // Stars
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star_rounded,
                    color: index < rating
                        ? const Color(0xFFEBB81A)
                        : Colors.grey.shade300,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Comment Text
          Text(
            comment,
            style: const TextStyle(
              fontSize: 13,
              color: ColorConstant.greyColor,
              height: 1.3,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}
