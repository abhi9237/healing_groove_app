import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';

class CancelConfirmationController extends GetxController {
  void returnToDashboard(BuildContext context) {
    if (context.mounted) {
      context.go(RouteConstant.userDashboard);
    }
  }

  void contactSupport(BuildContext context) {
    showToastMessage(
      titleMessage: 'Support',
      message: 'Connecting to support concierge...',
      context: context,
      isError: false,
    );
  }
}
