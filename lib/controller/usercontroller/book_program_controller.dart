import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/controller/usercontroller/payment_controller.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/presentation/model/common/dates_model.dart';
import 'package:healing/presentation/model/common/packages_model.dart';
import 'package:healing/presentation/model/response/booking_response_model.dart';

import '../../common/common_bottom_sheet.dart';
import '../../core/color_constant/color_constant.dart';
import '../../presentation/model/common/booking_request_model.dart';
import '../../presentation/model/common/service_model.dart';
import '../../presentation/model/response/error_response_model.dart';
import '../../presentation/model/response/seat_availability_response_model.dart';
import '../../repository/book_program_repository.dart';
import '../../common/booking_reserved_dialog.dart';

class BookProgramController extends GetxController {
  PackagesModel? argsData;
  DatesModel seatsData = DatesModel(remaining: 1000);
  BookProgramController({this.argsData});
  BookProgramRepository bookProgramRepository = BookProgramRepository();
  // Data State Variables
  PackagesModel? packageModel;
  List<DateTime> availableDateList = [];
  DateTime currentDisplayedMonth = DateTime(2026, 7);
  DateTime? selectedDate;
  RxBool isLoading = false.obs;
  RxBool isBookingLoading = false.obs;
  BookingRequestModel bookingRequestModel = BookingRequestModel();
  int groupSize = 1;
  int pricePerPerson = 0;
  String packageTitle = 'Mountain Expedition';
  int durationDays = 0;
  int minGuests = 0;
  int maxGuests = 0;
  int totalSeats = 0;
  int bookedSeats = 0;

  // Dynamic list of guest details
  List<GuestDetailModel> guests = [];

  // Month Names Array
  static const List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  // Arrays & Lists
  List<String> genderOptions = ['Male', 'Female', 'Other'];
  List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void onInit() {
    super.onInit();
    parseArgsData();

    // Initialize initial guest (Guest #1)
    guests = [GuestDetailModel(index: 1, initialName: '', initialAge: '')];
    groupSize = guests.length;
  }

  int calculateServicePrice(List<ServiceModel> servicesList) {
    int price = 0;

    if (servicesList.isNotEmpty) {
      for (var i in servicesList) {
        price = price + (i.basePrice ?? 0);
      }
    }

    return price;
  }

  void parseArgsData() {
    if (argsData != null) {
      if (argsData is PackagesModel) {
        packageModel = argsData as PackagesModel;
      } else if (argsData is Map<String, dynamic>) {
        final mapData = argsData as Map<String, dynamic>;
        if (mapData['package'] is PackagesModel) {
          packageModel = mapData['package'] as PackagesModel;
        } else {
          try {
            packageModel = PackagesModel.fromJson(mapData);
          } catch (_) {}
        }
      }

      packageTitle = packageModel?.name ?? '';
      durationDays = packageModel?.duration ?? 0;
      minGuests = packageModel?.minGuests ?? 0;
      maxGuests = packageModel?.maxGuests ?? 0;

      pricePerPerson = calculateServicePrice(packageModel?.services ?? []);
    }

    // Parse Available Dates from PackagesModel or raw JSON
    availableDateList.clear();
    if (packageModel?.availableDates != null &&
        packageModel!.availableDates!.isNotEmpty) {
      for (var d in packageModel!.availableDates!) {
        if (d.date != null &&
            (d.status == null || d.status?.toLowerCase() == 'available')) {
          DateTime? parsed = DateTime.tryParse(d.date!);
          if (parsed != null) {
            availableDateList.add(parsed.toLocal());
          }
        }
      }
    } else {
      final rawList = argsData!.availableDates ?? [];
      for (var item in rawList) {
        if (item is Map<String, dynamic> &&
            (item.status == null ||
                item.status.toString().toLowerCase() == 'available')) {
          if (item.date != null) {
            DateTime? parsed = DateTime.tryParse(item.date.toString());
            if (parsed != null) {
              availableDateList.add(parsed.toLocal());
            }
          }
        }
      }
    }

    if (availableDateList.isNotEmpty) {
      selectedDate = null;
      if (selectedDate != null) {
        currentDisplayedMonth = DateTime(
          selectedDate!.year,
          selectedDate!.month,
        );
      } else {
        currentDisplayedMonth = DateTime.now();
      }
    } else {
      selectedDate = null;
      currentDisplayedMonth = DateTime(2026, 7);
    }
  }

