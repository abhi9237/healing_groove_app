import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/repository/doctor_repository.dart';
import 'package:healing/presentation/model/response/wellness_doctor_response_model.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/repository/booking_management_repo.dart';
import 'package:healing/presentation/model/response/doctor_response_model.dart';
import 'package:healing/presentation/model/common/doc_model.dart';

class DoctorController extends GetxController {
  final DoctorRepository _doctorRepository = DoctorRepository();
  final BookingManagementRepository _bookingRepository = BookingManagementRepository();
  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController feeController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();

  bool isPasswordObscured = true;

  // Search and filter controllers
  final TextEditingController searchController = TextEditingController();
  String selectedStatus = 'All Status';
  bool isLoading = false;

  List<Map<String, dynamic>> allDoctorsRaw = [];

  List<Map<String, dynamic>> filteredDoctors = [];

  // Stats
  int get totalDoctorsCount => allDoctorsRaw.length;
  int get approvedDoctorsCount => allDoctorsRaw.where((d) => d['status'] == 'Approved').length;
  int get pendingDoctorsCount => allDoctorsRaw.where((d) => d['status'] == 'Pending').length;
  String get avgExperienceText {
    if (allDoctorsRaw.isEmpty) return '0y';
    final sum = allDoctorsRaw.fold<int>(0, (prev, element) => prev + (element['experienceYears'] as int));
    final avg = sum / allDoctorsRaw.length;
    return '${avg.toStringAsFixed(0)}y';
  }

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    qualificationController.dispose();
    experienceController.dispose();
    feeController.dispose();
    aboutController.dispose();
    specializationController.dispose();
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchDoctors() async {
    isLoading = true;
    update();

    try {
      final String userId = HiveStorageService.getUserId() ?? '';
      final response = await _bookingRepository.getDoctors(userId: userId);

      if (response.statusCode == 200 && response.data != null) {
        final doctorsResponse = DoctorResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );

        final List<DocModel> fetchedDocs = doctorsResponse.docs ?? [];
        allDoctorsRaw = fetchedDocs.map((doc) {
          final feeVal = doc.consultationFee is num
              ? (doc.consultationFee as num).toInt()
              : int.tryParse(doc.consultationFee.toString()) ?? 0;
          final expVal = doc.experienceYears is num
              ? (doc.experienceYears as num).toInt()
              : int.tryParse(doc.experienceYears.toString()) ?? 0;

          return {
            "id": doc.id ?? 0,
            "name": doc.name ?? '',
            "specialization": doc.specialization?.toString() ?? '',
            "qualification": doc.qualification?.toString() ?? '',
            "experienceYears": expVal,
            "consultationFee": feeVal,
            "status": doc.status ?? "Approved",
            "avatarUrl": doc.image?.url ?? "https://digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png"
          };
        }).toList();
      }
    } catch (e) {
      debugPrint('Error fetching doctors: $e');
    } finally {
      applyFilters();
      isLoading = false;
      update();
    }
  }

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    update();
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
    filteredDoctors = allDoctorsRaw.where((doc) {
      final name = (doc['name']?.toString() ?? '').toLowerCase();
      final spec = (doc['specialization']?.toString() ?? '').toLowerCase();
      final id = doc['id']?.toString() ?? '';

      final matchesQuery = query.isEmpty ||
          name.contains(query) ||
          spec.contains(query) ||
          id.contains(query);

      final matchesStatus = selectedStatus == 'All Status' ||
          (doc['status']?.toString() ?? '').toLowerCase() == selectedStatus.toLowerCase();

      return matchesQuery && matchesStatus;
    }).toList();
    update();
  }

  Future<void> addDoctor(BuildContext context) async {
    // 1. Full Name
    if (nameController.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter the doctor\'s name',
        context: context,
        isError: true,
      );
      return;
    }

    // 2. Specialization
    final specialization = specializationController.text.trim();
    if (specialization.isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter the doctor\'s specialization',
        context: context,
        isError: true,
      );
      return;
    }

    // 3. Email
    final email = emailController.text.trim();
    if (email.isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter an email address',
        context: context,
        isError: true,
      );
      return;
    }
    if (!isValidEmail(email)) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter a valid email address',
        context: context,
        isError: true,
      );
      return;
    }

    // 4. Password
    final password = passwordController.text;
    if (password.isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter a temporary password',
        context: context,
        isError: true,
      );
      return;
    }
    if (password.length < 8) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Password must be at least 8 characters long',
        context: context,
        isError: true,
      );
      return;
    }

    // 5. Qualification
    if (qualificationController.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter the doctor\'s qualification',
        context: context,
        isError: true,
      );
      return;
    }

    // 6. Experience
    final experienceStr = experienceController.text.trim();
    if (experienceStr.isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter experience in years',
        context: context,
        isError: true,
      );
      return;
    }
    final expYears = int.tryParse(experienceStr);
    if (expYears == null || expYears < 0) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter a valid number for experience years',
        context: context,
        isError: true,
      );
      return;
    }

    // 7. Consultation Fee
    final feeStr = feeController.text.trim();
    if (feeStr.isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter consultation fee',
        context: context,
        isError: true,
      );
      return;
    }
    final feeNum = double.tryParse(feeStr);
    if (feeNum == null || feeNum < 0) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter a valid consultation fee',
        context: context,
        isError: true,
      );
      return;
    }

    // 8. Phone (Optional, but check format if entered)
    final phone = phoneController.text.trim();
    if (phone.isNotEmpty && phone.length < 10) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter a valid phone number (at least 10 digits)',
        context: context,
        isError: true,
      );
      return;
    }

    isLoading = true;
    update();

    try {
      final managedBy = HiveStorageService.getCenterId() ?? 0;
      final payload = {
        "consultationFee": feeStr,
        "email": email,
        "experienceYears": expYears,
        "managedBy": managedBy,
        "name": nameController.text.trim(),
        "password": password,
        "phone": phone,
        "qualification": qualificationController.text.trim(),
        "role": "doctor",
        "specialization": specialization,
      };

      final response = await _doctorRepository.createDoctor(payload);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final doctorResponse = WellnessDoctorResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );

        final createdDoc = doctorResponse.doc;
        if (createdDoc != null) {
          final feeVal = createdDoc.consultationFee is num
              ? (createdDoc.consultationFee as num).toInt()
              : int.tryParse(createdDoc.consultationFee.toString()) ?? 500;
          final expVal = createdDoc.experienceYears is num
              ? (createdDoc.experienceYears as num).toInt()
              : int.tryParse(createdDoc.experienceYears.toString()) ?? 1;

          final newDocMap = {
            "id": createdDoc.id ?? (60 + allDoctorsRaw.length),
            "name": createdDoc.name ?? nameController.text.trim(),
            "specialization": createdDoc.specialization?.toString() ?? specialization,
            "qualification": createdDoc.qualification?.toString() ?? qualificationController.text.trim(),
            "experienceYears": expVal,
            "consultationFee": feeVal,
            "status": createdDoc.status ?? "Approved",
            "avatarUrl": createdDoc.image?.url ?? "https://digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png"
          };

          allDoctorsRaw.add(newDocMap);
          applyFilters();
        }

        // Clear controllers
        nameController.clear();
        emailController.clear();
        phoneController.clear();
        passwordController.clear();
        qualificationController.clear();
        experienceController.clear();
        feeController.clear();
        aboutController.clear();
        specializationController.clear();

        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Success',
            message: doctorResponse.message ?? 'Doctor added successfully!',
            context: context,
            isError: false,
          );
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: 'Failed to add doctor.',
            context: context,
            isError: true,
          );
        }
      }
    } catch (e) {
      debugPrint('Error adding doctor: $e');
      if (context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'An error occurred while adding doctor.',
          context: context,
          isError: true,
        );
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  void deleteDoctor(int id) {
    allDoctorsRaw.removeWhere((doc) => doc['id'] == id);
    applyFilters();
    update();
  }
}
