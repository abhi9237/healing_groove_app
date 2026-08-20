import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../presentation/model/common/doc_model.dart';
import '../../presentation/model/common/centre_model.dart';
import '../../presentation/model/common/packages_model.dart';
import '../../presentation/model/response/program_response_model.dart';
import '../../presentation/model/response/center_response_model.dart';
import '../../repository/explore_retreats_repository.dart';

class ExploreAllController extends GetxController {
  final ExploreRetreatsRepository exploreRetreatsRepository =
      ExploreRetreatsRepository();
  final ScrollController scrollController = ScrollController();

  // Search state
  String selectedReason = '';
  String selectedDestination = '';
  String selectedWhen = 'Select Dates';

  DateTime? selectedSingleDate;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  bool selectedDateIsRange = false;

  // Filters state (reactive for Obx binding)
  RxBool isVerifiedOnly = true.obs;
  RxBool isAvailableNow = false.obs;
  RxList<String> selectedServices = <String>[].obs;

  // Search Results visible toggle
  bool showSearchResults = false;

  // Packages list from API
  RxList<DocModel> packagesList = <DocModel>[].obs;
  RxBool isPackagesLoading = false.obs;

  // Search Results pagination state
  RxList<PackagesModel> searchedPackageList = <PackagesModel>[].obs;
  RxBool isSearching = false.obs;
  RxBool isLoadMore = false.obs;
  int currentPage = 1;
  bool hasMore = true;
  static const int _limit = 100;