  // Date Check Helpers
  bool isDateAvailable(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    log('availableDateList ${availableDateList.length}');
    return availableDateList.any((d) {
      final availableDate = DateTime(d.year, d.month, d.day);

      return d.year == date.year &&
          d.month == date.month &&
          d.day == date.day &&
          availableDate.isAfter(today); // future only
    });
  }

  bool isDateSelected(DateTime date) {
    log('$selectedDate');
    if (selectedDate == null) return false;
    return selectedDate!.year == date.year &&
        selectedDate!.month == date.month &&
        selectedDate!.day == date.day;
  }

  // Month Navigation
  void prevMonth() {
    currentDisplayedMonth = DateTime(
      currentDisplayedMonth.year,
      currentDisplayedMonth.month - 1,
    );
    update();
  }

  void nextMonth() {
    currentDisplayedMonth = DateTime(
      currentDisplayedMonth.year,
      currentDisplayedMonth.month + 1,
    );
    update();
  }

  // Calculations
  int get totalPrice => groupSize * pricePerPerson;
  int get totalCalculatedPrice => totalPrice;
  int get remainingSeats => totalSeats - bookedSeats;

  // Click & User Action Handlers
  void selectDate(DateTime date) {
    if (isDateAvailable(date)) {
      selectedDate = date;
      getSeatAvailability(date: date);
      update();
    }
  }

  void incrementGroupSize() {
    if (groupSize < maxGuests) {
      guests.add(
        GuestDetailModel(
          index: guests.length + 1,
          initialName: '',
          initialAge: '',
        ),
      );
      groupSize = guests.length;
      update();
    }
  }

  void decrementGroupSize() {
    if (groupSize > minGuests && guests.length > 1) {
      guests.removeLast();
      groupSize = guests.length;
      update();
    }
  }

  void selectGenderForGuest(int guestIndex, String gender) {
    if (guestIndex >= 0 && guestIndex < guests.length) {
      guests[guestIndex].selectedGender = gender;
      update();
    }
  }

