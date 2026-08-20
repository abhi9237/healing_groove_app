import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/repository/booking_management_repo.dart';
import 'package:healing/presentation/model/response/wellness_booking_response_model.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:intl/intl.dart';

class WellnessHomeController extends GetxController {
  final BookingManagementRepository _bookingRepository = BookingManagementRepository();

  int todayCheckinsCount = 0;
  String totalRevenueK = "₹0K";
  int pendingRequestsCount = 0;

  List<DocModel> bookingStatusData = [];

  Map<String, dynamic> overviewData = {
    'Total Bookings': 0,
    'Active Bookings': 0,
    'Completion Rate': '0%',
    'Total Revenue': '₹0',
  };

  List<DocModel> recentBookings = [];

  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> refreshHomeData() async {
    await fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    isLoading = true;
    update();

    try {
      final response = await _bookingRepository.getCentreBookings(page: 1, limit: 50);
      if (response.statusCode == 200 && response.data != null) {
        final bookingResponse = WellnessBookingResponseModel.fromJson(response.data);
        final bookings = bookingResponse.docs ?? [];

        // 1. Check-ins scheduled for today
        final DateTime now = DateTime.now();
        final String todayStr = DateFormat('yyyy-MM-dd').format(now);
        todayCheckinsCount = bookings.where((b) {
          if (b.startDate == null) return false;
          try {
            final date = DateTime.parse(b.startDate!);
            return DateFormat('yyyy-MM-dd').format(date) == todayStr;
          } catch (_) {
            return false;
          }
        }).length;

        // 2. Total revenue (confirmed bookings)
        final confirmedList = bookings
            .where((b) => (b.status ?? '').toLowerCase() == 'confirmed')
            .toList();
        final double revenue = confirmedList.fold<double>(
          0.0,
          (sum, b) => sum + (b.totalAmount ?? 0).toDouble(),
        );
        totalRevenueK = "₹${(revenue / 1000).toStringAsFixed(1)}K".replaceAll('.0K', 'K');

        // 3. Pending requests count
        pendingRequestsCount = bookings.where((b) {
          final status = (b.status ?? '').toLowerCase();
          return status == 'pending' ||
              status == 'requested' ||
              status == 'awaiting confirmation' ||
              status ==  'initiated'||
              status == 'awaiting_confirmation';
        }).length;

        // 4. Group booking status count
        final confirmedCount = confirmedList.length;
        final inProgressCount = bookings.where((b) {
          final status = (b.status ?? '').toLowerCase();
          return status == 'in_progress' || status == 'in progress';
        }).length;
        final pendingCount = pendingRequestsCount;
        final completedCount = bookings
            .where((b) => (b.status ?? '').toLowerCase() == 'completed')
            .length;
        final cancelledCount = bookings.where((b) {
          final status = (b.status ?? '').toLowerCase();
          return status == 'cancelled' || status == 'canceled' || status == 'rejected';
        }).length;

        bookingStatusData = bookings;

        // 5. Overview summary calculations
        overviewData = {
          'Total Bookings': bookings.length,
          'Active Bookings': confirmedCount + inProgressCount,
          'Completion Rate': bookings.isNotEmpty
              ? "${((completedCount / bookings.length) * 100).toStringAsFixed(0)}%"
              : "0%",
          'Total Revenue': formatIndianPrice(revenue),
        };

        // 6. Map recent bookings (up to 10 records)
        recentBookings.clear();
        final limitCount = bookings.length < 10 ? bookings.length : 10;
        for (int i = 0; i < limitCount; i++) {
          final b = bookings[i];
          final String name = b.user?.name ?? 'Guest';
          final String program = b.package?.name ?? 'Special Program';

          String date = 'N/A';
          if (b.startDate != null) {
            try {
              date = DateFormat('M/d/yyyy').format(DateTime.parse(b.startDate!));
            } catch (_) {}
          }

          final String status = b.status != null && b.status!.isNotEmpty
              ? b.status![0].toUpperCase() + b.status!.substring(1)
              : 'Pending';

          final String price = formatIndianPrice((b.totalAmount ?? 0).toDouble());
          const String avatarUrl =
              'https://digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png';

          recentBookings = bookings ;
        }
      }
    } catch (e) {
      debugPrint('Error fetching wellness home data: $e');
    } finally {
      isLoading = false;
      update();
    }
  }
}
