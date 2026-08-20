import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_methods.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import '../../../common/common_pop_up.dart';
import '../../../core/storage/hive_storage_service.dart';
import '../../../presentation/model/common/doc_model.dart';
import '../../../presentation/model/common/assigned_doctor.dart';
import '../../../presentation/model/common/packages_model.dart';
import '../../../presentation/model/common/service_model.dart';
import '../../../presentation/model/common/user_model.dart';
import '../../../presentation/model/response/update_booking_response_model.dart';
import '../../../presentation/model/response/doctor_response_model.dart';
import '../../../presentation/model/response/error_response_model.dart';
import '../../../repository/booking_management_repo.dart';
import '../../../repository/my_journey_repository.dart';

class WellnessBookingDetailController extends GetxController {
  final String bookingId;
  final DocModel? initialBooking;
  final BookingManagementRepository _repository = BookingManagementRepository();
  final MyJourneyRepository _myJourneyRepository = MyJourneyRepository();

  WellnessBookingDetailController({
    required this.bookingId,
    this.initialBooking,
  });

  RxBool isLoading = false.obs;
  RxBool isLoadingReceipt = false.obs;
  DocModel? bookingDetails;

  List<DocModel> doctorsList = [];
  bool isLoadingDoctors = false;

  // Mock Database for Booking Details (Fallback)
  final Map<String, DocModel> _mockDetailsDb = {
    'BK-MP3KB6I7': DocModel(
      id: 1,
      bookingNumber: 'BK-MP3KB6I7',
      status: 'Pending',
      totalAmount: 4700,
      package: PackagesModel(
        name: 'Walk Now',
        duration: 5,
        services: [
          ServiceModel(name: 'Morning Walk'),
          ServiceModel(name: 'Panchakarma Detox'),
        ],
      ),
      startDate: '2026-05-14T00:00:00Z',
      hasConsultation: false,
      slotTime: '—',
      assignedDoctor: [
        AssignedDoctor(
          name: 'Dr. Abhishek Shukhla',
          specialization: 'Ayurveda Physician',
        ),
      ],
      user: UserModel(name: 'pappu kumar yadav'),
      chargeAmount: 0,
    ),
    'BK-MOS8JVTI': DocModel(
      id: 2,
      bookingNumber: 'BK-MOS8JVTI',
      status: 'Confirmed',
      totalAmount: 3000,
      package: PackagesModel(
        name: 'Walk Now',
        duration: 5,
        services: [
          ServiceModel(name: 'Morning Walk'),
          ServiceModel(name: 'Yoga Therapy'),
        ],
      ),
      startDate: '2026-05-22T00:00:00Z',
      hasConsultation: true,
      slotTime: '10:00 AM',
      assignedDoctor: [
        AssignedDoctor(
          name: 'Dr. Abhishek Shukhla',
          specialization: 'Ayurveda Physician',
        ),
      ],
      user: UserModel(name: 'Rajat Sharma'),
      chargeAmount: 3000,
    ),
    'BK-MOMRM75L': DocModel(
      id: 3,
      bookingNumber: 'BK-MOMRM75L',
      status: 'Pending',
      totalAmount: 41997,
      package: PackagesModel(
        name: '14 Day Detox Package',
        duration: 14,
        services: [
          ServiceModel(name: 'Daily Herbal Consult'),
          ServiceModel(name: 'Panchakarma Detox'),
          ServiceModel(name: 'Steam Therapy'),
        ],
      ),
      startDate: '2026-05-09T00:00:00Z',
      hasConsultation: false,
      slotTime: '—',
      assignedDoctor: [
        AssignedDoctor(
          name: 'Dr. Abhishek Shukhla',
          specialization: 'Ayurveda Physician',
        ),
      ],
      user: UserModel(name: 'Varsha Chauhan'),
      chargeAmount: 0,
    ),
  };

  @override
  void onInit() {
    super.onInit();
    if (initialBooking != null) {
      bookingDetails = initialBooking;
    }
    fetchDoctorsList();
  }

