import 'package:flutter/cupertino.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class WelcomeGradientWidget extends StatelessWidget {
  const WelcomeGradientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
       gradient: CommonGradientColor.welcomeGradientColor,
      ),
    );
  }
}
