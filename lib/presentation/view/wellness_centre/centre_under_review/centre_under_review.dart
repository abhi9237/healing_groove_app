import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/presentation/model/response/centre_response_model.dart';
import '../../../../common/common_auth_background.dart';
import '../../../../controller/wellnesscentrecontroller/setup_center_detail_controller.dart';
import '../../../../core/color_constant/color_constant.dart';
import '../../../../core/image_constant/image_constant.dart';
import 'widget/review_header.dart';
import 'widget/application_summary.dart';
import 'widget/support_button.dart';

class CentreUnderReview extends StatelessWidget {
  final CentreResponseModel? centreResponse;
  const CentreUnderReview({super.key, this.centreResponse});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<SetupCenterDetailController>()
        ? Get.find<SetupCenterDetailController>()
        : Get.put(SetupCenterDetailController());

    if (centreResponse != null) {
      controller.createdCentreResponse = centreResponse;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<SetupCenterDetailController>(
        init: controller,
        builder: (controller) {
          return CommonAppBackground(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Back Icon at the top
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        context.go(RouteConstant.login);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: ColorConstant.lightBlackColor,
                        size: 26,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Header Section
                  ReviewHeader(
                    centerName:
                        controller.createdCentreResponse?.doc?.name ??
                        controller.centerNameController.text,
                  ),
                  const SizedBox(height: 24),

                  // Summary Card
                  ApplicationSummary(
                    centerName:
                        controller.createdCentreResponse?.doc?.name ??
                        controller.centerNameController.text,
                    status:
                        controller
                            .createdCentreResponse?.doc
                            ?.approvalStatus ??
                        controller.createdCentreResponse?.doc?.status,
                    createdAt:
                        controller.createdCentreResponse?.doc?.createdAt,
                  ),
                  const SizedBox(height: 24),

                  // Reception Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CustomImageView(
                      width: double.infinity,
                      height: 230,
                      url:
                          controller
                              .createdCentreResponse?.doc
                              ?.image
                              ?.url ??
                          '',
                      errorWidget: (context, url, error) => Image.asset(
                        ImageConstant.imageNotFound,
                        width: double.infinity,
                        height: 230,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Contact Support Button
                  SupportButton(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opening support portal...'),
                          backgroundColor: ColorConstant.appColor,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
