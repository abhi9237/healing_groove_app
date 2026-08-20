import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/repository/view_detail_repository.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import '../../common/common_bottom_sheet.dart';

import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/common/packages_model.dart';

class EnquireNowController extends GetxController {
  Map<String, dynamic>? argsData;
  EnquireNowController({this.argsData});

  final ViewDetailRepository viewDetailRepository = ViewDetailRepository();
  RxBool isLoading = false.obs;

  DocModel? centerDetail;
  List<PackagesModel> centerPackages = [];
  PackagesModel? selectedPackage;

  final List<String> programs = [
    'Panchakarma Essential',
    'Immunity Boost',
    'Stress Management',
    'Detox & Weight Loss',
    'Panchakarma Essential',
    'Immunity Boost',
  ];

  int selectedProgramIndex = 2; // Default is 'Stress Management'
  DateTime? preferredStartDate;
  int guestCount = 1;
  final TextEditingController messageController = TextEditingController();

  List<GuestDetailModel> guests = [];

  @override
  void onInit() {
    super.onInit();
    guests = [GuestDetailModel(index: 1, initialName: '', initialAge: '')];
    guestCount = guests.length;
    parseArgs();
  }

  void parseArgs() {
    if (argsData != null) {
      centerDetail = argsData!['center'] as DocModel?;
      if (argsData!['packages'] is List) {
        centerPackages = List<PackagesModel>.from(argsData!['packages']);
      }
      selectedPackage = argsData!['selectedPackage'] as PackagesModel?;
    }

    if (centerPackages.isNotEmpty) {
      programs.clear();
      for (var p in centerPackages) {
        if (p.name != null && p.name!.isNotEmpty) {
          programs.add(p.name!);
        }
      }
      if (selectedPackage != null) {
        final index = centerPackages.indexWhere((p) => p.id == selectedPackage!.id);
        if (index != -1) {
          selectedProgramIndex = index;
        } else {
          selectedProgramIndex = 0;
        }
      } else {
        selectedProgramIndex = 0;
      }
    }
  }

  String get formattedDate {
    if (preferredStartDate == null) {
      return 'mm/dd/yyyy';
    }
    final String month = preferredStartDate!.month.toString().padLeft(2, '0');
    final String day = preferredStartDate!.day.toString().padLeft(2, '0');
    final String year = preferredStartDate!.year.toString();
    return '$month/$day/$year';
  }

  void selectProgram(int index) {
    selectedProgramIndex = index;
    update();
  }

  void updateStartDate(DateTime date) {
    preferredStartDate = date;
    update();
  }

  void incrementGuests() {
    guests.add(
      GuestDetailModel(
        index: guests.length + 1,
        initialName: '',
        initialAge: '',
      ),
    );
    guestCount = guests.length;
    update();
  }

  void decrementGuests() {
    if (guestCount > 1 && guests.length > 1) {
      guests.removeLast();
      guestCount = guests.length;
      update();
    }
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

  void selectGenderForGuest(int guestIndex, String gender) {
    if (guestIndex >= 0 && guestIndex < guests.length) {
      guests[guestIndex].selectedGender = gender;
      update();
    }
  }

  void showGenderBottomSheetForGuest(BuildContext context, int guestIndex) {
    if (guestIndex < 0 || guestIndex >= guests.length) return;
    final guest = guests[guestIndex];

    showGenderBottomSheet(
      context: context,
      title: 'Select Gender',
      items: ['Male', 'Female', 'Other'],
      selectedValue: guest.rxSelectedGender,
      onSelected: (gender) {
        selectGenderForGuest(guestIndex, gender);
      },
    );
  }

  Future<void> submitEnquiry(BuildContext context) async {
    if (preferredStartDate == null) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please select preferred start date',
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

    if (messageController.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter additional message details',
        context: context,
        isError: true,
      );
      return;
    }

    try {
      isLoading.value = true;
      update();

      final String formattedDateStr =
          "${preferredStartDate!.year}-${preferredStartDate!.month.toString().padLeft(2, '0')}-${preferredStartDate!.day.toString().padLeft(2, '0')}";

      final List<int> serviceIds = [];
      final List<String> wellnessGoals = List<String>.from(centerDetail?.wellnessGoals ?? []);

      if (centerPackages.isNotEmpty && selectedProgramIndex < centerPackages.length) {
        final packageData = centerPackages[selectedProgramIndex];
        final packageId = packageData.id;
        if (packageId != null) {
          for(var i in packageData.services ??[]) {
            serviceIds.add(i.id);
          }
        }
        final programName = packageData.name;
        if (programName != null && programName.isNotEmpty) {
          wellnessGoals.add(programName);
        }
      }

      final String userEmail = HiveStorageService.getUserEmail() ?? '';

      final Map<String, dynamic> payload = {
        'center': centerDetail?.id,
        'type': 'consultation',
        'requirements': {
          'concern': messageController.text.trim(),
          'wellnessGoals': wellnessGoals,
          'groupSize': guestCount,
          'preferredDate': formattedDateStr,
          'guestDetails': guests.map((g) => {
            'name': g.nameController.text.trim(),
            'age': g.ageController.text.trim(),
            'gender': g.selectedGender,
          }).toList(),
          'stayDuration': 'flexible',
          'preferredContact': userEmail.isNotEmpty ? userEmail : 'email',
          'budgetComfort': 'flexible',
        },
        'service': serviceIds,
      };

      final response = await viewDetailRepository.enquireService(payload);

      if (response.statusCode == 200 || response.statusCode == 201) {
        String successMessage = 'Enquiry submitted successfully!';
        if (response.data is Map<String, dynamic> && response.data['message'] != null) {
          successMessage = response.data['message'].toString();
        }

        // Show success snackbar
        if (context.mounted) {



          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle_rounded, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      successMessage,
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color(0xFF08864F),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }

        // Clear all fields
        clearFields();
      } else {
        String errorMessage = 'Failed to submit enquiry';
        if (response.data is Map<String, dynamic> && response.data['message'] != null) {
          errorMessage = response.data['message'].toString();
        }
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: errorMessage,
            context: context,
            isError: true,
          );
        }
      }
    } catch (e) {
      log('EnquireNowController: Error submitting enquiry: $e');
      if (context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Something went wrong. Please try again.',
          context: context,
          isError: true,
        );
      }
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void clearFields() {
    preferredStartDate = null;
    messageController.clear();
    guests = [GuestDetailModel(index: 1, initialName: '', initialAge: '')];
    guestCount = 1;
    parseArgs();
    update();
  }

  @override
  void onClose() {
    messageController.dispose();
    for (var guest in guests) {
      guest.nameController.dispose();
      guest.ageController.dispose();
    }
    super.onClose();
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
