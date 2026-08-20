import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/presentation/model/common/saved_centre_model.dart';
import 'package:healing/presentation/model/response/get_saved_centre_response_model.dart';
import 'package:healing/repository/settings_repository.dart';
import 'package:healing/repository/view_detail_repository.dart';

import '../../common/common_methods.dart';
import '../../core/route/route_constant/route_constant.dart';
import '../../presentation/model/response/error_response_model.dart';
import '../../presentation/model/response/saved_response_model.dart';

class SavedProgramController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isSaveLoading = false.obs;
  final RxList<SavedCentersModel> savedCentres = <SavedCentersModel>[].obs;
  final SettingsRepository _settingsRepository = SettingsRepository();
  final ViewDetailRepository viewDetailRepository = ViewDetailRepository();

  @override
  void onInit() {
    super.onInit();
    fetchSavedCentres();
  }

  Future<void> fetchSavedCentres() async {
    isLoading.value = true;
    update();

    try {
      final response = await _settingsRepository.getSavedCentres();
      if (response.statusCode == 200) {
        final getSavedCentreResponse = GetSavedCentreResponseModel.fromJson(
          response.data,
        );
        if (getSavedCentreResponse.success == true &&
            getSavedCentreResponse.savedCenters != null) {
          savedCentres.assignAll(getSavedCentreResponse.savedCenters!);
        } else {
          savedCentres.clear();
        }
      } else {
        savedCentres.clear();
      }
    } catch (e) {
      log('SavedProgramController: Error loading saved programs: $e');
      savedCentres.clear();
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void toggleFavorite(int id) {
    final index = savedCentres.indexWhere((element) => element.id == id);
    if (index != -1) {
      final current = savedCentres[index].isSaved ?? false;
      savedCentres[index].isSaved = !current;

      savedCentres.refresh();
      update();
    }
  }

  void onTapViewDetail(int id, BuildContext context) {
    context.push(RouteConstant.viewDetail, extra: {'centerId': id}).then((v) {
      update();
    });
  }

  Future<void> toggleFavoriteCentre(int centerId) async {
    isSaveLoading.value = true;
    update();
    try {
      var response = await viewDetailRepository.saveCentre({
        'centerId': centerId,
      });

      if (response.statusCode == 200 && response.data != null) {
        SavedCentreResponseModel responseModel =
            SavedCentreResponseModel.fromJson(response.data);
        if (responseModel.success == true) {
          savedCentres.removeWhere((v) => v.id == centerId);
          savedCentres.refresh();
          final context = Get.context;
          if (context != null && context.mounted) {
            showToastMessage(
              titleMessage: 'Success',
              message: 'Saved Centre Removed successfully',
              context: context,
              isError: false,
            );
          }
        } else {
          final context = Get.context;
          if (context != null && context.mounted) {
            showToastMessage(
              titleMessage: 'Error',
              message: 'Failed to update saved status',
              context: context,
              isError: true,
            );
          }
        }
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        final errorMessage =
            errorResponse.errors?.first.message ??
            'Failed to update saved status';
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
      log('ViewDetailController: Error saving centre: $e');
      final context = Get.context;
      if (context != null && context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'An error occurred. Please try again.',
          context: context,
          isError: true,
        );
      }
    } finally {
      isSaveLoading.value = false;
      update();
    }
  }
}
