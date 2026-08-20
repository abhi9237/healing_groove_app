import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:healing/common/common_text_form_filled.dart';
import '../../../../../controller/wellnesscentrecontroller/add_new_program_controller.dart';
import '../../../../../core/color_constant/color_constant.dart';

class BasicInfoFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController durationController;
  final TextEditingController priceController;
  final TextEditingController minGuestsController;
  final TextEditingController maxGuestsController;
  final String selectedStatus;
  final List<ProgramStatus> statusOptions;
  final ValueChanged<String?> onStatusChanged;
  final File? imageFile;
  final String? imageUrl;
  final VoidCallback onPickImage;

  const BasicInfoFields({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.durationController,
    required this.priceController,
    required this.minGuestsController,
    required this.maxGuestsController,
    required this.selectedStatus,
    required this.statusOptions,
    required this.onStatusChanged,
    required this.imageFile,
    this.imageUrl,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Basic Information",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorConstant.lightBlackColor,
          ),
        ),
        const SizedBox(height: 16),

        // Program Image Box
        const Text(
          "Program Image",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: ColorConstant.lightBlackColor,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onPickImage,
          borderRadius: BorderRadius.circular(16),
          child: CustomPaint(
            painter: DashedRectPainter(
              color: Colors.grey.shade300,
              strokeWidth: 1.5,
              gap: 6.0,
              rx: 16.0,
              ry: 16.0,
            ),
            child: Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: imageFile != null
                    ? DecorationImage(
                        image: FileImage(imageFile!),
                        fit: BoxFit.cover,
                      )
                    : (imageUrl != null && imageUrl!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null),
              ),
              child: imageFile != null || (imageUrl != null && imageUrl!.isNotEmpty)
                  ? null
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE8F5E9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.cloud_upload_outlined,
                            color: ColorConstant.appColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Click to upload image",
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Program Name
        _buildLabel("Program Name *"),
        _buildTextField(
          controller: nameController,
          hint: "e.g., 14-Day Panchakarma Detox",
        ),
        const SizedBox(height: 16),

        // Description
        _buildLabel("Description"),
        _buildTextField(
          controller: descriptionController,
          hint: "Describe the program and its benefits",
          maxLines: 4,
        ),
        const SizedBox(height: 16),

        // Duration & Extra Price Row
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Duration (days) *"),
                  _buildTextField(
                    controller: durationController,
                    hint: "1",
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Extra Price (₹)"),
                  _buildTextField(
                    controller: priceController,
                    hint: "0",
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Min & Max Guests Row
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Min Guests"),
                  _buildTextField(
                    controller: minGuestsController,
                    hint: "1",
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Max Guests"),
                  _buildTextField(
                    controller: maxGuestsController,
                    hint: "10",
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Program Status Dropdown
        _buildLabel("Program Status"),
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedStatus,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey.shade500,
              ),
              isExpanded: true,
              style: const TextStyle(
                fontFamily: 'Afacad',
                fontSize: 14.5,
                color: ColorConstant.lightBlackColor,
              ),
              items: statusOptions.map((opt) {
                return DropdownMenuItem<String>(
                  value: opt.status,
                  child: Text(opt.text ?? ''),
                );
              }).toList(),
              onChanged: onStatusChanged,
            ),
          ),
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
    return CommonTextFormFilled(
      height: 40,
      hintText: hint,
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
    );
  }
}

// Custom Painter for drawing a dashed rounded rectangle
class DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double rx;
  final double ry;

  DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 4.0,
    this.rx = 12.0,
    this.ry = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(rx),
        ),
      );

    final Path dashPath = Path();
    double distance = 0.0;
    for (PathMetric measurePath in path.computeMetrics()) {
      while (distance < measurePath.length) {
        dashPath.addPath(
          measurePath.extractPath(distance, distance + gap),
          Offset.zero,
        );
        distance += gap * 2;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
