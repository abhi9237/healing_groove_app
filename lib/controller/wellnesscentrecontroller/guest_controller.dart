import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../presentation/model/common/doc_model.dart';
import '../../../presentation/model/response/wellness_booking_response_model.dart';
import '../../../repository/booking_management_repo.dart';

class GuestController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final BookingManagementRepository _repository = BookingManagementRepository();

  List<DocModel> guestList = [];
  List<DocModel> filteredGuests = [];
  String selectedStatus = 'All Status';
  bool isLoading = false;

  // Guest Statistics Mappings
  final Map<String, int> guestBookingsCount = {};
  final Map<String, double> guestTotalSpend = {};
  final Map<String, String> guestLastBookingDate = {};
  final Map<String, bool> guestIsReturning = {};

  List<DocModel> get uniqueGuests {
    final Set<String> seenUserIds = {};
    final List<DocModel> uniqueList = [];

    for (var booking in guestList) {
      final String name = booking.user?.name ??
          (booking.guests != null && booking.guests!.isNotEmpty
              ? booking.guests![0].fullName ?? ''
              : '');
      final String key = booking.userId?.toString() ?? booking.user?.id?.toString() ?? name;
      if (key.isNotEmpty && seenUserIds.add(key)) {
        uniqueList.add(booking);
      }
    }
    return uniqueList;
  }

  // Computed dashboard statistics
  int get totalGuestsCount => uniqueGuests.length;
  
  int get activeGuestsCount {
    return uniqueGuests.where((g) {
      final s = (g.status ?? '').toLowerCase();
      return s == 'confirmed' || s == 'in_progress' || s == 'requested' || s == 'pending';
    }).length;
  }

  int get returningGuestsCount => guestIsReturning.values.where((v) => v == true).length;
  
  double get totalRevenue {
    return guestList
        .where((g) => (g.status ?? '').toLowerCase() == 'confirmed' || (g.status ?? '').toLowerCase() == 'completed')
        .fold(0.0, (sum, item) => sum + (item.totalAmount ?? 0).toDouble());
  }

  @override
  void onInit() {
    super.onInit();
    fetchGuests();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchGuests() async {
    isLoading = true;
    update();

    try {
      final response = await _repository.getCentreBookings(page: 1, limit: 100);
      if (response.statusCode == 200 && response.data != null) {
        final bookingResponse = WellnessBookingResponseModel.fromJson(response.data as Map<String, dynamic>);
        guestList = bookingResponse.docs ?? [];
        _calculateGuestStats();
      } else {
        log('GuestController: fetchGuests failed with status ${response.statusCode}');
      }
    } catch (e) {
      log('GuestController: fetchGuests failed with error $e');
    } finally {
      applyFilters();
      isLoading = false;
      update();
    }
  }

  void _calculateGuestStats() {
    guestBookingsCount.clear();
    guestTotalSpend.clear();
    guestLastBookingDate.clear();
    guestIsReturning.clear();

    for (var booking in guestList) {
      final String name = booking.user?.name ??
          (booking.guests != null && booking.guests!.isNotEmpty
              ? booking.guests![0].fullName ?? ''
              : '');
      if (name.isEmpty) continue;

      guestBookingsCount[name] = (guestBookingsCount[name] ?? 0) + 1;
      
      if ((booking.status ?? '').toLowerCase() == 'confirmed' || (booking.status ?? '').toLowerCase() == 'completed') {
        guestTotalSpend[name] = (guestTotalSpend[name] ?? 0.0) + (booking.totalAmount ?? 0).toDouble();
      }

      String dateStr = '—';
      if (booking.startDate != null) {
        try {
          dateStr = DateFormat('M/d/yyyy').format(DateTime.parse(booking.startDate!));
        } catch (_) {}
      }
      guestLastBookingDate[name] = dateStr;
    }

    guestBookingsCount.forEach((name, count) {
      guestIsReturning[name] = count > 1;
    });
  }

  void onSearchChanged(String query) {
    applyFilters();
  }

  void onStatusChanged(String? status) {
    if (status != null) {
      selectedStatus = status;
      applyFilters();
    }
  }

  void applyFilters() {
    final query = searchController.text.trim().toLowerCase();

    filteredGuests = uniqueGuests.where((booking) {
      final String name = (booking.user?.name ??
          (booking.guests != null && booking.guests!.isNotEmpty
              ? booking.guests![0].fullName ?? ''
              : '')).toLowerCase();
      final String email = (booking.user?.email ?? booking.email ?? '').toLowerCase();

      final matchesQuery = query.isEmpty || name.contains(query) || email.contains(query);

      bool matchesStatus = false;
      if (selectedStatus == 'All Status') {
        matchesStatus = true;
      } else if (selectedStatus == 'Returning') {
        final String guestName = booking.user?.name ??
            (booking.guests != null && booking.guests!.isNotEmpty
                ? booking.guests![0].fullName ?? ''
                : '');
        matchesStatus = guestIsReturning[guestName] == true;
      } else {
        final String targetStatus = selectedStatus.toLowerCase();
        final String currentStatus = (booking.status ?? '').toLowerCase();
        if (targetStatus == 'requested') {
          matchesStatus = currentStatus == 'requested' || currentStatus == 'pending';
        } else if (targetStatus == 'in progress') {
          matchesStatus = currentStatus == 'in_progress' || currentStatus == 'in progress';
        } else {
          matchesStatus = currentStatus == targetStatus;
        }
      }

      return matchesQuery && matchesStatus;
    }).toList();

    update();
  }
}
