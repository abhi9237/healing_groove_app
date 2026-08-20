import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/common/image_model.dart';
import 'package:healing/presentation/model/response/upload_image_response_model.dart';
import 'package:healing/repository/wellness_settings_repository.dart';
import 'package:healing/repository/settings_repository.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class WellnessSettingsController extends GetxController {
  final RxBool isLoggingOut = false.obs;

  Future<void> logOut(BuildContext context) async {
    isLoggingOut.value = true;
    update();

    final settingsRepo = SettingsRepository();
    try {
      var response = await settingsRepo.logout();
      if (response.statusCode == 200) {
        HiveStorageService.eraseAllData();
        HiveStorageService.storeRememberMe(false);
        if (context.mounted) {
          context.go(RouteConstant.authSelection);
        }
      }
    } catch (e) {
      // Safe fallback
      HiveStorageService.eraseAllData();
      HiveStorageService.storeRememberMe(false);
      if (context.mounted) {
        context.go(RouteConstant.authSelection);
      }
    } finally {
      isLoggingOut.value = false;
      update();
    }
  }

  final WellnessSettingsRepository _repository = WellnessSettingsRepository();

  // Public Listing Details
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController startingPriceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController availabilityController = TextEditingController();

  // Core Identity
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController specialityController = TextEditingController();
  final TextEditingController staffController = TextEditingController();

  // Contact Information
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Location
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  // Media
  String? featuredImageUrl;
  File? newFeaturedImageFile;

  List<ImageModel> galleryImages = [];
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;
  bool isSaving = false;
  DocModel? centerData;

  @override
  void onInit() {
    super.onInit();
    fetchCenterDetails();
  }

  @override
  void onClose() {
    ratingController.dispose();
    startingPriceController.dispose();
    durationController.dispose();
    availabilityController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    specialityController.dispose();
    staffController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    postalCodeController.dispose();
    super.onClose();
  }

  Future<void> fetchCenterDetails() async {
    isLoading = true;
    update();
    try {
      final centerId = HiveStorageService.getCenterId() ?? 0;
      final response = await _repository.getCenterDetails(centerId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          final map = response.data as Map<String, dynamic>;
          if (map.containsKey('doc')) {
            centerData = DocModel.fromJson(map['doc'] as Map<String, dynamic>);
          } else {
            centerData = DocModel.fromJson(map);
          }

          // Populate Text Controllers
          ratingController.text = centerData?.rating?.toString() ?? '';
          startingPriceController.text = centerData?.minPrice?.toString() ?? '';
          durationController.text = centerData?.durationText ?? '';
          availabilityController.text = centerData?.availability?.toString() ?? '';

          nameController.text = centerData?.name ?? '';
          descriptionController.text = centerData?.description ?? '';
          specialityController.text = centerData?.speciality ?? '';
          staffController.text = centerData?.capacity?.toString() ?? '';

          phoneController.text = centerData?.phone ?? '';
          emailController.text = centerData?.email ?? '';

          addressController.text = centerData?.location?.address ?? '';
          cityController.text = centerData?.location?.city ?? '';
          stateController.text = centerData?.location?.state ?? '';
          countryController.text = centerData?.location?.country ?? '';
          postalCodeController.text = centerData?.location?.postalCode ?? '';

          // Featured Image
          if (centerData?.image != null) {
            featuredImageUrl = centerData!.image!.url ??'';
          }

          // Gallery
          if (centerData?.gallery is List) {
            galleryImages = [];
            for (var item in (centerData!.gallery as List)) {
              if (item is ImageModel) {
                galleryImages.add(item);
              } else if (item is Map<String, dynamic>) {
                galleryImages.add(ImageModel.fromJson(item));
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching center details: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  // Pick Featured Image
  Future<void> pickFeaturedImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        newFeaturedImageFile = File(pickedFile.path);
        featuredImageUrl = null; // Clear old URL so file renders
        update();
      }
    } catch (e) {
      debugPrint('Error picking featured image: $e');
    }
  }

  // Pick and Upload Gallery Image
  Future<void> addGalleryImage(ImageSource source, BuildContext context) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        isLoading = true;
        update();
        final file = File(pickedFile.path);
        final uploadResp = await _repository.uploadImage(
          imageFile: file,
          centerName: nameController.text.trim(),
        );

        if (uploadResp.statusCode == 200 || uploadResp.statusCode == 201) {
          final parsed = UploadImageModelResponse.fromJson(uploadResp.data as Map<String, dynamic>);
          if (parsed.doc != null) {
            galleryImages.add(parsed.doc?.image ?? ImageModel());
            debugPrint('Gallery image added successfully: ${parsed.doc?.id}');
          }
        } else {
          showToastMessage(
            titleMessage: 'Error',
            message: 'Failed to upload gallery image.',
            context: context,
            isError: true,
          );
        }
      }
    } catch (e) {
      debugPrint('Error adding gallery image: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  // Save/Update Settings
  Future<void> saveSettings(BuildContext context) async {
    isSaving = true;
    update();
    try {
      final centerId = HiveStorageService.getCenterId() ?? 0;

      // 1. Upload Featured Image if new one selected
      int? imageId = centerData?.image?.id;
      if (newFeaturedImageFile != null) {
        final uploadResp = await _repository.uploadImage(
          imageFile: newFeaturedImageFile!,
          centerName: nameController.text.trim(),
        );
        if (uploadResp.statusCode == 200 || uploadResp.statusCode == 201) {
          final parsed = UploadImageModelResponse.fromJson(uploadResp.data as Map<String, dynamic>);
          imageId = parsed.doc?.id;
        }
      }

      // 2. Map Gallery list IDs
      final galleryPayload = galleryImages.map((img) => img.id).whereType<int>().toList();

      final payload = {
        "name": nameController.text.trim(),
        "description": descriptionController.text.trim(),
        "phone": phoneController.text.trim(),
        "email": emailController.text.trim(),
        "rating": double.tryParse(ratingController.text.trim()),
        "minPrice": int.tryParse(startingPriceController.text.trim()),
        "durationText": durationController.text.trim(),
        "availability": availabilityController.text.trim(),
        "speciality": specialityController.text.trim(),
        "capacity": int.tryParse(staffController.text.trim()),
        "image": imageId,
        "gallery": galleryPayload,
        "location": {
          "address": addressController.text.trim(),
          "city": cityController.text.trim(),
          "state": stateController.text.trim(),
          "country": countryController.text.trim(),
          "postalCode": postalCodeController.text.trim(),
        }
      };

      final response = await _repository.updateCenterDetails(centerId, payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        showToastMessage(
          titleMessage: 'Success',
          message: 'Settings updated successfully!',
          context: context,
          isError: false,
        );
        newFeaturedImageFile = null;
        fetchCenterDetails();
      } else {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Failed to update settings.',
          context: context,
          isError: true,
        );
      }
    } catch (e) {
      debugPrint('Error updating settings: $e');
      showToastMessage(
        titleMessage: 'Error',
        message: 'An error occurred while updating settings.',
        context: context,
        isError: true,
      );
    } finally {
      isSaving = false;
      update();
    }
  }

  void showImageSourceOptions(BuildContext context, {required bool isFeatured}) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select Image Source',
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(ctx);
                          if (isFeatured) {
                            pickFeaturedImage(ImageSource.gallery);
                          } else {
                            addGalleryImage(ImageSource.gallery, context);
                          }
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: ColorConstant.appColor.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: ColorConstant.appColor.withValues(alpha: 0.15),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: ColorConstant.appColor.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.photo_library_rounded,
                                  color: ColorConstant.appColor,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Gallery',
                                style: TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstant.lightBlackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(ctx);
                          if (isFeatured) {
                            pickFeaturedImage(ImageSource.camera);
                          } else {
                            addGalleryImage(ImageSource.camera, context);
                          }
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: ColorConstant.appColor.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: ColorConstant.appColor.withValues(alpha: 0.15),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: ColorConstant.appColor.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: ColorConstant.appColor,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Camera',
                                style: TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstant.lightBlackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
