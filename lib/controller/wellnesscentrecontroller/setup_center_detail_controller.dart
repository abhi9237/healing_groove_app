import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/controller/usercontroller/create_account_controller.dart';
import 'package:healing/controller/usercontroller/login_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/repository/set_up_center_detail_repository.dart';
import 'package:healing/presentation/model/response/upload_image_response_model.dart';
import 'package:healing/presentation/model/response/centre_response_model.dart';
import 'package:healing/core/storage/hive_storage_service.dart';

class SetupCenterDetailController extends GetxController {
  final SetUpCenterDetailRepository _repository = SetUpCenterDetailRepository();
   CentreResponseModel? createdCentreResponse = CentreResponseModel();

  // --- Step 1 Keys & Controllers ---
  final formKeyStep1 = GlobalKey<FormState>();
  final centerNameController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final RxString selectedCountry = ''.obs;
  final RxString phoneCountryCode = '+91'.obs;

  // --- Step 2 Keys & Controllers ---
  final formKeyStep2 = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final coreSpecialityController = TextEditingController();
  final capacityController = TextEditingController();
  final roomsController = TextEditingController();
  final servicesController = TextEditingController();
  final facilitiesController = TextEditingController();

  // --- Step 3 State ---
  final Rxn<File> featuredImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();

  final RxBool isLoading = false.obs;
  final RxBool isLoadingImages = false.obs;

  SetupCenterDetailController({this.createdCentreResponse});

  @override
  void onClose() {
    // Step 1 Controllers
    centerNameController.dispose();
    countryController.dispose();
    cityController.dispose();
    phoneController.dispose();
    emailController.dispose();

    // Step 2 Controllers
    descriptionController.dispose();
    coreSpecialityController.dispose();
    capacityController.dispose();
    roomsController.dispose();
    servicesController.dispose();
    facilitiesController.dispose();

    super.onClose();
  }

  @override
  void onInit() {
    setData();
    super.onInit();
  }

  void setData() {
    if (Get.isRegistered<CreateAccountController>()) {
      emailController.text =
          Get.find<CreateAccountController>().emailController.value.text;
    }
    if (Get.isRegistered<LoginController>()) {
      emailController.text =
          Get.find<LoginController>().emailController.value.text;
    }
    update();
  }

  // --- Step 1 Logic ---
  void onStep1Continue(BuildContext context) {
    if (formKeyStep1.currentState?.validate() ?? false) {
      context.push(RouteConstant.centreDetail);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the errors in the form'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // --- Step 2 Logic ---
  void onStep2Continue(BuildContext context) {
    if (formKeyStep2.currentState?.validate() ?? false) {
      context.push(RouteConstant.makeItShine);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the errors in the form'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // --- Step 3 Image Picking Logic ---
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        featuredImage.value = File(pickedFile.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void removeImage() {
    featuredImage.value = null;
  }

  void showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0, bottom: 20.0),
                child: Text(
                  'Select Image Source',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.photo_library_rounded,
                    color: ColorConstant.appColor,
                  ),
                  title: const Text(
                    'Choose from Gallery',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage(ImageSource.gallery);
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.camera_alt_rounded,
                    color: ColorConstant.appColor,
                  ),
                  title: const Text(
                    'Take a Photo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage(ImageSource.camera);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Step 3 Logic ---
  Future<void> uploadImages(BuildContext context) async {
    if (featuredImage.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a featured image before submitting.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    isLoading.value = true;
    try {
      // 1. Upload Featured Image
      final uploadResponse = await _repository.uploadImage(
        imageFile: featuredImage.value!,
        centerName: centerNameController.text,
      );

      if (uploadResponse.statusCode == 200 || uploadResponse.statusCode == 201) {
        int? imageId;
        if (uploadResponse.data != null) {
          final parsedUpload = UploadImageModelResponse.fromJson(uploadResponse.data as Map<String, dynamic>);
          imageId = parsedUpload.doc?.id;
          debugPrint('Successfully uploaded image with ID: $imageId');
        }

        // 2. Prepare dynamic phone number prefixing
        String phoneVal = phoneController.text.trim();
        if (phoneCountryCode.value.isNotEmpty && !phoneVal.startsWith('+')) {
          phoneVal = phoneCountryCode.value + phoneVal;
        }

        // 3. Prepare list inputs from comma-separated texts
        final servicesList = servicesController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
        final facilitiesList = facilitiesController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();

        // 4. Construct payload for center creation
        final payload = {
          "name": centerNameController.text.trim(),
          "phone": phoneVal,
          "email": emailController.text.trim(),
          "admin": int.tryParse(HiveStorageService.getUserId() ?? '') ?? 0,
          "image": imageId,
          "location": {
            "city": cityController.text.trim(),
            "country": selectedCountry.value.isNotEmpty ? selectedCountry.value : countryController.text.trim(),
          },
          "description": descriptionController.text.trim(),
          "speciality": coreSpecialityController.text.trim(),
          "capacity": int.tryParse(capacityController.text.trim()) ?? 0,
          "numberOfRooms": int.tryParse(roomsController.text.trim()) ?? 0,
          "servicesOffered": servicesList,
          "facilities": facilitiesList,
          "approvalStatus": "pending"
        };

        // 5. Invoke createCentre API
        final createResponse = await _repository.createCentre(data: payload);
        if (createResponse.statusCode == 200 || createResponse.statusCode == 201) {
          if (createResponse.data != null) {
            final parsedCentre = CentreResponseModel.fromJson(createResponse.data as Map<String, dynamic>);
            createdCentreResponse = parsedCentre;
          }
          update(); // Update GetBuilder observers
          isLoading.value = false;
          if (context.mounted) {
            context.push(RouteConstant.centreUnderReview);
          }
        } else {
          throw Exception('Failed to create centre. Status: ${createResponse.statusCode}');
        }
      } else {
        throw Exception('Upload failed with status code ${uploadResponse.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint('Error in submit flow: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }

    update();
  }
}
