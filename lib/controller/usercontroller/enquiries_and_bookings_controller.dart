import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/response/enquiries_response_model.dart';
import 'package:healing/presentation/model/response/error_response_model.dart';
import 'package:healing/repository/enquiries_and_booking_repository.dart';
import 'package:healing/common/common_methods.dart';
import 'package:intl/intl.dart' as f;

class EnquiriesAndBookingsController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final EnquiriesAndBookingRepository enquiriesRepository =
      EnquiriesAndBookingRepository();

  String _searchQuery = '';
  String _selectedStatus = 'All Status';
  bool _showStatusGuide = true;
  Timer? _debounceTimer;

  RxBool isLoading = false.obs;
  RxBool isLoadMore = false.obs;
  int currentPage = 1;
  bool hasMore = true;
  static const int _limit = 10;

  String get searchQuery => _searchQuery;
  String get selectedStatus => _selectedStatus;
  bool get showStatusGuide => _showStatusGuide;

  final RxList<DocModel> allEnquiries = <DocModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEnquiriesAndBookings(isRefresh: true);
    scrollController.addListener(_onScroll);
  }

  Future<void> fetchEnquiriesAndBookings({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      allEnquiries.clear();
    }

    if (isLoading.value || isLoadMore.value || !hasMore) return;

    if (currentPage == 1) {
      isLoading.value = true;
    } else {
      isLoadMore.value = true;
    }
    update();

    try {
      final response = await enquiriesRepository.getEnquiriesAndBooking(
        page: currentPage,
        limit: _limit,
      );

      if (response.statusCode == 200 && response.data != null) {
        log(
          'EnquiriesAndBookingsController: response data ===> ${response.data}',
        );
        final responseModel = EnquiriesResponseModel.fromJson(response.data);
        final List<DocModel> newDocs = responseModel.docs ?? [];

        if (newDocs.isNotEmpty) {
          if (currentPage == 1) {
            allEnquiries.assignAll(newDocs);
          } else {
            allEnquiries.addAll(newDocs);
          }
          currentPage++;
        } else {
          toggleStatusGuide(false);
        }
        hasMore = responseModel.hasNextPage ?? false;
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        final errorMessage =
            errorResponse.errors?.first.message ??
            'Failed to load enquiries and bookings';
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
      log('EnquiriesAndBookingsController: Error fetching enquiries: $e');
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
    }
    update();
  }

  Future<void> searchEnquiries({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      allEnquiries.clear();
    }

    if (isLoading.value || isLoadMore.value || !hasMore) return;

    if (currentPage == 1) {
      isLoading.value = true;
    } else {
      isLoadMore.value = true;
    }
    update();

    try {
      final response = await enquiriesRepository.searchEnquiriesAndBooking(
        q: _searchQuery.isNotEmpty ? _searchQuery : null,
        status: _selectedStatus == 'All Status'
            ? null
            : _selectedStatus.toLowerCase(),
        page: currentPage,
        limit: 100,
      );

      if (response.statusCode == 200 && response.data != null) {
        log(
          'EnquiriesAndBookingsController: search response data ===> ${response.data}',
        );
        final responseModel = EnquiriesResponseModel.fromJson(response.data);
        final List<DocModel> newDocs = responseModel.docs ?? [];

        if (newDocs.isNotEmpty) {
          if (currentPage == 1) {
            allEnquiries.assignAll(newDocs);
          } else {
            allEnquiries.addAll(newDocs);
          }
          currentPage++;
        } else {
          if (currentPage == 1) {
            allEnquiries.clear();
          }
          toggleStatusGuide(false);
        }
        hasMore = responseModel.hasNextPage ?? false;
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        final errorMessage =
            errorResponse.errors?.first.message ?? 'Failed to search enquiries';
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
      log('EnquiriesAndBookingsController: Error searching enquiries: $e');
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
    }
    update();
  }

  List<DocModel> get filteredEnquiries => allEnquiries;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (_searchQuery.isNotEmpty || _selectedStatus != 'All Status') {
        searchEnquiries(isRefresh: true);
      } else {
        fetchEnquiriesAndBookings(isRefresh: true);
      }
    });
  }

  void updateStatusFilter(String status) {
    _selectedStatus = status;
    if (_searchQuery.isNotEmpty || _selectedStatus != 'All Status') {
      searchEnquiries(isRefresh: true);
    } else {
      fetchEnquiriesAndBookings(isRefresh: true);
    }
  }

  void toggleStatusGuide(bool show) {
    _showStatusGuide = show;
    update();
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (_searchQuery.isNotEmpty || _selectedStatus != 'All Status') {
        searchEnquiries();
      } else {
        fetchEnquiriesAndBookings();
      }
    }
  }

  String timeAgo(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      final date = DateTime.parse(dateStr).toLocal();
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inSeconds < 60) {
        return 'Updated just now';
      } else if (difference.inMinutes < 60) {
        return 'Updated ${difference.inMinutes}m ago';
      } else if (difference.inHours < 24) {
        return 'Updated ${difference.inHours}h ago';
      } else if (difference.inDays < 7) {
        return 'Updated ${difference.inDays}d ago';
      } else {
        return 'Updated on ${f.DateFormat('d/M/yyyy').format(date)}';
      }
    } catch (e) {
      return 'Updated: $dateStr';
    }
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
