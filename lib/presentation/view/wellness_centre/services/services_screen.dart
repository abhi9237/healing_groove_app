import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_app_bar.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/common/common_widget.dart';
import 'package:healing/controller/wellnesscentrecontroller/services_controller.dart';
import 'widget/services_search_bar.dart';
import 'widget/services_list_view.dart';
import 'widget/fixed_add_services_button.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<ServicesController>(
          init: ServicesController(),
          builder: (controller) {
            return Column(
              children: [
                const CommonAppBar(title: 'Services', showBackButton: true),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ServicesSearchBar(
                    searchController: controller.searchController,
                    selectedFilter: controller.selectedServiceFilter,
                    onFilterChanged: controller.onFilterChanged,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        controller.isLoading
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 40.0),
                                  child: CommonCircularIndicator(),
                                ),
                              )
                            : ServicesListView(
                                services: controller.filteredServices,
                                controller: controller,
                              ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: GetBuilder<ServicesController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: FixedAddServicesButton(
              onTap: () => controller.addServices(context),
            ),
          );
        },
      ),
    );
  }
}
