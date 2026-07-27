import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/controller/payment_controller.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/common/common_methods.dart';
import 'package:intl/intl.dart' as f;

class MyJourneyDetailController extends GetxController {
  final DocModel? booking;

  MyJourneyDetailController({this.booking});
  RxBool isLoadingPayment = false.obs;
  // Booking Info
  String get bookingId =>
      booking?.bookingId?.toString() ??
      booking?.id?.toString() ??
      'BK-MPPDGT94';

  String get initiatedDate {
    if (booking?.createdAt != null) {
      try {
        final date = DateTime.parse(booking!.createdAt!).toLocal();
        return f.DateFormat('MMMM dd, yyyy').format(date);
      } catch (e) {
        return booking!.createdAt!;
      }
    }
    return 'May 28, 2026';
  }

  String get status => booking?.status ?? 'REQUESTED';

  // Resort Info
  String get resortName => booking?.center?.name ?? 'Kairali Ayurvedic Resort';

  String get location => getLocation(
    address: booking?.center?.location?.address,
    city: booking?.center?.location?.city,
    state: booking?.center?.location?.state,
    country: booking?.center?.location?.country,
  );

  double get rating => booking?.center?.rating ?? 4.8;
  int get reviewsCount => booking?.center?.reviewCount ?? 0;
  String get phone => booking?.center?.phone ?? '9876907266';
  String get email => booking?.center?.email ?? 'sandeep@oceaniek.org';
  String get address =>
      booking?.center?.location?.address ?? '1210 sector 51B, Chandigarh';
  String get imageUrl => booking?.center?.image?.url ?? '';

  // Stay Info
  String get checkInDate {
    if (booking?.startDate != null) {
      try {
        final date = DateTime.parse(booking!.startDate!).toLocal();
        return f.DateFormat('dd MMM yyyy').format(date);
      } catch (e) {
        return booking!.startDate!;
      }
    }
    return '06 Jun 2026';
  }

  String get checkInTime =>
      booking?.slotTime != null ? 'From ${booking!.slotTime}' : 'From 12:00 PM';

  String get checkOutDate {
    if (booking?.startDate != null && booking?.package?.duration != null) {
      try {
        final checkIn = DateTime.parse(booking!.startDate!);
        final checkOut = checkIn.add(
          Duration(days: booking!.package!.duration!),
        );
        return f.DateFormat('dd MMM yyyy').format(checkOut);
      } catch (e) {
        return 'TBD';
      }
    }
    return 'TBD';
  }

  String get checkOutTime => 'By 11:00 AM';
  String get duration => '${booking?.package?.duration ?? 0} Days';

  String get completedDate {
    if (booking?.completedAt != null) {
      try {
        final date = DateTime.parse(booking!.completedAt!.toString()).toLocal();
        return f.DateFormat('MMMM dd, yyyy').format(date);
      } catch (e) {
        return booking!.completedAt!.toString();
      }
    }
    return '';
  }

  String get cancelledDate {
    final cancelVal = booking?.cancelledAt ?? booking?.cancellationApprovedAt;
    if (cancelVal != null) {
      try {
        final date = DateTime.parse(cancelVal.toString()).toLocal();
        return f.DateFormat('MMMM dd, yyyy').format(date);
      } catch (e) {
        return cancelVal.toString();
      }
    }
    return '';
  }

  // Pricing
  double get totalPayable =>
      booking?.chargeAmount?.toDouble() ??
      booking?.totalAmount?.toDouble() ??
      0;
  double get amount => booking?.totalAmount?.toDouble() ?? totalPayable;
  double get taxes => totalPayable - amount;

  double get settledAmount {
    final s = status.toUpperCase();
    if (s == 'CONFIRMED' || s == 'COMPLETED') {
      return totalPayable;
    }
    return 0.0;
  }

