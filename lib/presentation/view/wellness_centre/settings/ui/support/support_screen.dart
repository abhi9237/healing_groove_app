import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/controller/wellnesscentrecontroller/support_controller.dart';
import 'package:intl/intl.dart';
import '../../../../../../../common/common_app_bar.dart';
import '../../../../../../../common/common_auth_background.dart';
import '../../../../../../../common/common_text_form_filled.dart';
import '../../../../../../../core/color_constant/color_constant.dart';
import 'widget/support_stats_tile.dart';
import '../../../../../../../common/app_shimmer.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<SupportController>(
          init: SupportController(),
          builder: (controller) {
            return Column(
              children: [
                // App Bar
                const CommonAppBar(
                  title: 'Support',
                  showBackButton: true,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stats Row (3 columns)
                        Row(
                          children: [
                            Expanded(
                              child: SupportStatsTile(
                                icon: Icons.calendar_today_outlined,
                                label: 'BOOKINGS',
                                value: '${controller.bookingsCount}',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: SupportStatsTile(
                                icon: Icons.chat_bubble_outline_rounded,
                                label: 'ENQUIRIES',
                                value: '${controller.enquiriesCount}',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: SupportStatsTile(
                                icon: Icons.business_rounded,
                                label: 'CENTRE',
                                value: controller.centerName,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Form card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Create Support Request',
                                style: TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.lightBlackColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Include booking ID, enquiry ID, or program name in your message so we can help faster.',
                                style: TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Subject field
                              _buildLabel('Subject'),
                              CommonTextFormFilled(
                                hintText: 'Payout issue, listing update, doctor access...',
                                controller: controller.subjectController,
                                height: 48,
                              ),
                              const SizedBox(height: 16),

                              // Phone field
                              _buildLabel('Phone (optional)'),
                              CommonTextFormFilled(
                                hintText: '+91...',
                                controller: controller.phoneController,
                                keyboardType: TextInputType.phone,
                                height: 48,
                              ),
                              const SizedBox(height: 16),

                              // Message field
                              _buildLabel('Message'),
                              CommonTextFormFilled(
                                hintText: 'Describe your issue...',
                                controller: controller.messageController,
                                maxLines: 4,
                                height: 96,
                              ),
                              const SizedBox(height: 16),

                              // Submit button
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton.icon(
                                  onPressed: controller.isSubmitting
                                      ? null
                                      : () => controller.submitRequest(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConstant.appColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  icon: controller.isSubmitting
                                      ? const SizedBox.shrink()
                                      : const Icon(Icons.mail_outline_rounded, color: Colors.white, size: 20),
                                  label: controller.isSubmitting
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        )
                                      : const Text(
                                          'Submit Request',
                                          style: TextStyle(
                                            fontFamily: 'Afacad',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Recent tickets block
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Your Recent Tickets',
                                  style: TextStyle(
                                    fontFamily: 'Afacad',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstant.lightBlackColor,
                                  ),
                                ),
                              ),
                              if (controller.isLoading)
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 2,
                                  itemBuilder: (ctx, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF8FAFC),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: const Color(0xFFF1F5F9)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            AppShimmer(width: 140, height: 16),
                                            SizedBox(height: 10),
                                            AppShimmer(width: double.infinity, height: 12),
                                            SizedBox(height: 6),
                                            AppShimmer(width: 200, height: 12),
                                            SizedBox(height: 12),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                AppShimmer(width: 80, height: 20, radius: 10),
                                                AppShimmer(width: 60, height: 12),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              else if (controller.ticketsList.isEmpty)
                                Column(
                                  children: [
                                    const SizedBox(height: 32),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF8FAFC),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.confirmation_number_outlined,
                                        color: Colors.grey.shade400,
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'No support tickets yet.',
                                      style: TextStyle(
                                        fontFamily: 'Afacad',
                                        fontSize: 13,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                )
                              else
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.ticketsList.length,
                                  itemBuilder: (ctx, index) {
                                    final ticket = controller.ticketsList[index];
                                    final String subject = ticket.subject ?? 'No Subject';
                                    final String message = ticket.message ?? '';
                                    final String status = ticket.status ?? 'pending';
                                    final String dateStr = ticket.createdAt ?? '';

                                    String formattedDate = '';
                                    try {
                                      final date = DateTime.parse(dateStr);
                                      formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(date);
                                    } catch (_) {
                                      formattedDate = dateStr;
                                    }

                                    Color badgeColor = const Color(0xFFE2E8F0);
                                    Color textColor = Colors.grey.shade700;
                                    if (status.toLowerCase() == 'resolved') {
                                      badgeColor = const Color(0xFFE8F5E9);
                                      textColor = const Color(0xFF2E7D32);
                                    } else if (status.toLowerCase() == 'pending' || status.toLowerCase() == 'open') {
                                      badgeColor = const Color(0xFFFEF3C7);
                                      textColor = const Color(0xFFD97706);
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF8FAFC),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: const Color(0xFFF1F5F9)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    subject,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontFamily: 'Afacad',
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: ColorConstant.lightBlackColor,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: badgeColor,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Text(
                                                    status.toUpperCase(),
                                                    style: TextStyle(
                                                      fontFamily: 'Afacad',
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.bold,
                                                      color: textColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              message,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Afacad',
                                                fontSize: 12.5,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              formattedDate,
                                              style: TextStyle(
                                                fontFamily: 'Afacad',
                                                fontSize: 10,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Urgent contact block
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.contact_support_outlined,
                                    color: Colors.grey.shade500,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Urgent contact',
                                    style: TextStyle(
                                      fontFamily: 'Afacad',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstant.lightBlackColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Email support block
                              _buildUrgentContactItem(
                                icon: Icons.mail_outline_rounded,
                                value: 'support@thehealinggroove.com',
                              ),
                              const SizedBox(height: 10),

                              // Phone support block
                              _buildUrgentContactItem(
                                icon: Icons.phone_outlined,
                                value: '+91 800-123-4567',
                              ),
                            ],
                          ),
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Afacad',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

  Widget _buildUrgentContactItem({
    required IconData icon,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: ColorConstant.appColor,
            size: 18,
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Afacad',
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              color: ColorConstant.appColor,
            ),
          ),
        ],
      ),
    );
  }
}
