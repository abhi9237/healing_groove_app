import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/controller/wellnesscentrecontroller/program_and_packages_controller.dart';
import 'package:healing/controller/wellnesscentrecontroller/program_preview_detail_controller.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/response/add_program_response_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/presentation/model/response/upload_image_response_model.dart';
import 'package:healing/repository/add_new_program_repository.dart';
import 'package:healing/repository/services_repository.dart';
import 'package:healing/presentation/model/response/services_response_model.dart';

import '../../common/common_methods.dart';
import '../../presentation/model/response/error_response_model.dart';

class AddNewProgramController extends GetxController {
  final DocModel? program;
  final AddNewProgramRepository _repository = AddNewProgramRepository();

  AddNewProgramController({this.program});

  bool get isUpdateMode => program != null;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController minGuestsController = TextEditingController();
  final TextEditingController maxGuestsController = TextEditingController();

  final Rxn<File> programImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;

  String selectedStatus = 'draft';
  final List<ProgramStatus> statusOptions = [
    ProgramStatus(status: 'draft', text: 'Draft (only visible to you)'),
    ProgramStatus(
      status: 'pending_approval',
      text: 'Pending Approval (visible to you and admin)',
    ),
    ProgramStatus(status: 'live', text: 'Live (visible to everyone)'),
    ProgramStatus(status: 'rejected', text: 'Rejected '),
  ];

  // Selected dates on calendar
  final List<DateTime> selectedDates = [DateTime(2026, 8, 27)];
  DateTime currentDisplayedMonth = DateTime(2026, 8, 1);

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

  final List<String> weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  void prevMonth() {
    currentDisplayedMonth = DateTime(
      currentDisplayedMonth.year,
      currentDisplayedMonth.month - 1,
      1,
    );
    update();
  }

  void nextMonth() {
    currentDisplayedMonth = DateTime(
      currentDisplayedMonth.year,
      currentDisplayedMonth.month + 1,
      1,
    );
    update();
  }

  bool isDateSelected(DateTime date) {
    return selectedDates.any(
      (d) => d.year == date.year && d.month == date.month && d.day == date.day,
    );
  }

  void selectDate(DateTime date) {
    final existingIndex = selectedDates.indexWhere(
      (d) => d.year == date.year && d.month == date.month && d.day == date.day,
    );
    if (existingIndex >= 0) {
      selectedDates.removeAt(existingIndex);
    } else {
      selectedDates.add(date);
    }
    update();
  }