  Future<void> loadBookingDetails() async {
    if (bookingDetails == null) {
      isLoading.value = true;
      update();
    }

    try {
      final response = await _repository.getBookingDetails(bookingId);
      if (response.statusCode == 200 && response.data != null) {
        bookingDetails = DocModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        log('getBookingDetails failed with status: ${response.statusCode}');
        if (bookingDetails == null) {
          _loadMockBookingDetails();
        }
      }
    } catch (e) {
      log('getBookingDetails failed with error: $e');
      if (bookingDetails == null) {
        _loadMockBookingDetails();
      }
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void _loadMockBookingDetails() {
    bookingDetails = _mockDetailsDb[bookingId] ?? _mockDetailsDb['BK-MP3KB6I7'];
  }

  Future<void> fetchDoctorsList() async {
    isLoadingDoctors = true;
    update();

    try {
      final String userId =
          HiveStorageService.getUserId() ??
          bookingDetails?.userId?.toString() ??
          '';
      final response = await _repository.getDoctors(userId: userId);
      if (response.statusCode == 200 && response.data != null) {
        final doctorsResponse = DoctorResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        doctorsList = doctorsResponse.docs ?? [];
      }
    } catch (e) {
      log('fetchDoctorsList failed with error: $e');
    } finally {
      isLoadingDoctors = false;
      update();
    }
  }

  void updateBookingStatus(BuildContext context) {
    final guestName =
        bookingDetails?.user?.name ??
        (bookingDetails?.guests != null && bookingDetails!.guests!.isNotEmpty
            ? bookingDetails!.guests![0].fullName ?? 'Guest'
            : 'Guest');
    final currentStatus = bookingDetails?.status ?? 'Pending';



    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return UpdateStatusPopUp(
          bookingId: bookingId,
          guestName: guestName,
          initialStatus: currentStatus,
          doctors: doctorsList,
          isLoading: isLoading,
          onSave: (doctor, type, dateTime, status) async {
            await saveBookingUpdates(context, doctor, type, dateTime, status);
          },
        );
      },
    );
  }

  Future<void> saveBookingUpdates(
    BuildContext context,
    int? doctorId,
    String? type,
    String? dateTime,
    String status,
  ) async {
    isLoading.value = true;
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
        bookingId: bookingId,
        data: requestBody,
      );

      if (response.statusCode == 200 && response.data != null) {
        final updateResponse = UpdateBookingResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        if (updateResponse.doc != null) {
          bookingDetails = updateResponse.doc;
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
      isLoading.value = false;
      update();
    }
  }



  void downloadReceipt(BuildContext context) async {
    final idVal = bookingDetails?.id;
    if (idVal != null) {
      await genRateInvoice(idVal);
    } else {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Booking ID not found',
        context: context,
        isError: true,
      );
    }
  }

  Future<void> genRateInvoice(int bookingId) async {
    isLoadingReceipt.value = true;
    update();

    try {
      final response = await _myJourneyRepository.genRateInvoice(bookingId);

      if (response.statusCode == 200 && response.data != null) {
        final dynamic data = response.data;
        log('response.data.runtimeType= ${response.data.runtimeType}');

        final directory = await getApplicationDocumentsDirectory();

        final file = File("${directory.path}/invoice_$bookingId.pdf");

        if (data is List<int>) {
          await file.writeAsBytes(data);
          await OpenFilex.open(file.path);
        } else {
          log('Unexpected response data type: ${data.runtimeType}');
        }
      } else {
        dynamic jsonMap;
        if (response.data is List<int>) {
          try {
            final decoded = utf8.decode(response.data as List<int>);
            jsonMap = jsonDecode(decoded);
          } catch (e) {
            log('Error decoding error response bytes: $e');
          }
        } else if (response.data is String) {
          try {
            jsonMap = jsonDecode(response.data);
          } catch (e) {}
        } else if (response.data is Map) {
          jsonMap = response.data;
        }

        ErrorResponseModel errorResponse =
            ErrorResponseModel.fromJson(jsonMap is Map<String, dynamic> ? jsonMap : {});

        final errorMessage =
            errorResponse.errors?.first.message ??
                'Failed to download invoice';

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
    } catch (e, s) {
      log("Invoice Error: $e");
      log(s.toString());
    } finally {
      isLoadingReceipt.value = false;
      update();
    }
  }
}
