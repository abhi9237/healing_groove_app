import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/common_app_bar.dart';
import '../../../../../common/common_auth_background.dart';
import '../../../../../controller/wellnesscentrecontroller/wellness_booking_detail_controller.dart';
import '../../../../../presentation/model/common/doc_model.dart';
import 'widget/booking_id_card.dart';
import 'widget/user_details_card.dart';
import 'widget/program_details_card.dart';
import 'widget/specialist_services_card.dart';
import 'widget/payment_summary_card.dart';
import 'widget/booking_action_buttons.dart';

class WellnessBookingDetailScreen extends StatelessWidget {
  final String bookingId;
  final DocModel? bookingDoc;

  const WellnessBookingDetailScreen({
    super.key,
    required this.bookingId,
    this.bookingDoc,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<WellnessBookingDetailController>(
          init: WellnessBookingDetailController(
            bookingId: bookingId,
            initialBooking: bookingDoc,
          ),
          tag: bookingId,
          builder: (controller) {
            if (controller.isLoading.value || controller.bookingDetails == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF08864F),
                ),
              );
            }

            final details = controller.bookingDetails!;

            return Column(
              children: [
                const CommonAppBar(
                  title: 'Booking Details',
                  showBackButton: true,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BookingIdCard(booking: details),
                        const SizedBox(height: 24),
                        UserDetailsCard(booking: details),
                        const SizedBox(height: 24),
                        ProgramDetailsCard(booking: details),
                        const SizedBox(height: 24),
                        SpecialistServicesCard(booking: details),
                        const SizedBox(height: 24),
                        PaymentSummaryCard(booking: details),
                        const SizedBox(height: 24),
                        BookingActionButtons(
                          isLoadingReceipt: controller.isLoadingReceipt.value,
                          onUpdateStatusTap: () => controller.updateBookingStatus(context),
                          onDownloadTap: () => controller.downloadReceipt(context),
                        ),
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
