import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/controller/usercontroller/book_program_controller.dart';
import 'package:healing/controller/usercontroller/saved_program_controller.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/presentation/model/common/service_model.dart';
import '../../presentation/model/common/packages_model.dart';
import '../../presentation/model/response/centre_program_response_model.dart';
import '../../presentation/model/response/error_response_model.dart';
import '../../repository/view_detail_repository.dart';
import '../../repository/settings_repository.dart';
import '../../presentation/model/response/saved_response_model.dart';
import '../../presentation/model/response/user_profile_response_model.dart';

class ViewDetailController extends GetxController {
  Map<String, dynamic>? argsData;
  ViewDetailController({this.argsData});
  ViewDetailRepository viewDetailRepository = ViewDetailRepository();
  final SettingsRepository settingsRepository = SettingsRepository();
  CenterProgramResponseModel centerProgramDetail = CenterProgramResponseModel();
  RxBool isLoading = false.obs;
  RxBool isSaveLoading = false.obs;
  RxBool isFavorite = false.obs;
  DocModel centerDetail = DocModel();
  int centerId = 0;

  @override
  void onInit() {
    super.onInit();
    getArgsDetail();
    getCenterDetail();
    getCenterProgramDetail();
  }

  void getArgsDetail() {
    if (argsData != null) {
      centerId = argsData?['centerId'] ?? 0;
    }
  }

  void onTapBookNow(BuildContext context, PackagesModel data) {
    log('${data.name}');
    if (Get.isRegistered<BookProgramController>()) {
      Get.delete<BookProgramController>();
    }

    context.pushNamed(
      RouteConstant.bookProgram,
      extra: {'programDetail': data},
    );
  }

  String calculateServicePrice(List<ServiceModel> servicesList) {
    int price = 0;

    if (servicesList.isNotEmpty) {
      for (var i in servicesList) {
        price = price + (i.basePrice ?? 0);
      }
    }

    return formatIndianPrice(price);
  }

  Future<void> getCenterDetail() async {
    isLoading.value = true;
    try {
      var response = await viewDetailRepository.getCentersDetail(centerId);
      if (response.statusCode == 200 && response.data != null) {
        log('ViewDetailController: response data ===> ${response.data}');

        centerDetail = DocModel.fromJson(response.data);
        log('centerDetail.isSaved==> ${centerDetail.isSaved}');
        log('centerDetail.isSaved==> ${centerDetail.name}');
        if (centerDetail.isSaved == true) {
          isFavorite.value = true;
        } else {
          isFavorite.value = false;
        }
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        final errorMessage =
            errorResponse.errors?.first.message ??
            'Failed to load center details';
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
      log('ViewDetailController: Error getting center detail: $e');
    } finally {
      isLoading.value = false;
    }
    update();
  }

  Future<void> getCenterProgramDetail() async {
    isLoading.value = true;
    try {
      var response = await viewDetailRepository.getCentersProgramDetail(
        centerId,
      );
      if (response.statusCode == 200 && response.data != null) {
        log(
          'ViewDetailController getCenterProgramDetail: response data ===> ${response.data}',
        );

        if (response.data is Map<String, dynamic>) {
          centerProgramDetail = CenterProgramResponseModel.fromJson(
            response.data,
          );
        }
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        final errorMessage =
            errorResponse.errors?.first.message ??
            'Failed to load center details';
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
      log('getCenterProgramDetail: Error getting center detail: $e');
    } finally {
      isLoading.value = false;
    }
    update();
  }

  Future<void> toggleFavoriteCentre() async {
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
          if (responseModel.action == 'saved') {
            isFavorite.value = true;
          } else if (responseModel.action == 'unsaved') {
            isFavorite.value = false;
          }

          if (Get.isRegistered<SavedProgramController>()) {
            Get.find<SavedProgramController>().savedCentres.removeWhere(
              (v) => v.id == centerId,
            );
            Get.find<SavedProgramController>().savedCentres.refresh();
          }

          final context = Get.context;
          if (context != null && context.mounted) {
            showToastMessage(
              titleMessage: 'Success',
              message: 'Centre ${responseModel.action} successfully',
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
