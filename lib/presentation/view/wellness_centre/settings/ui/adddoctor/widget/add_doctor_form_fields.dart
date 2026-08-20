import 'package:flutter/material.dart';
import 'package:healing/controller/wellnesscentrecontroller/doctor_controller.dart';
import 'package:healing/common/common_text_form_filled.dart';
import 'package:healing/core/image_constant/image_constant.dart';

class AddDoctorFormFields extends StatelessWidget {
  final DoctorController controller;

  const AddDoctorFormFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Full Name
        _buildLabel('Full Name *'),
        CommonTextFormFilled(
          hintText: 'Dr. Jane Doe',
          controller: controller.nameController,
          height: 48,
        ),
        const SizedBox(height: 16),

        // 2. Specialization
        _buildLabel('Specialization *'),
        CommonTextFormFilled(
          hintText: 'e.g. Ayurveda Physician',
          controller: controller.specializationController,
          height: 48,
        ),
        const SizedBox(height: 16),

        // 3. Email
        _buildLabel('Email *'),
        CommonTextFormFilled(
          hintText: 'jane.doe@clinic.com',
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          height: 48,
        ),
        const SizedBox(height: 16),

        // 4. Phone Number
        _buildLabel('Phone Number'),
        CommonTextFormFilled(
          hintText: '+91 98765 43210',
          controller: controller.phoneController,
          keyboardType: TextInputType.phone,
          height: 48,
        ),
        const SizedBox(height: 16),

        // 5. Temporary Password
        _buildLabel('Temporary Password *'),
        CommonTextFormFilled(
          hintText: 'Create a temporary password',
          controller: controller.passwordController,
          obscureText: controller.isPasswordObscured,
          suffixIcon: controller.isPasswordObscured
              ? ImageConstant.passwordHideIcon // Fallback icon path or suffixIcon click
              : ImageConstant.passwordUnHideIcon,
          onTapSuffixIcon: controller.togglePasswordVisibility,
          height: 48,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 6.0, left: 4.0),
          child: Text(
            'Doctor will be prompted to change this on first login.',
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 20),

        const Divider(color: Color(0xFFE2E8F0), height: 1),
        const SizedBox(height: 20),

        // 6. Qualification
        _buildLabel('Qualification *'),
        CommonTextFormFilled(
          hintText: 'e.g. MBBS, MD',
          controller: controller.qualificationController,
          height: 48,
        ),
        const SizedBox(height: 16),

        // 7. Experience
        _buildLabel('Experience (Years) *'),
        CommonTextFormFilled(
          hintText: 'e.g. 5',
          controller: controller.experienceController,
          keyboardType: TextInputType.number,
          height: 48,
        ),
        const SizedBox(height: 16),

        // 8. Consultation Fee
        _buildLabel('Consultation Fee (₹) *'),
        CommonTextFormFilled(
          hintText: '₹ 500',
          controller: controller.feeController,
          keyboardType: TextInputType.number,
          height: 48,
        ),
        const SizedBox(height: 16),

        // 9. About the Doctor
        _buildLabel('About the Doctor'),
        CommonTextFormFilled(
          hintText: 'Brief professional biography...',
          controller: controller.aboutController,
          maxLines: 4,
          height: 96,
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Afacad',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}
