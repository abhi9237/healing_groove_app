
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../core/color_constant/color_constant.dart';

class AppLoader extends StatelessWidget {
  final RxBool isLoading;
  final Widget child;

  const AppLoader({super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Stack(
        children: [
          // Main UI
          child,
          // Loader Overlay
          if (isLoading.value)
            Positioned.fill(
              child: AbsorbPointer(
                absorbing: true,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: LoadingAnimationWidget.newtonCradle(
                      color: ColorConstant.appColor,
                      size: 120,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
