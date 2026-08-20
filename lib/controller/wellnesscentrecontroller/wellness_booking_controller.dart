import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/response/wellness_booking_response_model.dart';
import 'package:healing/repository/booking_management_repo.dart';
import '../../common/common_pop_up.dart';
import '../../common/common_methods.dart';
import '../../core/storage/hive_storage_service.dart';
import '../../presentation/model/response/doctor_response_model.dart';
import '../../presentation/model/response/update_booking_response_model.dart';

class WellnessBookingController extends GetxController {
  final BookingManagementRepository _repository = BookingManagementRepository();
  final TextEditingController searchController = TextEditingController();

  WellnessBookingResponseModel? bookingResponse;
  List<DocModel> docsList = [];
  List<DocModel> filteredDocs = [];

  bool isLoading = false;
  int currentPage = 1;
  int limit = 50;
  String selectedStatus = 'All';

  List<DocModel> doctorsList = [];
  bool isLoadingDoctors = false;
  RxBool isSavingUpdate = false.obs;

  void updateSelectedStatus(String status) {
    selectedStatus = status;
    applyFilters();
  }

  // Summary Metrics
  List<Map<String, dynamic>> summaryMetrics = [
    {
      'label': 'Pending',
      'count': 0,
      'icon': Icons.access_time_filled_rounded,
      'color': const Color(0xFF08864F),
    },
    {
      'label': 'Confirmed',
      'count': 0,
      'icon': Icons.check_circle_rounded,
      'color': const Color(0xFF08864F),
    },
    {
      'label': 'Cancelled',
      'count': 0,
      'icon': Icons.cancel_outlined,
      'color': const Color(0xFFEF4444),
    },
  ];

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_onSearchChanged);
    fetchBookingsFromApi();
    fetchDoctorsList();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    searchBookings(searchController.text);
  }

  Future<void> fetchBookingsFromApi({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    }

    if (currentPage == 1) {
      isLoading = true;
      update();
    }

    try {
      final response = await _repository.getCentreBookings(
        page: currentPage,
        limit: limit,
      );

      if (response.statusCode == 200 && response.data != null) {
        bookingResponse = WellnessBookingResponseModel.fromJson(response.data);
        
        if (currentPage == 1) {
          docsList = bookingResponse?.docs ?? [];
        } else {
          docsList.addAll(bookingResponse?.docs ?? []);
        }

        _calculateSummaryMetrics();
        applyFilters();
      }
    } catch (e) {
      log('WellnessBookingController: fetchBookingsFromApi failed with error: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void _calculateSummaryMetrics() {
    final pendingCount = docsList.where((d) {
      final status = (d.status ?? '').toLowerCase();
      return status == 'pending' ||
          status == 'requested' ||
          status == 'awaiting confirmation' ||
          status ==  'initiated'||
          status == 'awaiting_confirmation';
    }).length;

    final confirmedCount = docsList.where((d) {
      final status = (d.status ?? '').toLowerCase();
      return status == 'confirmed';
    }).length;

    final cancelledCount = docsList.where((d) {
      final status = (d.status ?? '').toLowerCase();
      return status == 'cancelled' || status == 'canceled' || status == 'rejected';
    }).length;

    summaryMetrics = [
      {
        'label': 'Pending',
        'count': pendingCount,
        'icon': Icons.access_time_filled_rounded,
        'color': const Color(0xFF08864F),
      },
      {
        'label': 'Confirmed',
        'count': confirmedCount,
        'icon': Icons.check_circle_rounded,
        'color': const Color(0xFF08864F),
      },
      {
        'label': 'Cancelled',
        'count': cancelledCount,
        'icon': Icons.cancel_outlined,
        'color': const Color(0xFFEF4444),
      },
    ];
  }

  void searchBookings(String query) {
    applyFilters();
  }

  void applyFilters() {
    final query = searchController.text.trim().toLowerCase();

    List<DocModel> tempDocs = docsList;
    if (selectedStatus != 'All') {
      tempDocs = docsList.where((doc) {
        final status = (doc.status ?? '').toLowerCase();
        switch (selectedStatus) {
          case 'Pending':
            return status == 'pending' ||
                status == 'requested' ||
                status == 'awaiting confirmation' ||
                status == 'awaiting_confirmation' ||
                status == 'initiated';
          case 'Confirmed':
            return status == 'confirmed';
          case 'In Progress':
            return status == 'in_progress' || status == 'in progress';
          case 'Completed':
            return status == 'completed';
          case 'Cancelled':
            return status == 'cancelled' || status == 'canceled' || status == 'rejected';
          default:
            return true;
        }
      }).toList();
    }

    if (query.isEmpty) {
      filteredDocs = tempDocs;
    } else {
      filteredDocs = tempDocs.where((doc) {
        final userName = (doc.user?.name ?? '').toLowerCase();
        final guestName = (doc.guests != null && doc.guests!.isNotEmpty)
            ? (doc.guests![0].fullName ?? '').toLowerCase()
            : '';
        final bookingNum = (doc.bookingNumber ?? '').toLowerCase();
        final program = (doc.package?.name ??  '').toLowerCase();

        return userName.contains(query) ||
            guestName.contains(query) ||
            bookingNum.contains(query) ||
            program.contains(query);
      }).toList();
    }
    update();
  }

  Future<void> refreshBookings() async {
    await fetchBookingsFromApi(isRefresh: true);
  }

  void viewBookingDetails(String bookingId) {
    // Action details
  }

  Future<void> fetchDoctorsList() async {
    isLoadingDoctors = true;
    update();

    try {
      final String userId = HiveStorageService.getUserId() ?? '';
      final response = await _repository.getDoctors(userId: userId);
      if (response.statusCode == 200 && response.data != null) {
        final doctorsResponse = DoctorResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        doctorsList = doctorsResponse.docs ?? [];
      }
    } catch (e) {
      log('WellnessBookingController: fetchDoctorsList failed with error: $e');
    } finally {
      isLoadingDoctors = false;
      update();
    }
  }

  void editBookingStatus(BuildContext context, DocModel booking) {
    final bookingId =  booking.id ?? 0;
    final guestName =
        booking.user?.name ??
        (booking.guests != null && booking.guests!.isNotEmpty
            ? booking.guests![0].fullName ?? 'Guest'
            : 'Guest');
    final currentStatus = booking.status ?? 'Pending';

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return UpdateStatusPopUp(
          bookingId: bookingId.toString(),
          guestName: guestName,
          initialStatus: currentStatus,
          doctors: doctorsList,
          isLoading: isSavingUpdate,
          onSave: (doctor, type, dateTime, status) async {
            await saveBookingUpdates(context, bookingId, doctor, type, dateTime, status);
          },
        );
      },
    );
  }

  Future<void> saveBookingUpdates(
    BuildContext context,
    int bookingId,
    int? doctorId,
    String? type,
    String? dateTime,
    String status,
  ) async {
    isSavingUpdate.value = true;
    update();

    try {
      final Map<String, dynamic> requestBody = {
        'status': status.toLowerCase(),
      };

      if (doctorId != null) {
        requestBody['assignedDoctor'] = doctorId;
      }

      if (type != null && type.isNotEmpty && type != '—') {
        final String consultationType = type.toLowerCase().replaceAll(' ', '_');
        requestBody['consultationType'] = consultationType;
      }

      if (dateTime != null && dateTime.isNotEmpty && dateTime != '—') {
        String? slotTimeIso;
        try {
          final parsedDateTime = DateFormat(
            'MM/dd/yyyy, hh:mm a',
          ).parse(dateTime);
          slotTimeIso = parsedDateTime.toUtc().toIso8601String();
        } catch (_) {
          try {
            final parsedDateTime = DateTime.parse(dateTime);
            slotTimeIso = parsedDateTime.toUtc().toIso8601String();
          } catch (_) {}
        }
        if (slotTimeIso != null) {
          requestBody['slotTime'] = slotTimeIso;
        }
      }

      final response = await _repository.updateBookingStatus(
        bookingId: bookingId.toString(),
        data: requestBody,
      );

      if (response.statusCode == 200 && response.data != null) {
        final updateResponse = UpdateBookingResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );

        if (updateResponse.doc != null) {
          final updatedDoc = updateResponse.doc ?? DocModel();
          final index = docsList.indexWhere((doc) => doc.id == updatedDoc.id );
          if (index != -1) {
            docsList[index] = updatedDoc;
          }
          applyFilters();
        }

        // Close the dialog / pop Up
        if (context.mounted && Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Success',
            message:
                updateResponse.message ?? 'Booking status successfully updated to $status',
            context: context,
            isError: false,
          );
        }
      } else {
        log(
          'Failed to save status update to backend. Status code: ${response.statusCode}',
        );
        if (context.mounted && Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      log('Error saving booking updates: $e');
      if (context.mounted && Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
    } finally {
      isSavingUpdate.value = false;
      update();
    }
  }
}
