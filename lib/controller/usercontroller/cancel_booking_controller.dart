import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/repository/book_program_repository.dart';
import 'package:healing/repository/my_journey_repository.dart';
import 'package:healing/presentation/model/response/booking_cancellation_request_response_model.dart';
import 'package:healing/presentation/model/response/error_response_model.dart';
import 'package:intl/intl.dart' as f;

import '../../core/color_constant/color_constant.dart';

class CancelBookingController extends GetxController {
  final int bookingId;
  CancelBookingController({required this.bookingId});

  final BookProgramRepository bookProgramRepository = BookProgramRepository();
  final MyJourneyRepository myJourneyRepository = MyJourneyRepository();
  final RxBool isLoading = false.obs;

  // Refund Preview Data
  DocModel? refundPreview;
  String? applicablePolicyRule;
  int? refundPercent;
  int? refundPreviewAmount;

  // Booking details computed dynamically from the preview response
  String get displayBookingId => refundPreview?.bookingId?.toString() ?? bookingId.toString();
  
  String get bookingDate {
    if (refundPreview?.createdAt != null) {
      try {
        final date = DateTime.parse(refundPreview!.createdAt!).toLocal();
        return f.DateFormat('dd MMM yyyy').format(date);
      } catch (_) {}
    }
    return '28 May 2026';
  }

  String get programStart {
    if (refundPreview?.startDate != null) {
      try {
        final date = DateTime.parse(refundPreview!.startDate!).toLocal();
        return f.DateFormat('dd MMM yyyy').format(date);
      } catch (_) {}
    }
    return '05 Jun 2026';
  }

  String get cancellationDate {
    return f.DateFormat('dd MMM yyyy').format(DateTime.now());
  }
  
  // Observables
  final RxBool isPolicyAccepted = false.obs;
  
  // Controllers
  final TextEditingController reasonController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchRefundPreview();
  }

  Future<void> fetchRefundPreview() async {
    isLoading.value = true;
    update();

    try {
      final response = await myJourneyRepository.getRefundPreview(bookingId);
      if (response.statusCode == 200 && response.data != null) {
        log('CancelBookingController: Refund preview data ===> ${response.data}');
        refundPreview = DocModel.fromJson(response.data);
        applicablePolicyRule = refundPreview?.cancellationPolicyRule ?? refundPreview?.cancellationPolicyScenario?.toString();
        refundPercent = refundPreview?.cancellationRefundPercent;
        refundPreviewAmount = refundPreview?.cancellationRefundAmount;
      } else {
        log('CancelBookingController: Non-200 response from preview endpoint, calculating locally.');
        calculateLocalFallback();
      }
    } catch (e) {
      log('CancelBookingController: Error fetching preview, calculating locally: $e');
      calculateLocalFallback();
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void calculateLocalFallback() {
    refundPreviewAmount = 0;
    refundPercent = 0;
    applicablePolicyRule = 'Cancelled less than 24 hours before start — No refund';
  }

  void togglePolicyAcceptance() {
    isPolicyAccepted.value = !isPolicyAccepted.value;
    update();
  }

  void keepBooking(BuildContext context) {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  void confirmCancellation(BuildContext context) {
    if (!isPolicyAccepted.value) {
      showToastMessage(
        titleMessage: 'Agreement Required',
        message: 'Please accept the cancellation policy to proceed.',
        context: context,
        isError: true,
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (modalContext) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFFFEE2E2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.report_problem_outlined,
                  color: Colors.red,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Cancel Booking?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Are you sure you want to cancel your booking #$displayBookingId? This action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.greyColor.withValues(alpha: 0.8),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(modalContext),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.lightBlackColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(modalContext);
                          _hitCancellationApi(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFA6D6D),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _hitCancellationApi(BuildContext context) async {
    try {
      isLoading.value = true;
      update();

      final Map<String, dynamic> payload = {
        'bookingId': bookingId,
        'reason': reasonController.text.trim(),
      };

      final response = await bookProgramRepository.requestCancellation(payload);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final BookingCancellationRequestModel model = BookingCancellationRequestModel.fromJson(response.data);
        log('Cancellation requested successfully: ${model.status}');

        final targetContext = Get.context ?? context;
        if (targetContext.mounted) {
          showToastMessage(
            titleMessage: 'Cancelled Successfully',
            message: 'Your cancellation request has been submitted successfully.',
            context: targetContext,
            isError: false,
          );
          targetContext.go(RouteConstant.cancelConfirmation);
        }
      } else {
        final errorResponse = ErrorResponseModel.fromJson(response.data);
        final errorMessage = errorResponse.errors?.first.message ?? 'Failed to request cancellation';
        
        final targetContext = Get.context ?? context;
        if (targetContext.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: errorMessage,
            context: targetContext,
            isError: true,
          );
        }
      }
    } catch (e) {
      log('CancelBookingController confirmCancellation error: $e');
      final targetContext = Get.context ?? context;
      if (targetContext.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'An unexpected error occurred during cancellation request.',
          context: targetContext,
          isError: true,
        );
      }
    } finally {
      isLoading.value = false;
      update();
    }
  }

  @override
  void onClose() {
    reasonController.dispose();
    super.onClose();
  }
}
