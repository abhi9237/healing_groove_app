import 'dart:async';
import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:go_router/go_router.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/presentation/model/response/error_response_model.dart';
import 'package:healing/presentation/model/response/verify_otp_response.dart';
import 'package:dio/dio.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import '../presentation/model/response/send_otp_response_model.dart';
import '../repository/auth_repository.dart';
import 'account_progress_controller.dart';

class CreateAccountController extends GetxController {
  CreateAccountController({this.arguments});
  RxString selectedType = ''.obs;
  Map<String, dynamic>? arguments;
  final Rx<TextEditingController> fullNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;
  final Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final RxBool isAgreeCondition = false.obs;
  final RxBool isComingAuthSelection = false.obs;
  final AuthRepository _authRepository = AuthRepository();
  List<TextEditingController?> otpControllers = [];
  final RxString otpValue = ''.obs;
  Timer? _timer;
  int secondsRemaining = 60;
  bool timerStarted = false;
  RxBool isLoadingCreateAccount = false.obs;
  RxBool isLoadingVerifyOtp = false.obs;
  RxBool isLoadingLetsStart = false.obs;
  RxBool isShowPassword = true.obs;
  RxBool isShowConfirmPassword = true.obs;

  final Rx<DateTime?> selectedDob = Rx<DateTime?>(null);
  final RxInt userAge = 0.obs;
  final RxString selectedGender = ''.obs;
  final RxString selectedCountry = ''.obs;
  final RxString selectedPhoneCountryCode = '+91'.obs;
  final Rx<TextEditingController> phoneController = TextEditingController().obs;

  String get formattedDob {
    if (selectedDob.value == null) {
      return 'DD / MM / YYYY';
    }
    final String day = selectedDob.value!.day.toString().padLeft(2, '0');
    final String month = selectedDob.value!.month.toString().padLeft(2, '0');
    final String year = selectedDob.value!.year.toString();
    return '$day / $month / $year';
  }

  RxList<UserSelectionType> userSelectionList = <UserSelectionType>[
    UserSelectionType(
      title: 'Personal User',
      img: ImageConstant.userImg,
      subTitle: 'Start your healing journey',
      type: 'user',
    ),
    UserSelectionType(
      type: 'wellness_centre',
      subTitle: 'Grow your wellness business',
      img: ImageConstant.wellnessCentreImg,
      title: 'Wellness Centre',
    ),
    UserSelectionType(
      title: 'Doctor/Practitioner',
      img: ImageConstant.doctorImg,
      subTitle: 'Coming Soon',
      type: 'doctor',
    ),
  ].obs;

  RxList wellnessGoalsList = [
    'Stress Relief',
    'Weight Management',
    'Better Sleep',
    'Mental Clarity',
    'Pain Relief',
    'Emotional Balance',
    'Detox & Cleanse',
    'Flexibility',
    'Energy Boost',
  ].obs;

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