  void pickImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16, left: 16),
                  child: Text(
                    'Select Image Source',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.blackColor,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library_outlined,
                    color: Color(0xFF08864F),
                  ),
                  title: const Text('Photo Gallery'),
                  onTap: () {
                    Navigator.of(bc).pop();
                    _performImagePick(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_outlined,
                    color: Color(0xFF08864F),
                  ),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.of(bc).pop();
                    _performImagePick(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _performImagePick(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        programImage.value = File(pickedFile.path);
        update();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  // Available Services
  List<DocModel> services = [];
  final ServicesRepository _servicesRepository = ServicesRepository();
  bool isServicesLoading = false;

  Future<void> fetchServices() async {
    isServicesLoading = true;
    update();
    try {
      final centerId = HiveStorageService.getCenterId() ?? 0;
      final response = await _servicesRepository.getServices(
        centerId: centerId,
        limit: 100,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final servicesResponse = ServicesResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        if (servicesResponse.docs != null) {
          services = servicesResponse.docs ?? [];

          if (isUpdateMode && program!.services != null) {
            final activeServiceIds = program!.services!
                .map((s) => s.id)
                .toSet();
            for (var svc in services) {
              if (activeServiceIds.contains(svc.id)) {
                svc.isActive = true;
              } else {
                svc.isActive = false;
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching services: $e');
    } finally {
      isServicesLoading = false;
      _calculateTotals();
      update();
    }
  }

  // Calculated estimates
  int programPrice = 0;
  int selectedServicesPrice = 0;
  int totalEstimate = 0;

  @override
  void onInit() {
    super.onInit();
    priceController.addListener(_onPriceChanged);

    if (isUpdateMode) {
      nameController.text = program!.name ?? program!.title ?? '';
      descriptionController.text = program!.description ?? '';
      durationController.text = program!.duration?.toString() ?? '1';
      priceController.text = (program!.price ?? program!.basePrice ?? 0)
          .toString();
      minGuestsController.text = program!.minGuests?.toString() ?? '1';
      maxGuestsController.text = program!.maxGuests?.toString() ?? '10';

      final rawStatus = (program!.approvalStatus ?? program!.status ?? 'draft')
          .toLowerCase();
      selectedStatus = rawStatus == 'pending_approval' || rawStatus == 'pending'
          ? 'pending_approval'
          : (rawStatus == 'live'
                ? 'live'
                : (rawStatus == 'rejected' ? 'rejected' : 'draft'));

      selectedDates.clear();
      if (program!.availableDates != null) {
        for (var avDate in program!.availableDates!) {
          if (avDate.date != null) {
            try {
              selectedDates.add(DateTime.parse(avDate.date!));
            } catch (_) {}
          }
        }
      }
    }

    fetchServices();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    durationController.dispose();
    priceController.dispose();
    minGuestsController.dispose();
    maxGuestsController.dispose();
    super.onClose();
  }

  void _onPriceChanged() {
    _calculateTotals();
  }

  void onStatusChanged(String? status) {
    if (status != null) {
      selectedStatus = status;
      update();
    }

    log('selectedStatus===> ${selectedStatus}');
  }

  void toggleService(int index) {
    services[index].isActive = !(services[index].isActive as bool);
    _calculateTotals();
  }

  void addCustomService(BuildContext context) async {
    context.push(RouteConstant.wellnessServices).then((_) {
      fetchServices();
    });
  }

  void _calculateTotals() {
    final parsedPrice = int.tryParse(priceController.text) ?? 0;
    programPrice = parsedPrice;

    int servicesSum = 0;
    for (var svc in services) {
      if (svc.isActive as bool) {
        servicesSum += svc.basePrice as int;
      }
    }
    selectedServicesPrice = servicesSum;
    totalEstimate = programPrice + selectedServicesPrice;
    update();
  }

  Future<void> submitProgram(BuildContext context) async {
    if (nameController.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Program Name is required.',
        context: context,
        isError: true,
      );
      return;
    }

    if (durationController.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter the duration of the program.',
        context: context,
        isError: true,
      );
      return;
    }

    if (minGuestsController.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter the minimum number of guests.',
        context: context,
        isError: true,
      );
      return;
    }

    if (maxGuestsController.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter the maximum number of guests.',
        context: context,
        isError: true,
      );
      return;
    }

    if (selectedDates.isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please select available dates for the program.',
        context: context,
        isError: true,
      );
      return;
    }
    isLoading = true;
    update();

    try {
      int? imageId = isUpdateMode ? program!.image?.id : null;
      if (programImage.value != null) {
        final uploadResponse = await _repository.uploadImage(
          imageFile: programImage.value!,
          programName: nameController.text.trim(),
        );

        if (uploadResponse.statusCode == 200 ||
            uploadResponse.statusCode == 201) {
          if (uploadResponse.data != null) {
            final parsedUpload = UploadImageModelResponse.fromJson(
              uploadResponse.data as Map<String, dynamic>,
            );
            imageId = parsedUpload.doc?.id;
            debugPrint('Successfully uploaded program image with ID: $imageId');
          }
        } else {
          throw Exception(
            'Upload failed with status code ${uploadResponse.statusCode}',
          );
        }
      }

      final centerId = HiveStorageService.getCenterId() ?? 0;
      final selectedServicesList = services
          .where((s) => s.isActive as bool)
          .map((s) => s.id as int)
          .toList();

      final datesPayload = selectedDates.map((d) {
        final formattedDate =
            "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
        return {"date": formattedDate, "status": "available"};
      }).toList();

      final payload = {
        "center": centerId,
        "name": nameController.text.trim(),
        "description": descriptionController.text.trim(),
        "price": int.tryParse(priceController.text.trim()) ?? 0,
        "duration": int.tryParse(durationController.text.trim()) ?? 1,
        "minGuests": int.tryParse(minGuestsController.text.trim()) ?? 1,
        "maxGuests": int.tryParse(maxGuestsController.text.trim()) ?? 10,
        "isActive": false,
        "approvalStatus": selectedStatus,
        "services": selectedServicesList,
        "doctors": [],
        "image": imageId,
        "availableDates": datesPayload,
      };

      final response = isUpdateMode
          ? await _repository.updateProgram(
              programId: program!.id!,
              data: payload,
            )
          : await _repository.addProgram(data: payload);

      if (response.statusCode == 200 || response.statusCode == 201) {
        AddProgramResponseModel programResponse =
            AddProgramResponseModel.fromJson(
              response.data as Map<String, dynamic>,
            );

        if (isUpdateMode) {
          Get.find<ProgramPreviewDetailController>().program =
              programResponse.doc ?? DocModel();
        } else {
          Get.find<ProgramAndPackagesController>().filteredPrograms.add(
            programResponse.doc ?? DocModel(),
          );
        }

        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Success',
            message: isUpdateMode
                ? 'Program successfully updated!'
                : 'Program successfully created!',
            context: context,
            isError: false,
          );
          Navigator.of(context).pop();
        }
      } else {
        final errorResponse = ErrorResponseModel.fromJson(response.data);

        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message:
                errorResponse.errors?.first.message ??
                (isUpdateMode
                    ? 'Failed to update program. Please try again.'
                    : 'Failed to create program. Please try again.'),
            context: context,
            isError: true,
          );
        }
      }
    } catch (e) {
      debugPrint('Error creating program: $e');
      if(context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Failed to create program. Please try again.',
          context: context,
          isError: true,
        );
      }
    } finally {
      isLoading = false;
      update();
    }
  }
}

class ProgramStatus {
  String? status;
  String? text;
  ProgramStatus({this.text, this.status});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgramStatus &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          text == other.text;

  @override
  int get hashCode => (status ?? '').hashCode ^ (text ?? '').hashCode;
}
