import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/presentation/model/response/user_profile_response_model.dart';
import 'package:healing/presentation/model/response/error_response_model.dart';
import 'package:healing/core/color_constant/color_constant.dart';

import '../../presentation/model/response/update_profile_response_model.dart';
import '../../repository/settings_repository.dart';

class EditProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController(
    text: '••••••••',
  );
  final Rx<DateTime?> dob = Rx<DateTime?>(null);
  RxString selectedDob = ''.obs;
  bool obscurePassword = true;
  RxString selectedGender = 'Male'.obs;
  String selectedCountry = 'IN';
  String role = '';
  final List<String> genderList = <String>['Male', 'Female', 'Other'];

  final RxString selectedPhoneCountryCode = '+91'.obs;
  final RxInt userAge = 0.obs;
  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> countries = ['India', 'USA', 'UK', 'Canada', 'Australia'];

  final SettingsRepository repository = SettingsRepository();
  RxBool isLoading = false.obs;
  RxBool isLoadingPreferences = false.obs;
  RxBool isLoadingSaveChanges = false.obs;
  RxList<String> selectedPreferredActivitiesList = <String>[].obs;

  final List<String> allGoals = [
    'Stress Relief',
    'Weight Management',
    'Better Sleep',
    'Mental Clarity',
    'Pain Relief',
    'Emotional Balance',
    'Detox & Cleanse',
    'Flexibility',
    'Energy Boost',
  ];

  RxList preferredActivitiesList = [
    'Yoga',
    'Meditation',
    'Ayurveda',
    'Panchakarma',
    'Physiotherapy',
    'Nutritional Coaching',
    'Trekking',
    'Sound Healing',
    'Art Therapy',
  ].obs;

  final List<String> selectedGoals = ['Weight Management', 'Detox & Cleanse'];
  @override
  void onInit() {
    super.onInit();
    getUserProfile();
  }

  void onTapUpdateProfile(BuildContext context) async {
    if (nameController.value.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter your name',
        context: context,
        isError: true,
      );
    } else if (emailController.value.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter your email',
        context: context,
        isError: true,
      );
    }
    // else if (phoneController.value.text.trim().isEmpty) {
    //   showToastMessage(
    //     titleMessage: 'Error',
    //     message: 'Please enter your phone number',
    //     context: context,
    //     isError: true,
    //   );
    // }
    else {
      Map<String, dynamic> data = {
        "name": nameController.value.text,
        "email": emailController.value.text,
        "phone": phoneController.value.text,
        "country": selectedCountry,
        "age": userAge.value,
        "dateOfBirth":selectedDob.value,
        "gender": selectedGender.value.toLowerCase(),
      };
      log('Data==>${data}');
      await updateProfile(context, data);
    }
    update();
  }


  void onTapChangePassword(BuildContext context){
    context.push(RouteConstant.changePassword);
  }

  void onTapUpdatePreferences(BuildContext context) async {
    if (selectedGoals.isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please select your wellness goals',
        context: context,
        isError: true,
      );
    } else if (selectedPreferredActivitiesList.isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please select your preferred activities',
        context: context,
        isError: true,
      );
    } else {
      Map<String, dynamic> data = {
        'wellnessGoals': selectedGoals.toList(),
        'preferredActivities': selectedPreferredActivitiesList.toList(),
      };
      updateProfile(context, data);
    }
    update();
  }

  Future<void> getUserProfile() async {
    isLoading.value = true;

    try {
      var response = await repository.userProfile();
      if (response.statusCode == 200) {
        UserProfileResponseModel responseModel =
            UserProfileResponseModel.fromJson(response.data);
        final user = responseModel.user;
        if (user != null) {
          nameController.text = user.name ?? '';
          ageController.text = user.age?.toString() ?? '';
          emailController.text = user.email ?? '';
          role = user.role?.toUpperCase() ?? '';
          selectedDob.value = user.dateOfBirth ??'';
          selectedGender.value = user.gender ??'';
          selectedCountry = user.country??'';


          if (user.phone != null ) {
            final phone = user.phone!;

            try {
              final country = CountryService().getAll().firstWhere(
                (c) => phone.startsWith('+${c.phoneCode}'),
              );

              selectedPhoneCountryCode.value = '+${country.phoneCode}';
              phoneController.text = phone.substring(
                country.phoneCode.length + 1,
              ); // +1 for '+'
            } catch (_) {
              selectedPhoneCountryCode.value = '+91';
              phoneController.text = phone;
            }
          }

          if (user.wellnessGoals != null) {
            selectedGoals.clear();
            selectedGoals.addAll(user.wellnessGoals!);
          }

          if (user.preferredActivities != null) {
            selectedPreferredActivitiesList.clear();
            selectedPreferredActivitiesList.addAll(user.preferredActivities!);
          }
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
      isLoading.value = false;
      update();
    }
  }

  Future<void> updateProfile(
    BuildContext context,
    Map<String, dynamic> data,
  ) async
  {
    isLoadingSaveChanges.value = true;
    try {
      var response = await repository.updateUserProfile(
        HiveStorageService.getUserId() ?? '0',
        data

      );
      if (response.statusCode == 200) {
        UpdateProfileResponseModel updateProfileResponseModel =
            UpdateProfileResponseModel.fromJson(response.data);
        if (context.mounted) {
          saveChanges(context);
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
      isLoadingSaveChanges.value = false;
    }
    update();
  }

  Future<void> selectDob(BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dob.value ?? today,
      firstDate: DateTime(1899),
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
      dob.value = picked;
      selectedDob.value = formatDate(picked);
      ageController.text = (today.year - picked.year).toString();
      userAge.value =  today.year - picked.year;
    }
    update();
  }

  void onTapSelectPreferredActivities(String item, BuildContext context) {
    if (selectedPreferredActivitiesList.length >= 5) {
      showToastMessage(
        titleMessage: 'Limit Reached',
        message: 'You can select up to 5 wellness goals only.',
        context: context,
        isError: true,
      );
      return;
    }
    if (selectedPreferredActivitiesList.contains(item)) {
      selectedPreferredActivitiesList.remove(item);
    } else {
      selectedPreferredActivitiesList.add(item);
    }
    update();
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update();
  }

  void updateGender(String value) {
    selectedGender.value = value;
    update();
  }

  void updateCountry(String value) {
    selectedCountry = value;
    update();
  }

  void toggleGoalSelection(String goal) {
    if (selectedGoals.contains(goal)) {
      selectedGoals.remove(goal);
    } else {
      selectedGoals.add(goal);
    }
    update();
  }

  void saveChanges(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 12),
            Text(
              'Changes saved successfully!',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF08864F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void updatePreferences(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 12),
            Text(
              'Preferences updated successfully!',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF08864F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void setCountryCode(bool isPhoneCode, Country country) {
    if (isPhoneCode) {
      selectedPhoneCountryCode.value = '+${country.phoneCode}';
    } else {
      selectedCountry = country.countryCode.substring(0, 2);
    }

    update();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
