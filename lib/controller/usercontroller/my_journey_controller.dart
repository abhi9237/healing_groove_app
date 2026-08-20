import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/presentation/model/response/my_booking_response_model.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/repository/my_journey_repository.dart';
import 'package:healing/presentation/model/response/error_response_model.dart';
import 'package:healing/common/common_methods.dart';

class MyJourneyController extends GetxController {
  final MyJourneyRepository myJourneyRepository = MyJourneyRepository();
  final ScrollController scrollController = ScrollController();

  // Arrays
  final RxList<DocModel> allJourney = <DocModel>[].obs;
  final RxList<DocModel> confirmed = <DocModel>[].obs;
  final RxList<DocModel> completed = <DocModel>[].obs;

  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isMoreLoading = false.obs;

  // Pagination fields
  int currentPage = 1;
  bool hasNextPage = true;

  int activeTabIndex = 0;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    getBookingsList();
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    // We only paginate for "All Journey" tab (activeTabIndex == 0)
    if (activeTabIndex == 0 &&
        !isLoading.value &&
        !isMoreLoading.value &&
        hasNextPage &&
        scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      loadMoreBookings();
    }
  }

  void changeTab(int index) {
    activeTabIndex = index;
    update();
  }

  // Get active list to display based on selected tab
  List<DocModel> get filteredBookings {
    if (activeTabIndex == 1) {
      return confirmed;
    } else if (activeTabIndex == 2) {
      return completed;
    }
    return allJourney;
  }

  Future<void> getBookingsList({bool isRefresh = false}) async {
    if (isRefresh) {
      isLoading.value = true;
    } else {
      if (currentPage == 1) {
        isLoading.value = true;
      } else {
        isMoreLoading.value = true;
      }
    }
    update(); // Notify UI to show loading/shimmer

    try {
      final response = await myJourneyRepository.getBookings(page: currentPage, limit: 30);
      if (response.statusCode == 200 && response.data != null) {
        log('MyJourneyController getBookingsList: response data ===> ${response.data}');
        final MyBookingResponseModel model = MyBookingResponseModel.fromJson(response.data);
        
        if (isRefresh) {
          allJourney.clear();
        }

        log('model.docs?.first.center?.name ${model.docs?.first.package?.name}');

        if (model.docs != null) {
          allJourney.addAll(model.docs!);
        }

        hasNextPage = model.hasNextPage ?? false;
        if (model.page != null) {
          currentPage = model.page! + 1;
        } else {
          currentPage++;
        }
        _updateSubArrays();
      } else {
        final errorResponse = ErrorResponseModel.fromJson(response.data);
        final errorMessage = errorResponse.errors?.first.message ?? 'Failed to load bookings';
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
      log('MyJourneyController error: $e');
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
      update();
    }
  }

  Future<void> loadMoreBookings() async {
    if (isMoreLoading.value || !hasNextPage) return;
    await getBookingsList();
  }

  Future<void> refreshBookings() async {
    currentPage = 1;
    hasNextPage = true;
    allJourney.clear();
    confirmed.clear();
    completed.clear();
    await getBookingsList(isRefresh: true);
  }

  void _updateSubArrays() {
    confirmed.value = allJourney.where((b) {
      final status = b.status?.toUpperCase();
      return status == 'CONFIRMED';
    }).toList();

    completed.value = allJourney.where((b) {
      final status = b.status?.toUpperCase();
      return status == 'COMPLETED' || status == 'CANCELLED';
    }).toList();
  }

  void viewDetails(BuildContext context, DocModel bookingDetail) {
    context.push(RouteConstant.myJourneyDetail,extra: {
      'bookingDetail':bookingDetail
    });
  }

  void messageGuide(BuildContext context, dynamic bookingId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Text(
              'Opening chat with guide for #$bookingId',
              style: const TextStyle(
                fontFamily: 'Afacad',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF08864F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
