import 'package:flutter/material.dart';
import 'package:healing/common/common_app_bar.dart';
import '../../../../../core/color_constant/color_constant.dart';

class MyJourneyDetailAppBar extends StatelessWidget {
  const MyJourneyDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(title: 'My Journey',);
  }
}
