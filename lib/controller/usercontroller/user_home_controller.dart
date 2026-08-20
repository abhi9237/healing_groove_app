import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/response/center_response_model.dart';
import 'package:healing/common/common_methods.dart';
import '../../presentation/model/response/error_response_model.dart';
import '../../presentation/model/response/user_profile_response_model.dart';
import '../../presentation/model/response/program_response_model.dart';
import '../../repository/settings_repository.dart';
import '../../repository/user_home_repository.dart';
import '../../repository/explore_retreats_repository.dart';

class UserHomeController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final UserHomeRepository userHomeRepository = UserHomeRepository();
  final SettingsRepository repository = SettingsRepository();
  final ExploreRetreatsRepository exploreRetreatsRepository = ExploreRetreatsRepository();
  final GlobalKey wellnessCentresKey = GlobalKey();

  RxList<DocModel> packagesList = <DocModel>[].obs;
  RxBool isPackagesLoading = false.obs;

  bool showAppBar = false;
  bool pinWellnessCentresHeader = false;
  RxBool isLoading = false.obs;
  RxList<DocModel> centerList = <DocModel>[].obs;

  int currentPage = 1;
  bool hasMore = true;
  RxBool isLoadMore = false.obs;
  static const int _limit = 10;

  // Explore All screen search state
  String selectedReason = 'Stress Relief Program';
  String selectedDestination = 'Kerala, India';
  String selectedWhen = 'Select Dates';
  String activeJourneyCount = '';
  String myPackagesCount = '';
  String savedCentreCount = '';
  String enquireCount = '';

  // Explore All screen filter state
  bool isVerifiedOnly = true;
  bool isAvailableNow = false;
  bool isPanchakarmaSelected = false;

  @override
  void onInit() {
    super.onInit();
    getAllCenters(isRefresh: true);
    getUserProfile();
    fetchCentrePackages();
    scrollController.addListener(_onScroll);
  }

  Future<void> getAllCenters({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      centerList.clear();
    }

    if (isLoading.value || isLoadMore.value || !hasMore) return;

    if (currentPage == 1) {
      isLoading.value = true;
    } else {
      isLoadMore.value = true;
    }

    try {
      var response = await userHomeRepository.getCenters(
        page: currentPage,
        limit: _limit,
      );
      if (response.statusCode == 200) {
        CenterResponseModel centerResponseModel = CenterResponseModel.fromJson(
          response.data,
        );
        List<DocModel> newDocs = centerResponseModel.docs ?? [];
        
        // Filter out centers where approvalStatus is "rejected"
        newDocs = newDocs.where((doc) => doc.approvalStatus?.toLowerCase() != 'rejected').toList();

        if (newDocs.isNotEmpty) {
          if (currentPage == 1) {
            centerList.value = newDocs;
          } else {
            centerList.addAll(newDocs);
          }
          currentPage++;
        }
        hasMore = centerResponseModel.hasNextPage ?? false;
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        final errorMessage =
            errorResponse.errors?.first.message ?? 'Failed to load centers';
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
      log('UserHomeController: Error getting centers: $e');
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
    }
    update();
  }

  void onTapViewProgram(BuildContext context, int id) {
    context.push(RouteConstant.viewDetail, extra: {'centerId': id});
  }

  void toggleVerifiedOnly() {
    isVerifiedOnly = !isVerifiedOnly;
    update();
  }

  void toggleAvailableNow() {
    isAvailableNow = !isAvailableNow;
    update();
  }

  void togglePanchakarma() {
    isPanchakarmaSelected = !isPanchakarmaSelected;
    update();
  }

  void resetFilters() {
    isVerifiedOnly = false;
    isAvailableNow = false;
    isPanchakarmaSelected = false;
    update();
  }

  void updateReason(String reason) {
    selectedReason = reason;
    update();
  }

  void updateDestination(String destination) {
    selectedDestination = destination;
    update();
  }

  void updateWhen(String whenStr) {
    selectedWhen = whenStr;
    update();
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    final double offset = scrollController.offset;

    // Show/hide the app bar based on scroll threshold
    final bool shouldShowAppBar = offset > 10;

    // Determine if we have reached the wellness centres widget
    bool shouldPinWellnessCentresHeader = false;
    if (wellnessCentresKey.currentContext != null) {
      final RenderBox? renderBox =
          wellnessCentresKey.currentContext!.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final BuildContext? context = Get.context;
        if (context != null) {
          final double topPadding = MediaQuery.paddingOf(context).top;
          final position = renderBox.localToGlobal(Offset.zero);

          // 96.0 is the dynamic app bar height
          if (position.dy <= topPadding + 96.0) {
            shouldPinWellnessCentresHeader = true;
          }
        }
      }
    }

    if (showAppBar != shouldShowAppBar ||
        pinWellnessCentresHeader != shouldPinWellnessCentresHeader) {
      showAppBar = shouldShowAppBar;
      pinWellnessCentresHeader = shouldPinWellnessCentresHeader;
      update();
    }

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      getAllCenters();
    }
  }

  Future<void> getUserProfile() async {
    isLoading.value = true;

    try {
      var response = await repository.userProfile();
      if (response.statusCode == 200) {
        UserProfileResponseModel responseModel =
        UserProfileResponseModel.fromJson(response.data);
        final user = responseModel.user;
        if (user != null) {
          log('user.activeJourneyCount==> ${user.activeJourneyCount}');

           activeJourneyCount =( user.activeJourneyCount ??'0').toString();
           myPackagesCount = (user.myPackageCount ?? '0').toString();
           savedCentreCount = (user.savedCenterCount ?? '0').toString();
           enquireCount = (user.enquireCount ?? '0').toString();
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
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchCentrePackages() async {
    isPackagesLoading.value = true;
    try {
      final response = await exploreRetreatsRepository.getCentrePackages();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final programsResponse = ProgramsResponseModel.fromJson(response.data as Map<String, dynamic>);
        packagesList.value = programsResponse.docs ?? [];
      } else {
        log('UserHomeController: Error fetching packages, status: ${response.statusCode}');
      }
    } catch (e) {
      log('UserHomeController: Error fetching packages: $e');
    } finally {
      isPackagesLoading.value = false;
      update();
    }
  }

}
