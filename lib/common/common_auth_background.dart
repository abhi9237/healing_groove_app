import 'package:flutter/cupertino.dart';

import '../core/color_constant/color_constant.dart';

class CommonAppBackground extends StatelessWidget {
  final Widget? child;
  final bool? isSafeAreaUse;
  const CommonAppBackground({super.key, this.child, this.isSafeAreaUse = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: Stack(
        children: [
          Positioned(
            top: -120,
            left: -120,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: CommonGradientColor.lightGradientColor,
              ),
            ),
          ),

          Positioned(
            bottom: -150,
            right: -100,
            child: Container(
              width: 460,
              height: 460,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: CommonGradientColor.lightGradientColor,
              ),
            ),
          ),
          ?isSafeAreaUse == false?
              child :
          child != null ?SafeArea(child: child!):SizedBox(),

        ],
      ),
    );
  }
}
