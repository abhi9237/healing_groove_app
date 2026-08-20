import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/response/program_response_model.dart';
import 'package:healing/repository/program_and_packages_repository.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/common/common_methods.dart';

import 'add_new_program_controller.dart';

class ProgramAndPackagesController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final ProgramAndPackagesRepository _repository = ProgramAndPackagesRepository();

  bool isLoading = false;
  List<DocModel> allPrograms = [];
  List<DocModel> filteredPrograms = [];
  ProgramStatus selectedStatus = ProgramStatus(status: 'all', text: 'All Availability States');
  int? deletingProgramId;

  final List<ProgramStatus> availabilityStatus = [
    ProgramStatus(status: 'all', text: 'All Availability States'),
    ProgramStatus(status: 'draft', text: 'Draft (only visible to you)'),
    ProgramStatus(
      status: 'pending_approval',
      text: 'Pending Approval (visible to you and admin)',
    ),
    ProgramStatus(status: 'live', text: 'Live (visible to everyone)'),
    ProgramStatus(status: 'rejected', text: 'Rejected '),
  ];

  // Dynamic summary metrics getter
  List<Map<String, dynamic>> get summaryMetrics {
    final total = allPrograms.length;
    final active = allPrograms.where((p) => p.approvalStatus == 'live' || (p.isActive ?? false)).length;
    final underReview = allPrograms.where((p) => p.approvalStatus == 'pending_approval' || p.approvalStatus == 'pending').length;

    return [
      {
        'label': 'TOTAL PROGRAMS',
        'count': total,
        'icon': Icons.inventory_2_outlined,
      },
      {
        'label': 'ACTIVE NOW',
        'count': active,
        'icon': Icons.check_circle_outline_rounded,
      },
      {
        'label': 'UNDER REVIEW',
        'count': underReview,
        'icon': Icons.watch_later_outlined,
      },
    ];
  }

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_onSearchChanged);
    fetchPrograms();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchPrograms() async {
    isLoading = true;
    update();

    try {
      final centerId = HiveStorageService.getCenterId() ?? 0;
      final response = await _repository.getPrograms(centerId: centerId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final programsResponse = ProgramsResponseModel.fromJson(response.data as Map<String, dynamic>);
        allPrograms = programsResponse.docs ?? [];
        filterData();
      }
    } catch (e) {
      debugPrint('Error fetching programs: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void _onSearchChanged() {
    filterData();
  }

  void onStateChanged(ProgramStatus? status) {
    if (status != null) {
      selectedStatus = status;
      filterData();
    }
  }

  void filterData() {
    final query = searchController.text.toLowerCase();
    
    filteredPrograms = allPrograms.where((prog) {
      final name = (prog.name ?? prog.title ?? '').toLowerCase();
      final desc = (prog.description ?? '').toLowerCase();
      final matchesQuery = name.contains(query) || desc.contains(query);

      final approvalStatus = (prog.approvalStatus ?? '').toLowerCase();
      
      bool matchesState = false;
      if (selectedStatus.status == 'all') {
        matchesState = true;
      } else if (selectedStatus.status == 'pending_approval') {
        matchesState = approvalStatus == 'pending_approval' || approvalStatus == 'pending';
      } else if (selectedStatus.status == 'draft') {
        matchesState = approvalStatus == 'draft';
      } else if (selectedStatus.status == 'live') {
        matchesState = approvalStatus == 'live';
      } else if (selectedStatus.status == 'rejected') {
        matchesState = approvalStatus == 'rejected';
      }

      return matchesQuery && matchesState;
    }).toList();
    
    update();
  }

  Future<void> refreshPrograms() async {
    await fetchPrograms();
  }

  void createNewProgram(BuildContext context) {
    context.push(RouteConstant.addNewProgram).then((_) {
      fetchPrograms();
    });
  }

  void previewProgram(BuildContext context, DocModel program) {
    context.push(RouteConstant.programPreviewDetail, extra: program);
  }

  void editProgram(BuildContext context, DocModel program) {
    context.push(RouteConstant.addNewProgram, extra: program).then((_) {
      fetchPrograms();
    });
  }

  Future<void> deleteProgram(BuildContext context, int programId) async {
    deletingProgramId = programId;
    update();

    try {
      final response = await _repository.deleteProgram(programId);
      if (response.statusCode == 200 || response.statusCode == 204) {
        allPrograms.removeWhere((prog) => prog.id == programId);
        filterData();

        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Success',
            message: 'Program deleted successfully.',
            context: context,
            isError: false,
          );
        }
      } else {
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: 'Failed to delete program.',
            context: context,
            isError: true,
          );
        }
      }
    } catch (e) {
      debugPrint('Error deleting program: $e');
      if (context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'An error occurred while deleting the program.',
          context: context,
          isError: true,
        );
      }
    } finally {
      deletingProgramId = null;
      update();
    }
  }
}
