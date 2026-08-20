import 'package:flutter/material.dart';
import 'package:healing/controller/wellnesscentrecontroller/services_controller.dart';
import '../../../../../core/color_constant/color_constant.dart';

class ServiceActionButtons extends StatelessWidget {
  final ServicesController controller;
  final VoidCallback onCancel;
  final VoidCallback onCreate;

  const ServiceActionButtons({
    super.key,
    required this.onCancel,
    required this.onCreate,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Cancel Button
        Expanded(
          child: SizedBox(
            height: 52,
            child: OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Create Button
        Expanded(
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: onCreate,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.appColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child:  Text(

                controller.editingServiceId != null ? "Update" :
                "Create",
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
    );
  }
}
