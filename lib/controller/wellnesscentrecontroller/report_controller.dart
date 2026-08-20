import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/repository/revenue_repository.dart';
import 'package:healing/presentation/model/response/booking_response_model.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/presentation/model/common/doc_model.dart';

class ReportController extends GetxController {
  final RevenueRepository _revenueRepository = RevenueRepository();

  bool isLoading = false;

  int initiatedBookings = 0;
  int confirmedBookings = 0;
  int awaitingConfirmation = 0;

  int totalBookings = 0;
  double totalRevenuePaid = 0.0;
  double avgBookingValue = 0.0;

  @override
  void onInit() {
    super.onInit();
    fetchReport();
  }

  Future<void> fetchReport() async {
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

        totalBookings = bookings.length;

        final confirmedList = bookings
            .where((b) => (b.status ?? '').toLowerCase() == 'confirmed')
            .toList();
        confirmedBookings = confirmedList.length;

        awaitingConfirmation = bookings.where((b) {
          final status = (b.status ?? '').toLowerCase();
          return status == 'awaiting confirmation' ||
              status == 'awaiting_confirmation' ||
              status == 'pending';
        }).length;

        initiatedBookings = totalBookings - confirmedBookings - awaitingConfirmation;
        if (initiatedBookings < 0) initiatedBookings = 0;

        totalRevenuePaid = confirmedList.fold<double>(
          0.0,
          (sum, b) => sum + (b.totalAmount ?? 0).toDouble(),
        );

        avgBookingValue = confirmedList.isNotEmpty
            ? (totalRevenuePaid / confirmedList.length)
            : 0.0;
      }
    } catch (e) {
      debugPrint('Error fetching report: $e');
    } finally {
      isLoading = false;
      update();
    }
  }
}
