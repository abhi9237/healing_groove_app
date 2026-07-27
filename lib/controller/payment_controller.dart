import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healing/controller/book_program_controller.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../common/common_methods.dart';
import '../presentation/model/response/booking_order_response_model.dart';
import '../presentation/model/response/error_response_model.dart';
import '../repository/book_program_repository.dart';

class PaymentController extends GetxController {
  Razorpay razorpay = Razorpay();
  BookProgramRepository bookProgramRepository = BookProgramRepository();

  RxBool isBookingLoading = false.obs;
  RxBool isVerifying = false.obs;

  String? currentBookingId;
  String? currentOrderId;

  @override
  void onInit() {
    super.onInit();
    attachListeners();
  }

  Future<void> attachListeners() async {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    log('PaymentController: Payment Success: ${response.paymentId}');
    final bookingId = currentBookingId ?? '';
    final orderId = response.orderId ?? currentOrderId ?? '';
    final paymentId = response.paymentId ?? '';
    final signature = response.signature ?? '';

    Map<String, dynamic> verifyData = {
      "bookingId": bookingId,
      "razorpay_order_id": orderId,
      "razorpay_payment_id": paymentId,
      "razorpay_signature": signature,
    };

    await verifyPayment(verifyData);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log('PaymentController: Payment Error: ${response.code} - ${response.message}');
    razorpay.clear();
    final context = Get.context;
    if (context != null && context.mounted) {
      showToastMessage(
        titleMessage: 'Payment Error',
        message: response.message ?? 'Payment failed',
        context: context,
        isError: true,
      );
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log('PaymentController: External Wallet Selected: ${response.walletName}');
    razorpay.clear();
    final context = Get.context;
    if (context != null && context.mounted) {
      showToastMessage(
        titleMessage: 'External Wallet',
        message: 'External wallet ${response.walletName} selected',
        context: context,
        isError: false,
      );
    }
  }

  void removeAllListeners() {
    razorpay.clear();
  }

  Future<void> createBookingOrder(
    BuildContext context,
    Map<String, dynamic> data,
  {
    int? price,
    String? description
  }
  ) async {
    try {
      isBookingLoading.value = true;
      if (data.containsKey('bookingId')) {
        currentBookingId = data['bookingId']?.toString();
      }

      var response = await bookProgramRepository.createBookingOrder(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        BookingOrderResponseModel bookingResponseModel =
            BookingOrderResponseModel.fromJson(response.data);

        if (bookingResponseModel.bookingId != null) {
          currentBookingId = bookingResponseModel.bookingId.toString();
        }
        currentOrderId = bookingResponseModel.orderId;

        var options = {
          'key': bookingResponseModel.keyId,
          'amount':price ?? Get.find<BookProgramController>().totalPrice * 100,
          'currency': 'INR',
          'name': 'The Healing Groove',
          'order_id': bookingResponseModel.orderId,
          'description':
          description ?? Get.find<BookProgramController>().packageModel?.name ?? '',
          'timeout': 120,
          'prefill': {
            'name': HiveStorageService.getUserName(),
            'email': HiveStorageService.getUserEmail(),
          },
        };
        razorpay.open(options);
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        final errorMessage =
            errorResponse.errors?.first.message ?? 'Failed to create payment order';
        final ctx = Get.context ?? context;
        if (ctx.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: errorMessage,
            context: ctx,
            isError: true,
          );
        }
      }
    } catch (e) {
      log('PaymentController: Error creating booking order: $e');
    } finally {
      isBookingLoading.value = false;
    }
    update();
  }

  Future<void> verifyPayment(Map<String, dynamic> data) async {
    try {
      isVerifying.value = true;
      var response = await bookProgramRepository.verifyPayment(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('PaymentController: Payment Verification Success: ${response.data}');
        final context = Get.context;
        if (context != null && context.mounted) {
          showToastMessage(
            titleMessage: 'Success',
            message: 'Payment verified and booking confirmed!',
            context: context,
            isError: false,
          );
        }
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        final errorMessage =
            errorResponse.errors?.first.message ?? 'Payment verification failed';
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
      log('PaymentController: Error verifying payment: $e');
      final context = Get.context;
      if (context != null && context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Error verifying payment. Please try again.',
          context: context,
          isError: true,
        );
      }
    } finally {
      isVerifying.value = false;
    }
    update();
  }

  @override
  void onClose() {
    super.onClose();
    removeAllListeners();
  }
}
