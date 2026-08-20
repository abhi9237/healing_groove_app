import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/controller/wellnesscentrecontroller/doctor_controller.dart';
import '../../../../../../../common/common_app_bar.dart';
import '../../../../../../../common/common_auth_background.dart';
import '../../../../../../../core/color_constant/color_constant.dart';
import 'widget/add_doctor_notice.dart';
import 'widget/add_doctor_form_fields.dart';

class AddDoctorScreen extends StatelessWidget {
  const AddDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<DoctorController>(
          init: DoctorController(),
          builder: (controller) {
            return Column(
              children: [
                // App Bar
                const CommonAppBar(
                  title: 'Doctors',
                  showBackButton: true,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                        // Notice card
                        const AddDoctorNotice(),
                        const SizedBox(height: 24),

                        // Form input fields
                        AddDoctorFormFields(controller: controller),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      // Bottom save/cancel buttons row
      bottomNavigationBar: GetBuilder<DoctorController>(
        builder: (controller) {
          return Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FBF9),
              border: Border(
                top: BorderSide(color: Color(0xFFE2E8F0), width: 0.8),
              ),
            ),
            child: Row(
              children: [
                // Cancel Button
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ColorConstant.appColor, width: 1.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.appColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Add Doctor Button
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => controller.addDoctor(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.appColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Add Doctor',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
