import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/controller/usercontroller/enquire_now_controller.dart';
import 'widget/enquire_now_app_bar.dart';
import 'widget/enquire_now_resort_card.dart';
import 'widget/enquire_now_program_selector.dart';
import 'widget/enquire_now_date_picker.dart';
import 'widget/enquire_now_guest_counter.dart';
import 'widget/enquire_now_guest_info.dart';
import 'widget/enquire_now_message_input.dart';
import 'widget/enquire_now_submit_button.dart';

class EnquireNowUi extends StatelessWidget {
  final Map<String, dynamic>? data;
  const EnquireNowUi({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        child: GetBuilder<EnquireNowController>(
          init: EnquireNowController(argsData: data),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Navigation Row
                const EnquireNowAppBar(),
                
                // Form content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Resort Card details
                        EnquireNowResortCard(controller: controller),
                        
                        // Select Healing Program tags
                        EnquireNowProgramSelector(controller: controller),
                        
                        // Preferred Start Date picker field
                        EnquireNowDatePicker(controller: controller),
                        
                        // Number of Guests counter
                        EnquireNowGuestCounter(controller: controller),

                        // Guest details info section
                        EnquireNowGuestInfo(controller: controller),
                        
                        // Additional Message textfield
                        EnquireNowMessageInput(controller: controller),
                        
                        // Submit button and response text footer
                        EnquireNowSubmitButton(controller: controller),
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
