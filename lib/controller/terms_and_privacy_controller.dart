import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/presentation/model/response/terms_and_privacy_response_model.dart';
import 'package:healing/repository/terms_and_privacy_repository.dart';

class TermsAndPrivacyController extends GetxController {
  final TermsAndPrivacyRepository _repository = TermsAndPrivacyRepository();

  bool isLoading = false;
  TermsAndPrivacyResponseModel? data;

  Future<void> fetchTermsAndPrivacy(bool isTerms) async {
    isLoading = true;
    update();

    try {
      final response = isTerms
          ? await _repository.getTerms()
          : await _repository.getPrivacyPolicy();

      if (response.statusCode == 200 && response.data != null) {
        data = TermsAndPrivacyResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      }
    } catch (e) {
      log('TermsAndPrivacyController: fetchTermsAndPrivacy failed with error: $e');
    } finally {
      isLoading = false;
      update();
    }
  }
}
