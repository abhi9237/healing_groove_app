import 'package:flutter/material.dart';
import 'package:healing/common/common_button.dart';
import 'package:healing/common/common_widget.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import 'package:healing/controller/help_support_controller.dart';

class SupportRequestCard extends StatelessWidget {
  final HelpSupportController controller;

  const SupportRequestCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          const Text(
            'Create Support Request',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: ColorConstant.lightBlackColor,
            ),
          ),
          const SizedBox(height: 6),

          // Subtitle
          Text(
            'Share your thoughts, and let us light the way forward.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: ColorConstant.greyColor.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 24),

          // Subject Input Field
          TextField(
            readOnly: true,
            controller: controller.subjectController,
            style: const TextStyle(
              fontSize: 15,
              color: ColorConstant.lightBlackColor,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: 'Subject',
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorConstant.appColor,
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
          const SizedBox(height: 18),

          // Phone Number Input Field
          TextField(
            readOnly: true,
            controller: controller.emailController,
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              fontSize: 15,
              color: ColorConstant.lightBlackColor,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorConstant.appColor,
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
          const SizedBox(height: 18),

          // Message Input Field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Message',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextField(
                controller: controller.messageController,
                minLines: 4,
                maxLines: 6,
                style: const TextStyle(
                  fontSize: 15,
                  color: ColorConstant.lightBlackColor,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstant.appColor,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          controller.isLoadingSendMessage.value ?CommonCircularIndicator():
          CommonButton(
            buttonText: 'Send Message',
            frontImg: ImageConstant.sendMessageIcon,
            onTap: ()=> controller.sendMessage(context),
          ),
        ],
      ),
    );
  }
}
