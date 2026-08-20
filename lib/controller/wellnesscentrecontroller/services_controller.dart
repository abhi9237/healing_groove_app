import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import '../../../core/route/route_constant/route_constant.dart';
import 'package:healing/repository/services_repository.dart';
import 'package:healing/presentation/model/response/services_response_model.dart';
import 'package:healing/presentation/model/response/service_created_response_model.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/presentation/model/common/doc_model.dart';

class ServicesController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final ServicesRepository _servicesRepository = ServicesRepository();

  bool isActive = true;
  bool isLoading = false;
  int? editingServiceId;
  RxBool isLoadingService = false.obs;

  List<DocModel> allServices = [];
  var filteredServices = <DocModel>[];
  String selectedServiceFilter = 'all';

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void toggleActive(bool val) {
    isActive = val;
    update();
  }

  Future<void> submitService(BuildContext context) async {
    if (nameController.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter service name',
        context: context,
        isError: true,
      );
      return;
    }

    if (priceController.text.trim().isEmpty) {
      priceController.text = '0';
    }

    isLoadingService.value = true;
    update();

    try {
      final centerId = HiveStorageService.getCenterId() ?? 0;
      final payload = {
        "center": centerId,
        "name": nameController.text.trim(),
        "description": descriptionController.text.trim(),
        "basePrice": int.tryParse(priceController.text.trim()) ?? 0,
        "isActive": isActive,
      };

      final response;

      if (editingServiceId != null) {
        response = await _servicesRepository.updateCentreService(
          editingServiceId!,
          payload,
        );
      } else {
        response = await _servicesRepository.createCentreService(payload);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final createResponse = ServiceCreatedResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        if (createResponse.doc != null) {
          final doc = createResponse.doc!;

          if (editingServiceId != null) {
            final index = allServices.indexWhere(
              (s) => s.id == editingServiceId,
            );
            if (index != -1) {
              allServices[index] = doc;
            }
          } else {
            allServices.insert(0, doc); // Prepend so it shows up first
          }
          _onSearchChanged();

          // Clear form state
          nameController.clear();
          descriptionController.clear();
          // priceController.text = '0';
          isActive = true;
          editingServiceId = null;

          if (context.mounted) {
            Navigator.of(context).pop();
          }
        }
      }
    } catch (e) {
      debugPrint('Error saving service: $e');
      if (context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Failed to save service.',
          context: context,
          isError: true,
        );
      }
    } finally {
      isLoadingService.value = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_onSearchChanged);
    fetchServices();
  }

  Future<void> fetchServices() async {
    isLoading = true;
    update();
    try {
      final centerId = HiveStorageService.getCenterId() ?? 0;
      final response = await _servicesRepository.getServices(
        centerId: centerId,
        limit: 100, // Matching prompt instructions for pagination
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final servicesResponse = ServicesResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        if (servicesResponse.docs != null) {
          allServices = servicesResponse.docs ?? [];
        }
      }
    } catch (e) {
      debugPrint('Error fetching services: $e');
    } finally {
      isLoading = false;
      _onSearchChanged(); // Re-apply any existing search filters
      update();
    }
  }

  void onFilterChanged(String? filter) {
    if (filter != null) {
      selectedServiceFilter = filter;
      _onSearchChanged();
    }
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    
    filteredServices = allServices.where((svc) {
      final name = (svc.name ?? '').toLowerCase();
      final desc = (svc.description ?? '').toLowerCase();
      final category = (svc.speciality ?? 'GENERAL').toLowerCase();
      final matchesQuery = query.isEmpty ||
          name.contains(query) ||
          desc.contains(query) ||
          category.contains(query);

      bool matchesFilter = true;
      if (selectedServiceFilter == 'active') {
        matchesFilter = svc.isActive == true;
      } else if (selectedServiceFilter == 'inactive') {
        matchesFilter = svc.isActive == false;
      }

      return matchesQuery && matchesFilter;
    }).toList();

    update();
  }

  Future<void> refreshServices() async {
    await fetchServices();
  }

  void addServices(BuildContext context) {
    editingServiceId = null;
    nameController.clear();
    descriptionController.clear();
    priceController.text = '';
    isActive = true;
    context.push(RouteConstant.addService);
  }

  void editService(BuildContext context, DocModel service) {
    editingServiceId = service.id;
    nameController.text = service.name ?? '';
    descriptionController.text = service.description ?? '';
    priceController.text = '${service.basePrice ?? 0}';
    isActive = service.isActive ?? false;

    context.push(RouteConstant.addService);
  }

  void deleteService(BuildContext context, DocModel service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bc) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Wrap(
            children: [
              Center(
                child: Text(
                  'Are you sure you want to delete ${service.name}?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.blackColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.greyColor,
                      ),
                      onPressed: () {
                        Navigator.of(bc).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text(
                          'No',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.appColor,
                      ),
                      onPressed: () {
                        Navigator.of(bc).pop();
                        _performDelete(service.id,context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performDelete(int? id, BuildContext context) async {
    if (id == null) return;
    isLoading = true;
    update();
    try {
      final response = await _servicesRepository.deleteCentreService(id);
      if (response.statusCode == 200 || response.statusCode == 201) {
        allServices.removeWhere((s) => s.id == id);
        _onSearchChanged();
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Success',
            message: 'Service deleted successfully.',
            context: context,
            isError: false,
          );
        }
      }
    } catch (e) {
      debugPrint('Error deleting service: $e');

      if (context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Failed to delete service.',
          context: context,
          isError: false,
        );
      }

    } finally {
      isLoading = false;
      update();
    }
  }
}
