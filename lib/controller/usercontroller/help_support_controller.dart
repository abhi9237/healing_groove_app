import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_widget.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/response/help_support_response_model.dart';

import '../../common/common_methods.dart';
import '../../presentation/model/response/error_response_model.dart';
import '../../repository/settings_repository.dart';

class HelpSupportController extends GetxController {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final SettingsRepository repository = SettingsRepository();
  RxBool isLoadingSendMessage = false.obs;
  RxBool isLoading = false.obs;
  List<DocModel> recentEnquiries = <DocModel>[];

  final List<String> categories = [
    'General Inquiry',
    'Booking Issues',
    'Technical Issues',
    'Billing Issues',
  ];

  String selectedCategory = 'General Inquiry';

  @override
  void onInit() {
    super.onInit();
    setData();
    getRecentEnquiries();
  }

  void setData() {
    emailController.text = HiveStorageService.getUserEmail() ?? '';
    subjectController.text = selectedCategory;
    update();
  }

  Future<void> sendMessageTicket(
    BuildContext context,
    Map<String, dynamic> data,
  ) async
  {
    isLoadingSendMessage.value = true;
    try {
      var response = await repository.helpAndSupport(data);
      if (response.statusCode == 200 ||response.statusCode == 201) {
        HelpAndSupportResponseModel responseModel =
            HelpAndSupportResponseModel.fromJson(response.data);
        messageController.clear();
        recentEnquiries.add(responseModel.doc ?? DocModel());
        if (context.mounted) {
          commonSnackBar(context, 'Support Ticket Successfully Created.');
        }
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        final errorMessage =
            errorResponse.errors?.first.message ??
            'Failed to load user profile';
        final context = Get.context;
        if (context != null && context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: errorMessage,
            context: context,
            isError: true,
          );
        }
      }
    } catch (e) {
      log('EditProfileController: Error getting user profile: $e');
    } finally {
      isLoadingSendMessage.value = false;
    }
    update();
  }


  Future<void> getRecentEnquiries()async{

      isLoading.value = true;

      try {
        var response = await repository.recentEnquiries();
        if (response.statusCode == 200) {
          HelpAndSupportResponseModel responseModel =
              HelpAndSupportResponseModel.fromJson(response.data);
          recentEnquiries = responseModel.docs ??[];
        } else {
          ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
            response.data,
          );
          final errorMessage =
              errorResponse.errors?.first.message ??
                  'Failed to load user profile';
          final context = Get.context;
          if (context != null && context.mounted) {
            showToastMessage(
              titleMessage: 'Error',
              message: errorMessage,
              context: context,
              isError: true,
            );
          }
        }
      } catch (e) {
        log('EditProfileController: Error getting user profile: $e');
      } finally {
        isLoading.value = false;
        update();
      }

  }

  void selectCategory(String val) {
    selectedCategory = val;
    subjectController.text = selectedCategory;

    update();
  }

  void sendMessage(BuildContext context) {
    if (messageController.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter your message',
        context: context,
        isError: true,
      );
    } else {
      Map<String, dynamic> data = {
        "name": HiveStorageService.getUserName(),
        "email": emailController.text.trim(),
        "subject": subjectController.text,
        "message": messageController.text,
        "sourceType": HiveStorageService.getUserType(),
      };
      sendMessageTicket(context, data);
    }

    update();
  }

  @override
  void onClose() {
    subjectController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