  RxList<String> selectedGoalsList = <String>[].obs;
  RxList<String> selectedPreferredActivitiesList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    authSelectionCheck();
  }

  void authSelectionCheck() {
    if (arguments != null && arguments!['isComingAuthSelection'] == true) {
      isComingAuthSelection.value = true;
    } else {
      isComingAuthSelection.value = false;
    }
  }

  String expirationText(int seconds) {
    if (!timerStarted) {
      return 'Code expires in 02:00';
    } else if (_timer == null && seconds == 0) {
      return 'Code expired';
    } else {
      return 'Code expires in ${formatTime(seconds)}';
    }
  }

  void startTimer() {
    _timer?.cancel();

    secondsRemaining = 60;
    timerStarted = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
      } else {
        _timer?.cancel();

        _timer = null;
      }
      update();
    });

    update();
  }

  void isShowPasswordToggle() {
    isShowPassword.value = !isShowPassword.value;
    update();
  }

  void isShowConfirmPasswordToggle() {
    isShowConfirmPassword.value = !isShowConfirmPassword.value;
    update();
  }

  void onTapSelectType(String type) {
    Get.find<AccountProgressController>().roleVerified.value = true;
    selectedType.value = type;
    isComingAuthSelection.value = true;
    update();
  }

  void onTapSelectWellNessGoals(String item, BuildContext context) {
    if (selectedGoalsList.length >= 5) {
      showToastMessage(
        titleMessage: 'Limit Reached',
        message: 'You can select up to 5 wellness goals only.',
        context: context,
        isError: true,
      );
      return;
    }

    if (selectedGoalsList.contains(item)) {
      selectedGoalsList.remove(item);
    } else {
      selectedGoalsList.add(item);
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

  void onTapAgreeTermsAndPrivacy() {
    isAgreeCondition.value = !isAgreeCondition.value;
    update();
  }

  void onTapContinue(String type, BuildContext context) {
    if (type == 'user') {
      selectedType.value == type;
      context.push(
        RouteConstant.createAccount,
        extra: {'isComingAuthSelection': true},
      );
    } else if (type == 'wellness_centre') {
      selectedType.value == type;
      context.push(RouteConstant.createAccount);
    } else {
      showToastMessage(
        titleMessage: 'Coming Soon',
        message: 'This feature is coming soon.',
        context: context,
        isError: false,
      );
    }
  }

  void onTapCreateAccount(BuildContext context) async {
    // context.push(RouteConstant.otpVerification);
    if (fullNameController.value.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter full name',
        context: context,
        isError: true,
      );
    } else if (emailController.value.text.trim().isEmpty ||
        !isValidEmail(emailController.value.text.trim())) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter valid email',
        context: context,
        isError: true,
      );
    } else if (passwordController.value.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter password',
        context: context,
        isError: true,
      );
    } else if (confirmPasswordController.value.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter confirm password',
        context: context,
        isError: true,
      );
    } else if (passwordController.value.text.trim().toLowerCase() !=
        confirmPasswordController.value.text.trim().toLowerCase()) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Password and Confirm Password do not match',
        context: context,
        isError: true,
      );
    } else if (isAgreeCondition.value == false) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please agree to the terms and privacy policy',
        context: context,
        isError: true,
      );
    } else {
      await sendOtp(context);
    }
  }

  Future<void> sendOtp(BuildContext context) async {
    try {
      isLoadingCreateAccount.value = true;
      Response response = await _authRepository.sendOtp(
        data: {
          'email': emailController.value.text.trim(),
          'name': fullNameController.value.text.trim(),
          'password': passwordController.value.text.trim(),
          'role': selectedType.value,
        },
      );
      if (response.statusCode == 200) {
        SendOtpResponse sendOtpResponse = SendOtpResponse.fromJson(
          response.data,
        );
        startTimer();
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Success',
            message: sendOtpResponse.message.toString(),
            context: context,
            isError: false,
          );
          context.push(RouteConstant.otpVerification);
        }
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: errorResponse.errors?.first.message ?? '',
            context: context,
            isError: true,
          );
        }
      }
    } catch (e) {
      log('Error sending OTP: $e');
      if (context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Failed to send OTP. Please try again.',
          context: context,
          isError: true,
        );
      }
    } finally {
      isLoadingCreateAccount.value = false;
    }
    update();
  }

  Future<void> reSendOtp(BuildContext context) async {
    try {
      isLoadingVerifyOtp.value = true;
      Response response = await _authRepository.reSendOtp(
        data: {'email': emailController.value.text.trim()},
      );
      if (response.statusCode == 200) {
        SendOtpResponse sendOtpResponse = SendOtpResponse.fromJson(
          response.data,
        );
        startTimer();
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Success',
            message: sendOtpResponse.message.toString(),
            context: context,
            isError: false,
          );
        }
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: errorResponse.errors?.first.message ?? '',
            context: context,
            isError: true,
          );
        }
      }
    } catch (e) {
      log('Error sending OTP: $e');
      if (context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Failed to send OTP. Please try again.',
          context: context,
          isError: true,
        );
      }
    } finally {
      isLoadingVerifyOtp.value = false;
    }
    update();
  }

  Future<void> verifyOtp(BuildContext context) async {
    try {
      isLoadingVerifyOtp.value = true;
      Response response = await _authRepository.verifyOtp(
        data: {
          'otp': otpValue.value,
          'email': emailController.value.text.trim(),
        },
      );
      if (response.statusCode == 200) {
        if (context.mounted) {
          VerifyOtpResponse verifyOtpResponse = VerifyOtpResponse.fromJson(
            response.data,
          );
          HiveStorageService.storeUserId(
            verifyOtpResponse.user?.id.toString() ?? '',
          );
          HiveStorageService.storeUserToken(verifyOtpResponse.token ?? '');
          HiveStorageService.storeTokenExpiry(verifyOtpResponse.exp ?? 0);
          HiveStorageService.storeUserName(verifyOtpResponse.user?.name ?? '');
          Get.find<AccountProgressController>().signUpVerified.value = true;
          context.push(RouteConstant.tellUsAboutYourself);
        }
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: errorResponse.errors?.first.message ?? '',
            context: context,
            isError: true,
          );
        }
      }
    } catch (e) {
      log('Error sending OTP: $e');
      if (context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Failed to verify OTP. Please try again.',
          context: context,
          isError: true,
        );
      }
    } finally {
      isLoadingVerifyOtp.value = false;
    }
    update();
  }

  Future<void> createAccount(BuildContext context) async {
    try {
      isLoadingLetsStart.value = true;
      Response response = await _authRepository.createAccount(
        data: {
          'name': fullNameController.value.text.trim(),
          'email': emailController.value.text.trim(),
          'phone':
              '$selectedPhoneCountryCode${phoneController.value.text.trim()}',
          'country': selectedCountry.value,
          'gender': selectedGender.value.toLowerCase(),
          'wellnessGoals': selectedGoalsList.toList(),
          'preferredActivities': selectedPreferredActivitiesList.toList(),
          'role': selectedType.value,
        },
        id: '${HiveStorageService.getUserId()}',
      );
      if (response.statusCode == 200) {
        Get.find<AccountProgressController>().preferenceVerified.value = true;
        HiveStorageService.storeUserType(selectedType.value);
        if (context.mounted) {
          context.go(RouteConstant.userDashboard);
        }
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: errorResponse.errors?.first.message ?? '',
            context: context,
            isError: true,
          );
        }
      }
    } catch (e) {
      log('Error sending OTP: $e');
      if (context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Failed to verify OTP. Please try again.',
          context: context,
          isError: true,
        );
      }
    } finally {
      isLoadingLetsStart.value = false;
    }
    update();
  }

  void onTapVerifyOtp(BuildContext context) {
    verifyOtp(context);
  }

  void onTapContinueAboutYourself(BuildContext context) {
    if (selectedDob.value == null) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please select your Date of Birth',
        context: context,
        isError: true,
      );
    } else if (selectedGender.value.isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please select your Gender',
        context: context,
        isError: true,
      );
    } else if (selectedCountry.value.isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please select your Country',
        context: context,
        isError: true,
      );
    } else {
      context.push(RouteConstant.selectPreference);
    }
  }

  void onTapAuthSelectionSignIn(BuildContext context) {
    context.go(RouteConstant.login);
  }

  void onTapLetsStart(BuildContext context) {
    // Get.find<AccountProgressController>().preferenceVerified.value = true;
    // update();
    // debugPrint(
    //   "Flow Completed: RoleSelection: ${Get.find<AccountProgressController>().roleVerified.value}, SignUp/Otp: ${Get.find<AccountProgressController>().signUpVerified.value}, Finish: ${Get.find<AccountProgressController>().preferenceVerified.value}",
    // );
    // context.go(RouteConstant.userDashboard);
    if (selectedGoalsList.isEmpty) {
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
      // var data = {
      //   'name': fullNameController.value.text.trim(),
      //   'email': emailController.value.text.trim(),
      //   'phone': '$selectedPhoneCountryCode${phoneController.value.text.trim()}',
      //   'country': selectedCountry.value,
      //   'age': userAge.value,
      //   'gender': selectedGender.value,
      //   'wellnessGoals': selectedGoalsList.join(','),
      //   'preferredActivities': selectedPreferredActivitiesList.join(','),
      //   'role': selectedType.value,
      // };
      // log('Data${data}');
      createAccount(context);
    }
    update();
  }

  Future<void> selectDob(
    BuildContext context,
    CreateAccountController controller,
  ) async {
    final DateTime today = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDob.value ?? today,
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
      controller.selectedDob.value = picked;
      userAge.value = today.year - picked.year;
    }
    update();
  }

  void setCountryCode(bool isPhoneCode, Country country) {
    if (isPhoneCode) {
      selectedPhoneCountryCode.value = '+${country.phoneCode}';
    } else {
      selectedCountry.value = country.countryCode;
    }

    update();
  }

  void showGenderBottomSheet(
    BuildContext context,
    CreateAccountController controller,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Obx(() {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, bottom: 20.0),
                  child: Text(
                    'Select Gender',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                ),
                ...['Male', 'Female', 'Other'].map((gender) {
                  final isSelected = controller.selectedGender.value == gender;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorConstant.appColor.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isSelected
                            ? ColorConstant.appColor
                            : Colors.grey.shade200,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 2,
                      ),
                      title: Text(
                        gender,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isSelected
                              ? ColorConstant.appColor
                              : ColorConstant.lightBlackColor,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(
                              Icons.check_circle_rounded,
                              color: ColorConstant.appColor,
                            )
                          : const Icon(
                              Icons.radio_button_unchecked_rounded,
                              color: Colors.grey,
                            ),
                      onTap: () {
                        controller.selectedGender.value = gender;
                        Navigator.pop(context);
                      },
                    ),
                  );
                }),
              ],
            ),
          );
        });
      },
    );
  }
}

class UserSelectionType {
  String title;
  String subTitle;
  String img;
  String type;
  UserSelectionType({
    required this.type,
    required this.title,
    required this.subTitle,
    required this.img,
  });
}
