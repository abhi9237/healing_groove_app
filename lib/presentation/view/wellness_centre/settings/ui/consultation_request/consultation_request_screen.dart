import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/controller/wellnesscentrecontroller/consultation_request_controller.dart';
import '../../../../../../../common/common_app_bar.dart';
import '../../../../../../../common/common_auth_background.dart';
import '../../../../../../../common/common_widget.dart';
import '../../../../../../../core/route/route_constant/route_constant.dart';
import 'widget/consultation_request_filters.dart';
import 'widget/consultation_request_card.dart';

class ConsultationRequestScreen extends StatelessWidget {
  const ConsultationRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<ConsultationRequestController>(
          init: ConsultationRequestController(),
          builder: (controller) {
            return Column(
              children: [
                // App Bar
                const CommonAppBar(
                  title: 'Consultation Requests',
                  showBackButton: true,
                ),

                // Filters panel (Search & dropdown)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ConsultationRequestFilters(
                    searchController: controller.searchController,
                    selectedStatus: controller.selectedStatus,
                    onSearchChanged: controller.onSearchChanged,
                    onStatusChanged: controller.onStatusChanged,
                  ),
                ),
                const SizedBox(height: 8),

                // Card List list view
                Expanded(
                  child: () {
                    if (controller.isLoading) {
                      return const Center(
                        child: CommonCircularIndicator(),
                      );
                    }

                    if (controller.filteredEnquiries.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline_rounded,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'No enquiries found',
                              style: TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      itemCount: controller.filteredEnquiries.length,
                      itemBuilder: (ctx, index) {
                        final doc = controller.filteredEnquiries[index];
                        return ConsultationRequestCard(
                          doc: doc,
                          onViewDetails: () {
                            context.push(
                              '${RouteConstant.enquiriesDetail}/${doc.id ?? '31'}',
                              extra: {'enquiryDetail': doc},
                            );
                          },
                        );
                      },
                    );
                  }(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
