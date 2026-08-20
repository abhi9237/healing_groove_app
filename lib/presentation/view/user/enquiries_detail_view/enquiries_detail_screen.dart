import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/controller/usercontroller/enquiries_detail_controller.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import '../../../../common/common_app_bar.dart';
import 'widget/detail_header.dart';
import 'widget/detail_centre_card.dart';
import 'widget/detail_requirements_card.dart';
import 'widget/detail_participants_card.dart';

class EnquiriesDetailScreen extends StatelessWidget {
  final String enquiryId;
  final DocModel? enquiryDetail;
  const EnquiriesDetailScreen({
    super.key,
    required this.enquiryId,
    this.enquiryDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonAppBackground(
        child: GetBuilder<EnquiriesDetailController>(
          init: EnquiriesDetailController(
            enquiryId: enquiryId,
            enquiryDetail: enquiryDetail,
          ),
          tag: enquiryId,
          builder: (controller) {
            if (controller.isLoading || controller.detailData == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final detailData = controller.detailData!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonAppBar(title: 'Enquiries & Bookings'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailHeader(detailData: detailData),
                        const SizedBox(height: 12),
                        DetailCentreCard(detailData: detailData),
                        const SizedBox(height: 12),
                        DetailRequirementsCard(detailData: detailData),
                        const SizedBox(height: 12),
                        DetailParticipantsCard(detailData: detailData),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