  void onProceedToReview(BuildContext context) {
    if (selectedDate == null) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please select a date',
        context: context,
        isError: true,
      );
      return;
    }

    if (guests.length > (seatsData.remaining ?? 0)) {
      showToastMessage(
        titleMessage: 'Error',
        message:
            'Only ${seatsData.remaining ?? 0} seat(s) are available. Please reduce the number of guests.',
        context: context,
        isError: true,
      );
      return;
    }

    for (int i = 0; i < guests.length; i++) {
      final guest = guests[i];
      final name = guest.nameController.text.trim();
      final age = guest.ageController.text.trim();

      if (name.isEmpty) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Please enter full name for Guest ${i + 1}',
          context: context,
          isError: true,
        );
        return;
      }

      if (age.isEmpty) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Please enter age for Guest ${i + 1}',
          context: context,
          isError: true,
        );
        return;
      }
    }

    final formattedDate =
        "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";

    showToastMessage(
      titleMessage: 'Booking Summary',
      message: 'Proceeding for $groupSize guest(s) for date $formattedDate',
      context: context,
      isError: false,
    );

    bookingRequestModel = BookingRequestModel(
      center: packageModel?.center?.id ?? 0,
      groupSize: groupSize,
      startDate: selectedDate.toString(),
      totalAmount: totalPrice,
      package: packageModel?.id ?? 0,
      status: 'initiated',
      guests: guests.map((guest) {
        return BookingGuest(
          fullName: guest.nameController.text,
          age: int.parse(guest.ageController.text),
          gender: guest.selectedGender,
        );
      }).toList(),
    );
    context.push(RouteConstant.reviewBooking);
  }

  Future<void> selectAgeForGuest(BuildContext context, int guestIndex) async {
    if (guestIndex < 0 || guestIndex >= guests.length) return;
    final guest = guests[guestIndex];

    final DateTime today = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: today,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorConstant.appColor,
              onPrimary: Colors.white,
              onSurface: ColorConstant.lightBlackColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorConstant.appColor,
                textStyle: const TextStyle(
                  fontFamily: 'Afacad',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      int calculatedAge = today.year - picked.year;
      if (today.month < picked.month ||
          (today.month == picked.month && today.day < picked.day)) {
        calculatedAge--;
      }
      guest.ageController.text = calculatedAge.toString();
      update();
    }
  }

  void showGenderBottomSheetForGuest(BuildContext context, int guestIndex) {
    if (guestIndex < 0 || guestIndex >= guests.length) return;
    final guest = guests[guestIndex];

    showGenderBottomSheet(
      context: context,
      title: 'Select Gender',
      items: genderOptions,
      selectedValue: guest.rxSelectedGender,
      onSelected: (gender) {
        selectGenderForGuest(guestIndex, gender);
      },
    );
  }

  Future<void> getSeatAvailability({DateTime? date}) async {
    try {
      isLoading.value = true;
      var response = await bookProgramRepository.getSeatAvailability(
        argsData?.id ?? 0,
      );
      if (response.statusCode == 200) {
        SeatAvailabilityResponseModel centerResponseModel =
            SeatAvailabilityResponseModel.fromJson(response.data);

        seatsData = (centerResponseModel.dates ?? []).firstWhere(
          (item) {
            if (item.date == null || item.date!.isEmpty) return false;

            final itemDate = DateTime.parse(item.date!);

            return itemDate.year == date?.year &&
                itemDate.month == date?.month &&
                itemDate.day == date?.day;
          },
          orElse: () => DatesModel(
            remaining: 1000,
          ), // Only works if seatsData type is nullable
        );

        if (seatsData.booked != null) {
          maxGuests = seatsData.remaining ?? 0;
        }
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
    }
    update();
  }

  Future<void> createBooking(
    BuildContext context,
    Map<String, dynamic> data,
  ) async {
    try {
      isBookingLoading.value = true;
      var response = await bookProgramRepository.createBooking(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        BookingResponseModel bookingResponseModel =
            BookingResponseModel.fromJson(response.data);

        final targetContext = Get.context ?? context;
        if (targetContext.mounted) {
          showBookingReservedDialog(
            context: targetContext,
            bookingResponse: bookingResponseModel,
            programName: packageTitle,
            guestCount: groupSize,
            totalAmount: totalPrice,
            onPayNow: () {
              var payloadData = {
                'bookingId': bookingResponseModel.doc?.id ?? 0,
              };
              final paymentController = Get.find<PaymentController>();
              paymentController.context = targetContext;
              paymentController.createBookingOrder(
                targetContext,
                payloadData,
              );
            },
            onPayLater: () {
              targetContext.go(RouteConstant.userDashboard);
            },
          );
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
      isBookingLoading.value = false;
    }
    update();
  }
}

class GuestDetailModel {
  final int index;
  final TextEditingController nameController;
  final TextEditingController ageController;
  RxString rxSelectedGender;

  GuestDetailModel({
    required this.index,
    String initialName = '',
    String initialAge = '',
    String initialGender = 'Male',
  }) : nameController = TextEditingController(text: initialName),
       ageController = TextEditingController(text: initialAge),
       rxSelectedGender = RxString(initialGender);

  String get selectedGender => rxSelectedGender.value;
  set selectedGender(String val) => rxSelectedGender.value = val;
}
