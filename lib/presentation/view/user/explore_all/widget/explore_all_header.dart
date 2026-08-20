import 'package:flutter/material.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/explore_all_controller.dart';
import 'custom_calendar_picker.dart';

class ExploreAllHeader extends StatelessWidget {
  final ExploreAllController controller;
  const ExploreAllHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE4F3EC),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Explore Wellness Centres\nAcross India',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),

          // Divider Line
          Container(
            width: 40,
            height: 2,
            decoration: BoxDecoration(
              color: ColorConstant.appColor,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          const SizedBox(height: 12),

          if (controller.uniqueCentres.isNotEmpty)
            Text(
              '${controller.uniqueCentres.length} centres available.\nFind your perfect healing retreat',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: ColorConstant.greyColor,
                height: 1.3,
              ),
            ),
          const SizedBox(height: 24),

          // Dropdown 1: What brings you here?
          _buildDropdownField(
            context: context,
            label: 'What brings you here?',
            value: controller.selectedReason,
            hint: 'e.g. Panchakarma, Yoga, Stress Relief...',
            onTap: () {
              List options = [];
              options = [
                ...controller.packagesList.map(
                  (pkg) => pkg.name ?? pkg.title ?? '',
                ),
                ...controller.packagesList
                    .expand((pkg) => pkg.services ?? [])
                    .map((service) => service.name ?? service.title ?? ''),
              ].where((name) => name.isNotEmpty).toList();
              _showSelectionBottomSheet(
                context: context,
                title: 'What brings you here?',
                options: options,
                selectedValue: controller.selectedReason,
                onSelect: (val) => controller.updateReason(val),
              );
            },
          ),
          const SizedBox(height: 16),

          // Dropdown 2: Destination
          _buildDropdownField(
            context: context,
            label: 'Destination',
            value: controller.selectedDestination,
            hint: 'Search city or region...',
            onTap: () {
              List options = [];
              options = controller.packagesList
                  .map((pkg) {
                    final city = pkg.center?.location?.city?.trim() ?? '';
                    final state = pkg.center?.location?.state?.trim() ?? '';

                    if (city.isEmpty && state.isEmpty) return '';

                    if (city.isEmpty) return state;
                    if (state.isEmpty) return city;

                    return '$city, $state';
                  })
                  .where((name) => name.isNotEmpty)
                  .toSet()
                  .toList();
              _showSelectionBottomSheet(
                context: context,
                title: 'Destination',
                options: options,
                selectedValue: controller.selectedDestination,
                onSelect: (val) => controller.updateDestination(val),
              );
            },
          ),
          const SizedBox(height: 16),

          // Dropdown 3: When are you going?
          _buildDropdownField(
            context: context,
            label: 'When are you going?',
            value: controller.selectedWhen,
            hint: 'Select Dates',
            onTap: () => _showCalendarBottomSheet(context),
          ),
          const SizedBox(height: 24),

          // Search Button
          ElevatedButton.icon(
            onPressed: () {
              if (controller.selectedReason.isEmpty ||
                  controller.selectedDestination.isEmpty ||
                  controller.selectedWhen.isEmpty) {
                showToastMessage(
                  titleMessage: 'Error',
                  message: 'Please select any program',
                  context: context,
                  isError: true,
                );
                return;
              }

              controller.triggerSearch();
            },
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: 22,
            ),
            label: const Text(
              'Search',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.appColor,
              elevation: 4,
              shadowColor: ColorConstant.appColor.withValues(alpha: 0.3),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
    required String value,
    required String hint,
    required VoidCallback onTap,
  }) {
    final bool hasValue = value.isNotEmpty && value != hint;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorConstant.greyColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hasValue ? value : hint,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: hasValue ? FontWeight.w700 : FontWeight.w500,
                      color: hasValue
                          ? ColorConstant.lightBlackColor
                          : ColorConstant.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: ColorConstant.greyColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectionBottomSheet({
    required BuildContext context,
    required String title,
    required List options,
    required String selectedValue,
    required ValueChanged<String> onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true, // Shows over the bottom navigation bar
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 16.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (options.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 12.0,
                          ),
                          child: Text(
                            'no program found',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorConstant.greyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      else
                        ...options.map((option) {
                          final bool isSelected = option == selectedValue;
                          return ListTile(
                            title: Text(
                              option,
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? ColorConstant.appColor
                                    : ColorConstant.lightBlackColor,
                              ),
                            ),
                            trailing: isSelected
                                ? const Icon(
                                    Icons.check_rounded,
                                    color: ColorConstant.appColor,
                                  )
                                : null,
                            onTap: () {
                              onSelect(option);
                              Navigator.pop(context);
                            },
                          );
                        }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCalendarBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CustomCalendarPicker(
          initialSingleDate: controller.selectedSingleDate,
          initialStartDate: controller.selectedStartDate,
          initialEndDate: controller.selectedEndDate,
          isRangeMode: controller.selectedDateIsRange,
          onApply: (singleDate, startDate, endDate, isRange) {
            controller.updateDates(singleDate, startDate, endDate, isRange);
          },
        );
      },
    );
  }
}
