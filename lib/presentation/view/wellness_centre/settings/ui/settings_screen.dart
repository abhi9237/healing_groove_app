import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/controller/wellnesscentrecontroller/wellness_settings_controller.dart';
import '../../../../../common/common_app_bar.dart';
import '../../../../../common/common_auth_background.dart';
import '../../../../../common/common_widget.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import '../widget/settings_header_card.dart';
import '../widget/settings_featured_image.dart';
import '../widget/settings_gallery.dart';
import '../widget/settings_form_sections.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<WellnessSettingsController>(
          init: WellnessSettingsController(),
          builder: (controller) {
            if (controller.isLoading && controller.centerData == null) {
              return Column(
                children: [
                  CommonAppBar(
                    showBackButton: false,
                    showMenuButton: true,
                    onMenuPressed: () => context.findRootAncestorStateOfType<ScaffoldState>()?.openDrawer(),
                  ),
                  const Expanded(
                    child: Center(
                      child: CommonCircularIndicator(),
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                // AppBar
                CommonAppBar(
                  showBackButton: false,
                  showMenuButton: true,
                  onMenuPressed: () => context.findRootAncestorStateOfType<ScaffoldState>()?.openDrawer(),
                ),

                // Main form content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: Column(
                      children: [
                        // Green header card
                        SettingsHeaderCard(
                          centerName: controller.nameController.text,
                          featuredImageUrl: controller.featuredImageUrl,
                          newFeaturedImageFile: controller.newFeaturedImageFile,
                          onEditPhoto: () => controller.showImageSourceOptions(
                            context,
                            isFeatured: true,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Featured Image upload
                        SettingsFeaturedImage(
                          newFeaturedImageFile: controller.newFeaturedImageFile,
                          featuredImageUrl: controller.featuredImageUrl,
                          onPick: () => controller.showImageSourceOptions(
                            context,
                            isFeatured: true,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Gallery Grid
                        SettingsGallery(
                          gallery: controller.galleryImages,
                          onAddImage: () => controller.showImageSourceOptions(
                            context,
                            isFeatured: false,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Text Field sections
                        SettingsFormSections(controller: controller),
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF9FBF9),
                            border: Border(
                              top: BorderSide(color: Color(0xFFE2E8F0), width: 0.8),
                            ),
                          ),
                          child: SizedBox(
                            height: 52,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.isSaving
                                  ? null
                                  : () => controller.saveSettings(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.appColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: controller.isSaving
                                  ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                                  : const Text(
                                'Save Settings',
                                style: TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
