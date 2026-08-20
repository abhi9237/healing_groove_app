import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/app_loader.dart';
import 'package:healing/common/common_app_bar.dart';
import 'package:healing/controller/usercontroller/book_program_controller.dart';
import 'package:healing/presentation/model/common/packages_model.dart';
import 'widget/book_program_package_card.dart';
import 'widget/book_program_select_date.dart';
import 'widget/book_program_group_size.dart';
import 'widget/book_program_guest_info.dart';
import 'widget/book_program_bottom_bar.dart';

class BookProgramScreen extends StatelessWidget {
  final PackagesModel? data;
  const BookProgramScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF7),
      body: GetBuilder<BookProgramController>(
        init: BookProgramController(argsData: data),
        autoRemove: false,
        builder: (controller) {
          return AppLoader(
            isLoading: controller.isLoading,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  CommonAppBar(title: 'Book Program'),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BookProgramPackageCard(controller: controller),
                          const SizedBox(height: 24),
                          BookProgramSelectDate(controller: controller),
                          const SizedBox(height: 24),
                          BookProgramGroupSize(controller: controller),
                          const SizedBox(height: 24),
                          BookProgramGuestInfo(controller: controller),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                  BookProgramBottomBar(controller: controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
