import 'package:flutter/material.dart';
import '../../../../../common/common_text_form_filled.dart';
import '../../../../../core/color_constant/color_constant.dart';

class CapacityRoomsInput extends StatelessWidget {
  final TextEditingController capacityController;
  final TextEditingController roomsController;

  const CapacityRoomsInput({
    super.key,
    required this.capacityController,
    required this.roomsController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cap.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
              const SizedBox(height: 8),
              CommonTextFormFilled(
                hintText: 'e.g 50',
                controller: capacityController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rooms',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
              const SizedBox(height: 8),
              CommonTextFormFilled(
                hintText: 'e.g 50',
                controller: roomsController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
