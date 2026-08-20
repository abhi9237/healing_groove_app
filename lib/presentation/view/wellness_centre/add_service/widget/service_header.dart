import 'package:flutter/material.dart';
import 'package:healing/controller/wellnesscentrecontroller/services_controller.dart';
import '../../../../../core/color_constant/color_constant.dart';

class ServiceHeader extends StatelessWidget {
  final ServicesController controller;
  const ServiceHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "RESTORATIVE MANAGEMENT",
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: ColorConstant.appColor,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          controller.editingServiceId != null ? "Update Offering" :
          "Create New Offering",
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: ColorConstant.lightBlackColor,
          ),
        ),
      ],
    );
  }
}
