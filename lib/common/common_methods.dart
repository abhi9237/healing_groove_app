import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as f;
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/color_constant/color_constant.dart';
import 'common_extension.dart';

Future<void> showToastMessage({
  required String titleMessage,
  required String message,
  required BuildContext context,
  required bool isError,
}) async
{
  toastification.show(
    context: context,
    type: isError ? ToastificationType.error : ToastificationType.success,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(
      titleMessage,
      style: TextStyle(
        fontSize: 16,
        color: ColorConstant.whiteColor,
        fontWeight: FontWeight.w600,
      ),
    ),
    description: RichText(
      text: TextSpan(
        text: message,
        style: TextStyle(
          fontSize: 14,
          color: ColorConstant.whiteColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Afacad',
        ),
      ),
    ),
    alignment: Alignment.topCenter,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0.3, end: 1.0).animate(animation),
        child: child,
      );
    },
    icon: isError
        ? const Icon(Icons.error, color: ColorConstant.whiteColor)
        : const Icon(Icons.check),
    showIcon: true, // show or hide the icon
    primaryColor: Colors.green,
    backgroundColor: isError ? ColorConstant.redColor : ColorConstant.appColor,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    showProgressBar: true,
    closeButton: ToastCloseButton(
      showType: CloseButtonShowType.onHover,
      buttonBuilder: (context, onClose) {
        return OutlinedButton.icon(
          onPressed: onClose,
          icon: const Icon(Icons.close, size: 20),
          label: const Text('Close'),
        );
      },
    ),
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    onHoverMouseCursor: SystemMouseCursors.click,
    callbacks: ToastificationCallbacks(
      onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
      onCloseButtonTap: (toastItem) =>
          print('Toast ${toastItem.id} close button tapped'),
      onAutoCompleteCompleted: (toastItem) =>
          print('Toast ${toastItem.id} auto complete completed'),
      onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
    ),
  );
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

Future<void> onTapOpenEmailApp(String email, BuildContext context) async {
  final trimmedEmail = email.trim();

  if (trimmedEmail.isEmpty || !isValidEmail(trimmedEmail)) {
    showToastMessage(
      isError: true,
      context: context,
      titleMessage: 'Error',
      message: 'Please enter a valid email address',
    );
    return;
  }

  final Uri mailToUri = Uri(
    scheme: 'mailto',
    path: trimmedEmail,
    queryParameters: <String, String>{
      'subject': 'Verify your email',
      'body': 'Please verify this email address: $trimmedEmail',
    },
  );

  final bool openedMailApp = await launchUrl(
    mailToUri,
    mode: LaunchMode.externalApplication,
  );

  if (openedMailApp) {
    return;
  }

  final Uri gmailUri = Uri.parse(
    'https://mail.google.com/mail/?view=cm&fs=1&to=${Uri.encodeComponent(trimmedEmail)}&su=${Uri.encodeComponent('Verify your email')}&body=${Uri.encodeComponent('Please verify this email address: $trimmedEmail')}',
  );

  final Uri outlookUri = Uri.parse(
    'https://outlook.live.com/mail/0/deeplink/compose?to=${Uri.encodeComponent(trimmedEmail)}&subject=${Uri.encodeComponent('Verify your email')}&body=${Uri.encodeComponent('Please verify this email address: $trimmedEmail')}',
  );

  if (await launchUrl(gmailUri, mode: LaunchMode.externalApplication) ||
      await launchUrl(outlookUri, mode: LaunchMode.externalApplication)) {
    return;
  }

  if (!context.mounted) {
    return;
  }

  showToastMessage(
    isError: true,
    context: context,
    titleMessage: 'Unable to open mail app',
    message: 'Try again or open your email manually for $trimmedEmail',
  );
}

String formatTime(int seconds) {
  final minutes = seconds ~/ 60;
  final remainingSeconds = seconds % 60;
  final minutesStr = minutes.toString().padLeft(2, '0');
  final secondsStr = remainingSeconds.toString().padLeft(2, '0');
  return '$minutesStr:$secondsStr';
}

String formatDate(DateTime date) {
  return f.DateFormat('yyyy-MM-dd').format(date);
}


String getLocation({
  String? address,
  String? city,
  String? state,
  String? country,
}) {
  return [
    address?.capitalizeFirst,
    city?.capitalizeFirst,
    state?.capitalizeFirst,
    country?.capitalizeFirst,
  ].where((e) => e != null && e.trim().isNotEmpty).join(', ');
}

String capitalizeFirstLetter(String? text) {
  if (text == null || text.trim().isEmpty) return '';

  final trimmed = text.trim();
  return trimmed[0].toUpperCase() + trimmed.substring(1).toLowerCase();
}

String formatIndianPrice(num? price, {bool showSymbol = true}) {
  if (price == null) return showSymbol ? '₹0' : '0';

  final formatter = f.NumberFormat.currency(
    locale: 'en_IN',
    symbol: showSymbol ? '₹' : '',
    decimalDigits: 0,
  );

  return formatter.format(price);
}

 String getMonthYear(String? dateString) {
if (dateString == null || dateString.isEmpty) return '';

try {
final date = DateTime.parse(dateString).toLocal();
return f.DateFormat('MMMM yyyy').format(date);
} catch (e) {
return '';
}
}

int? parseInt(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  if (value is Map<String, dynamic>) {
    if (value['id'] is num) return (value['id'] as num).toInt();
    if (value['id'] is String) return int.tryParse(value['id']);
    if (value['_id'] is num) return (value['_id'] as num).toInt();
    if (value['_id'] is String) return int.tryParse(value['_id']);
  }
  return null;
}