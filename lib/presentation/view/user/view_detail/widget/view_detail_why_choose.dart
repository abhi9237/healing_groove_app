import 'package:flutter/material.dart';
import 'package:healing/controller/usercontroller/view_detail_controller.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class ViewDetailWhyChoose extends StatelessWidget {
  final ViewDetailController controller;
  const ViewDetailWhyChoose({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final amenities = controller.centerDetail.amenities;
    if (amenities == null || amenities.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Why Choose This Centre',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
          const SizedBox(height: 16),

          // Two parallel boxes row
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: amenities.length,
              itemBuilder: (context, index) {
                var data = amenities[index];
                return Container(
                  width: 110,
                  margin: EdgeInsets.only(right: 5),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F4FD),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.eco_rounded,
                        color: ColorConstant.appColor,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.label ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.lightBlackColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        data.description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: ColorConstant.greyColor.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Box 3: Award
          // Container(
          //   padding: const EdgeInsets.all(16.0),
          //   decoration: BoxDecoration(
          //     color: const Color(0xFFF4FAF6),
          //     borderRadius: BorderRadius.circular(16),
          //     border: Border.all(color: const Color(0xFFE2EFE7)),
          //   ),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Icon(
          //         Icons.stars_rounded,
          //         color: ColorConstant.appColor,
          //         size: 30,
          //       ),
          //       const SizedBox(width: 12),
          //       Expanded(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             const Text(
          //               'Voted #1 Retreat in Kerala 2024',
          //               style: TextStyle(
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.bold,
          //                 color: ColorConstant.lightBlackColor,
          //               ),
          //             ),
          //             const SizedBox(height: 4),
          //             Text(
          //               'Awarded for excellence in authentic Panchakarma treatments and holistic patient care.',
          //               style: TextStyle(
          //                 fontSize: 12,
          //                 color: ColorConstant.greyColor.withValues(alpha: 0.8),
          //                 height: 1.3,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