  // Timeline Step Class
  List<Map<String, dynamic>> get timelineSteps {
    final s = status.toUpperCase();

    // Default dates
    String step1Time = 'TBD';
    if (booking?.createdAt != null) {
      try {
        final date = DateTime.parse(booking!.createdAt!).toLocal();
        step1Time = f.DateFormat('MMM dd, yyyy • hh:mm a').format(date);
      } catch (_) {}
    }

    String step3Date = 'Estimated $checkInDate';
    String step4Date = 'Journey end & Checkout';

    if (s == 'INITIATED' || s == 'PENDING') {
      return [
        {
          'title': 'Booking Initiated',
          'subtitle': step1Time,
          'status': 'DONE',
          'isCompleted': true,
          'isActive': false,
        },
        {
          'title': 'Secure Payment',
          'subtitle': 'Awaiting completion to confirm',
          'status': 'ACTION NEEDED',
          'isCompleted': false,
          'isActive': true,
        },
        {
          'title': 'Arrival & Check-in',
          'subtitle': step3Date,
          'status': 'UPCOMING',
          'isCompleted': false,
          'isActive': false,
        },
        {
          'title': 'Completion',
          'subtitle': step4Date,
          'status': 'UPCOMING',
          'isCompleted': false,
          'isActive': false,
        },
      ];
    } else if (s == 'CONFIRMED') {
      return [
        {
          'title': 'Booking Initiated',
          'subtitle': step1Time,
          'status': 'DONE',
          'isCompleted': true,
          'isActive': false,
        },
        {
          'title': 'Secure Payment',
          'subtitle': 'Payment received successfully',
          'status': 'DONE',
          'isCompleted': true,
          'isActive': false,
        },
        {
          'title': 'Arrival & Check-in',
          'subtitle': step3Date,
          'status': 'UPCOMING',
          'isCompleted': false,
          'isActive': true,
        },
        {
          'title': 'Completion',
          'subtitle': step4Date,
          'status': 'UPCOMING',
          'isCompleted': false,
          'isActive': false,
        },
      ];
    } else if (s == 'COMPLETED') {
      return [
        {
          'title': 'Booking Initiated',
          'subtitle': step1Time,
          'status': 'DONE',
          'isCompleted': true,
          'isActive': false,
        },
        {
          'title': 'Secure Payment',
          'subtitle': 'Payment received successfully',
          'status': 'DONE',
          'isCompleted': true,
          'isActive': false,
        },
        {
          'title': 'Arrival & Check-in',
          'subtitle': 'Checked in',
          'status': 'DONE',
          'isCompleted': true,
          'isActive': false,
        },
        {
          'title': 'Completion',
          'subtitle': 'Checked out successfully',
          'status': 'DONE',
          'isCompleted': true,
          'isActive': false,
        },
      ];
    } else {
      // Cancelled or other
      return [
        {
          'title': 'Booking Initiated',
          'subtitle': step1Time,
          'status': 'DONE',
          'isCompleted': true,
          'isActive': false,
        },
        {
          'title': 'Booking Cancelled',
          'subtitle': 'This journey has been cancelled',
          'status': 'CANCELLED',
          'isCompleted': false,
          'isActive': false,
        },
      ];
    }
  }

  // Actions
  void refreshStatus(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.refresh_rounded, color: Colors.white),
            SizedBox(width: 12),
            Text(
              'Refreshing booking status...',
              style: TextStyle(
                fontFamily: 'Afacad',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF08864F),
        duration: const Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void contactSupport(BuildContext context) {
    context.push(RouteConstant.helpSupport);

    // _showSnackBar(context, 'Opening Support Chat...', Icons.support_agent_rounded);
  }

  void cancelBooking(BuildContext context) {
    context.push(
      RouteConstant.cancelBooking,
      extra: {'bookingId': booking?.id ?? 0},
    );
  }

  void payBooking(BuildContext context) {
    try {
      isLoadingPayment.value = true;
      final c = Get.put(PaymentController());

      var data = {'bookingId': booking?.id ?? 0};

      c.createBookingOrder(
        context,
        data,
        description: booking?.description ?? '',
        price: booking?.chargeAmount ?? 0,
      );
    } catch (e) {
      log('Error $e');
    } finally {
      isLoadingPayment.value = false;
    }
    update();
    // _showSnackBar(context, 'Initiating payment gateway for Total Payable...', Icons.payment_rounded);
  }

  void rescheduleBooking(BuildContext context) {
    _showSnackBar(
      context,
      'Loading reschedule calendar...',
      Icons.calendar_today_rounded,
    );
  }

  void getInvoicePdf(BuildContext context) {
    _showSnackBar(
      context,
      'Downloading Invoice PDF...',
      Icons.file_download_rounded,
    );
  }

  void connectWithUs(BuildContext context) {
    _showSnackBar(
      context,
      'Connecting to 24/7 Concierge Support...',
      Icons.headset_mic_rounded,
    );
  }

  void _showSnackBar(BuildContext context, String text, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Afacad',
                fontWeight: FontWeight.w600,
              ),
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
}
