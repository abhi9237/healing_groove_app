import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/image_constant/image_constant.dart';

class WelcomeBackgroundWidget extends StatelessWidget {
  const WelcomeBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
    child: CustomImageView(
      imagePath: ImageConstant.welcomeImg,
      fit: BoxFit.cover,
    ),
    );
  }
}
