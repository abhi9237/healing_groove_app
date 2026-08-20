import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/repository/revenue_repository.dart';
import 'package:healing/presentation/model/response/booking_response_model.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:intl/intl.dart';

class RevenueController extends GetxController {
  final RevenueRepository _revenueRepository = RevenueRepository();

  bool isLoading = false;

  double totalRevenue = 0.0;
  int activeBookings = 0;
  int completedBookings = 0;
  double growthPercentage = 0.0;

  List<Map<String, dynamic>> monthlyRevenue = [];

  List<String> chartLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
  List<double> chartValues = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

  @override
  void onInit() {
    super.onInit();
    fetchRevenue();
  }

  Future<void> fetchRevenue() async {
    isLoading = true;
    update();

    try {
      final centerId = HiveStorageService.getCenterId() ?? 0;
      final response = await _revenueRepository.getRevenue(centerId: centerId);

      if (response.statusCode == 200 && response.data != null) {
        final bookingResponse = BookingResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );

        List<DocModel> bookings = [];
        if (response.data['docs'] is List) {
          bookings = (response.data['docs'] as List)
              .map((e) => DocModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else if (bookingResponse.doc != null) {
          bookings = [bookingResponse.doc!];
        }

        // Calculations
        final confirmedBookings = bookings
            .where((b) => (b.status ?? '').toLowerCase() == 'confirmed')
            .toList();

        totalRevenue = confirmedBookings.fold<double>(
          0.0,
          (sum, b) => sum + (b.totalAmount ?? 0).toDouble(),
        );

        activeBookings = confirmedBookings.length;
        completedBookings = bookings
            .where((b) => (b.status ?? '').toLowerCase() == 'completed')
            .length;

        // Group monthly revenue based on confirmed bookings and their startDate
        final Map<String, double> revenueMap = {};
        for (var b in bookings) {
          if ((b.status ?? '').toLowerCase() == 'confirmed') {
            try {
              final dateStr = b.startDate ?? b.createdAt ?? '';
              if (dateStr.isNotEmpty) {
                final date = DateTime.parse(dateStr);
                final monthStr = DateFormat('MMMM yyyy').format(date);
                revenueMap[monthStr] =
                    (revenueMap[monthStr] ?? 0.0) + (b.totalAmount ?? 0).toDouble();
              }
            } catch (_) {}
          }
        }

        monthlyRevenue = revenueMap.entries.map((e) {
          return {"month": e.key, "value": e.value};
        }).toList();

        // Sort monthlyRevenue chronologically
        try {
          final DateFormat fmt = DateFormat('MMMM yyyy');
          monthlyRevenue.sort((a, b) {
            final da = fmt.parse(a['month'] as String);
            final db = fmt.parse(b['month'] as String);
            return da.compareTo(db);
          });
        } catch (_) {}

        // Calculate growth percentage
        if (monthlyRevenue.length >= 2) {
          final lastMonthVal = monthlyRevenue[monthlyRevenue.length - 2]['value'] as double;
          final currentMonthVal = monthlyRevenue[monthlyRevenue.length - 1]['value'] as double;
          if (lastMonthVal > 0) {
            growthPercentage = ((currentMonthVal - lastMonthVal) / lastMonthVal) * 100.0;
          } else {
            growthPercentage = currentMonthVal > 0 ? 100.0 : 0.0;
          }
        } else if (monthlyRevenue.length == 1) {
          growthPercentage = (monthlyRevenue[0]['value'] as double) > 0 ? 100.0 : 0.0;
        } else {
          growthPercentage = 0.0;
        }

        // Generate chart data for the last 6 months
        final DateTime now = DateTime.now();
        final List<DateTime> last6Months = List.generate(
          6,
          (i) => DateTime(now.year, now.month - (5 - i), 1),
        );
        chartLabels = last6Months.map((d) => DateFormat('MMM').format(d)).toList();

        chartValues = last6Months.map((d) {
          final monthStr = DateFormat('MMMM yyyy').format(d);
          final found = monthlyRevenue.firstWhereOrNull((m) => m['month'] == monthStr);
          return found != null ? (found['value'] as double) : 0.0;
        }).toList();
      }
    } catch (e) {
      debugPrint('Error fetching revenue: $e');
    } finally {
      isLoading = false;
      update();
    }
  }
}
