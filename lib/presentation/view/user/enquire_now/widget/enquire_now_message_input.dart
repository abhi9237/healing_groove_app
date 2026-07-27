import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/enquire_now_controller.dart';

class EnquireNowMessageInput extends StatelessWidget {
  final EnquireNowController controller;

  const EnquireNowMessageInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header Row
          Row(
            children: const [
              Icon(
                Icons.chat_bubble_outline_rounded,
                color: ColorConstant.appColor,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                'Additional Message',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Multiline TextFormField
          TextFormField(
            controller: controller.messageController,
            maxLines: 5,
            minLines: 4,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: ColorConstant.lightBlackColor,
            ),
            decoration: InputDecoration(
              hintText: 'Any special requirements or medical history we should know about?',
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade400,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: ColorConstant.appColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
