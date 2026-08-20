import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/repository/support_repository.dart';
import 'package:healing/repository/booking_management_repo.dart';
import 'package:healing/presentation/model/response/create_support_response_model.dart';
import 'package:healing/presentation/model/response/support_response_model.dart';
import 'package:healing/presentation/model/common/doc_model.dart';

class SupportController extends GetxController {
  final SupportRepository _supportRepository = SupportRepository();
  final BookingManagementRepository _bookingRepository = BookingManagementRepository();

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  int bookingsCount = 0;
  int enquiriesCount = 0;
  String centerName = '';

  bool isLoading = false;
  bool isSubmitting = false;
  List<DocModel> ticketsList = [];

  @override
  void onInit() {
    super.onInit();
    centerName = HiveStorageService.getUserName() ?? 'Wellness Center';
    final email = HiveStorageService.getUserEmail() ?? '';
    fetchBookingsCount();
    if (email.isNotEmpty) {
      fetchSupportTickets(email);
    }
  }

  @override
  void onClose() {
    subjectController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }

  Future<void> fetchBookingsCount() async {
    try {
      final response = await _bookingRepository.getCentreBookings(page: 1, limit: 1);
      if (response.statusCode == 200 && response.data != null) {
        if (response.data['totalDocs'] != null) {
          bookingsCount = response.data['totalDocs'] as int;
        } else if (response.data['docs'] is List) {
          bookingsCount = (response.data['docs'] as List).length;
        }
      }
    } catch (e) {
      debugPrint('Error fetching bookings count: $e');
    } finally {
      update();
    }
  }

  Future<void> fetchSupportTickets(String email) async {
    isLoading = true;
    update();

    try {
      final response = await _supportRepository.getSupportTickets(email: email);
      if (response.statusCode == 200 && response.data != null) {
        final supportResponse = SupportResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        ticketsList = supportResponse.docs ?? [];

        // Count pending enquiries/tickets
        enquiriesCount = ticketsList.where((t) {
          final status = (t.status ?? '').toLowerCase();
          return status == 'pending' || status == 'open';
        }).length;
      }
    } catch (e) {
      debugPrint('Error fetching support tickets: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> submitRequest(BuildContext context) async {
    if (subjectController.text.trim().isEmpty ||
        messageController.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please fill in the subject and message fields.',
        context: context,
        isError: true,
      );
      return;
    }

    isSubmitting = true;
    update();

    final name = HiveStorageService.getUserName() ?? 'Wellness Center';
    final email = HiveStorageService.getUserEmail() ?? '';
    final phone = phoneController.text.trim();
    final subject = subjectController.text.trim();
    final message = messageController.text.trim();

    final Map<String, dynamic> payload = {
      "name": name,
      "email": email,
      "phone": phone.isNotEmpty ? phone : "",
      "subject": subject,
      "message": message,
      "sourceType": "center",
    };

    try {
      final response = await _supportRepository.createSupportTicket(payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseModel = CreatedSupportResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );

        subjectController.clear();
        phoneController.clear();
        messageController.clear();

        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Success',
            message:
                responseModel.message ??
                'Support request submitted successfully!',
            context: context,
            isError: false,
          );
        }

        if (email.isNotEmpty) {
          await fetchSupportTickets(email);
        }
      } else {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Failed to create support ticket',
          context: context,
          isError: true,
        );
      }
    } catch (e) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'An error occurred: $e',
        context: context,
        isError: true,
      );
    } finally {
      isSubmitting = false;
      update();
    }
  }
}