  @override
  void onInit() {
    super.onInit();
    fetchPackages();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (showSearchResults &&
          !isSearching.value &&
          !isLoadMore.value &&
          hasMore) {
        searchCentersApi();
      }
    }
  }

  List<String> get uniqueServiceNames {
    final Set<String> names = {};
    for (var pkg in searchedPackageList) {
      if (pkg.services != null) {
        for (var service in pkg.services!) {
          if (service.name != null && service.name!.trim().isNotEmpty) {
            names.add(service.name!.trim());
          }
        }
      }
    }
    return names.toList();
  }

  List<CentreModel> get uniqueCentres {
    final Set<String> seenNames = {};
    final List<CentreModel> uniqueList = [];
    for (var pkg in searchedPackageList) {
      if (pkg.center != null) {
        final centerName = pkg.center!.name?.trim() ?? '';
        if (centerName.isNotEmpty && !seenNames.contains(centerName)) {
          seenNames.add(centerName);
          uniqueList.add(pkg.center!);
        }
      }
    }
    return uniqueList;
  }

  List<CentreModel> get filteredCenters {
    return uniqueCentres.where((center) {
      // 1. Verified Only filter (local)
      if (isVerifiedOnly.value) {
        final isVerified =
            center.approvalStatus?.toLowerCase() == 'live' ||
            center.approvalStatus?.toLowerCase() == 'approved';
        if (!isVerified) {
          return false;
        }
      }

      // 2. Available Now filter (local)
      if (isAvailableNow.value) {
        final isAvailable =
            center.availability != null &&
            center.availability.toString().toLowerCase().contains('available');
        if (!isAvailable) {
          return false;
        }
      }

      // 3. Selected services filter (local)
      if (selectedServices.isNotEmpty) {
        final List<String> centerServiceNames = [];
        for (var pkg in searchedPackageList) {
          if (pkg.center?.id == center.id || pkg.center?.name == center.name) {
            if (pkg.services != null) {
              for (var s in pkg.services!) {
                if (s.name != null) {
                  centerServiceNames.add(s.name!.trim());
                }
              }
            }
          }
        }

        for (var service in selectedServices) {
          if (!centerServiceNames.contains(service)) {
            return false;
          }
        }
      }

      return true;
    }).toList();
  }

  Future<void> fetchPackages() async {
    isPackagesLoading.value = true;
    update();
    try {
      final response = await exploreRetreatsRepository.getCentrePackages();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final programsResponse = ProgramsResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        packagesList.value = programsResponse.docs ?? [];
      } else {
        log(
          'ExploreAllController: Error fetching packages, status: ${response.statusCode}',
        );
      }
    } catch (e) {
      log('ExploreAllController: Error fetching packages: $e');
    } finally {
      isPackagesLoading.value = false;
      update();
    }
  }

  Future<void> searchCentersApi({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      searchedPackageList.clear();
    }

    if (isSearching.value || isLoadMore.value || !hasMore) return;

    if (currentPage == 1) {
      isSearching.value = true;
    } else {
      isLoadMore.value = true;
    }
    update();

    try {
      String? startDateStr;
      String? endDateStr;
      if (selectedDateIsRange) {
        if (selectedStartDate != null)
          startDateStr = selectedStartDate!.toIso8601String();
        if (selectedEndDate != null)
          endDateStr = selectedEndDate!.toIso8601String();
      } else {
        if (selectedSingleDate != null)
          startDateStr = selectedSingleDate!.toIso8601String();
      }

      String qVal =
          (selectedReason == 'e.g. Panchakarma, Yoga, Stress Relief...')
          ? ''
          : selectedReason;
      String destVal = (selectedDestination == 'Search city or region...')
          ? ''
          : selectedDestination;

      final response = await exploreRetreatsRepository.searchCenters(
        q: qVal,
        destination: destVal,
        startDate: startDateStr,
        endDate: endDateStr,
        page: currentPage,
        limit: _limit,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        CenterResponseModel centerResponseModel = CenterResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        List<PackagesModel> packageDocs = centerResponseModel.packages ?? [];

        packageDocs = packageDocs
            .where((doc) => doc.approvalStatus?.toLowerCase() != 'rejected')
            .toList();

        if (packageDocs.isNotEmpty) {
          if (currentPage == 1) {
            searchedPackageList.value = packageDocs;
          } else {
            searchedPackageList.addAll(packageDocs);
          }
          currentPage++;
        }
        hasMore = centerResponseModel.hasNextPage ?? false;
      } else {
        log(
          'ExploreAllController: Error search API, status: ${response.statusCode}',
        );
      }
    } catch (e) {
      log('ExploreAllController: Error search API: $e');
    } finally {
      isSearching.value = false;
      isLoadMore.value = false;
      update();
    }
  }

  void triggerSearch() {
    showSearchResults = true;
    searchCentersApi(isRefresh: true);
  }

  void toggleVerifiedOnly() {
    isVerifiedOnly.value = !isVerifiedOnly.value;
    update();
  }

  void toggleAvailableNow() {
    isAvailableNow.value = !isAvailableNow.value;
    update();
  }

  void toggleServiceFilter(String serviceName) {
    if (selectedServices.contains(serviceName)) {
      selectedServices.remove(serviceName);
    } else {
      selectedServices.add(serviceName);
    }
    update();
  }

  void resetFilters() {
    isVerifiedOnly.value = false;
    isAvailableNow.value = false;
    selectedServices.clear();
    update();
  }

  void updateReason(String reason) {
    selectedReason = reason;
    update();
  }

  void updateDestination(String destination) {
    selectedDestination = destination;
    update();
  }

  void updateWhen(String whenStr) {
    selectedWhen = whenStr;
    update();
  }

  void updateDates(
    DateTime? singleDate,
    DateTime? startDate,
    DateTime? endDate,
    bool isRange,
  ) {
    selectedSingleDate = singleDate;
    selectedStartDate = startDate;
    selectedEndDate = endDate;
    selectedDateIsRange = isRange;

    if (isRange) {
      if (startDate != null && endDate != null) {
        final startStr = DateFormat('dd MMM').format(startDate);
        final endStr = DateFormat('dd MMM yyyy').format(endDate);
        selectedWhen = '$startStr - $endStr';
      } else if (startDate != null) {
        selectedWhen = DateFormat('dd MMM yyyy').format(startDate);
      } else {
        selectedWhen = 'Select Dates';
      }
    } else {
      if (singleDate != null) {
        selectedWhen = DateFormat('dd MMM yyyy').format(singleDate);
      } else {
        selectedWhen = 'Select Dates';
      }
    }
    update();
  }
}
