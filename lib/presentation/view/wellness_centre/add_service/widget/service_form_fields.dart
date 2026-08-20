import 'package:flutter/material.dart';
import 'package:healing/common/common_text_form_filled.dart';
import '../../../../../core/color_constant/color_constant.dart';

class ServiceFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;

  const ServiceFormFields({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.priceController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        _buildLabel("Name *"),
        _buildTextField(
          controller: nameController,
          hint: "e.g. Abhyanga Massage",
        ),
        const SizedBox(height: 20),

        // Description
        _buildLabel("Description"),
        _buildTextField(
          controller: descriptionController,
          hint: "A brief description of the restorative experience...",
          maxLines: 4,
        ),
        const SizedBox(height: 20),

        // Base Price
        _buildLabel("Base price (₹) *"),
        _buildTextField(
          controller: priceController,
          hint: "0",
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Afacad',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: ColorConstant.lightBlackColor,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return CommonTextFormFilled(hintText: hint, controller: controller);

  }
}
