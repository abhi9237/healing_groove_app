import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';

class SupportRecentEnquiries extends StatelessWidget {
 final List<DocModel> recentEnquiries ;
  const SupportRecentEnquiries({super.key, required this.recentEnquiries});

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = recentEnquiries.isEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Enquiries',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
                Text(
                  '${recentEnquiries.length} Enquiries',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.greyColor.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          
          // Divider
          Divider(
            color: Colors.grey.shade200,
            thickness: 1,
            height: 1,
          ),

          if (isEmpty)
            // Body Content (Empty state)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 24.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Circular Chat Icon Container
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF4F6FB), // Light grey/blue background
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.forum_outlined,
                          color: Color(0xFF667085),
                          size: 26,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    const Text(
                      'No active enquiries',
                      style: TextStyle(
                          
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Description
                    Text(
                      'When you submit a request, it will appear here so you can track its progress.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: ColorConstant.greyColor.withValues(alpha: 0.8),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: recentEnquiries.length,
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(color: Colors.grey.shade100, height: 16),
              ),
              itemBuilder: (context, index) {
                final enquiry = recentEnquiries[index];
                final subject = enquiry.subject ?? 'No Subject';
                final message = enquiry.message ?? 'No Message';
                final status = enquiry.status ?? 'Pending';

                final bool isPending = status.toLowerCase() == 'pending';
                final bool isResolved = status.toLowerCase() == 'resolved' || status.toLowerCase() == 'completed';

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              subject,
                              style: const TextStyle(
                                  
                                fontSize: 15.5,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.lightBlackColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isResolved
                                  ? const Color(0xFFE8F5E9)
                                  : isPending
                                      ? const Color(0xFFFFF7ED)
                                      : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              status.toUpperCase(),
                              style: TextStyle(
                                  
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                                color: isResolved
                                    ? const Color(0xFF08864F)
                                    : isPending
                                        ? const Color(0xFFC2410C)
                                        : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        message,
                        style: TextStyle(
                            
                          fontSize: 13.5,
                          color: Colors.grey.shade700,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
