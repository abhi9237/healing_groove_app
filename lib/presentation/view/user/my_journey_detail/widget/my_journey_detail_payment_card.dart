import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/my_journey_detail_controller.dart';
import 'package:healing/common/common_methods.dart';

class MyJourneyDetailPaymentCard extends StatelessWidget {
  final MyJourneyDetailController controller;

  const MyJourneyDetailPaymentCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left Orange Vertical Strip Accent
                Container(
                  width: 6,
                  color: const Color(0xFFE58B0E),
                ),
                
                // Card contents
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon, Title & Suffix Trash Icon
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF7ED),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Color(0xFFE58B0E),
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Action Required: Payment',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstant.lightBlackColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Complete payment to finalize your booking with ${controller.resortName}.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.greyColor.withValues(alpha: 0.8),
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.red,
                                size: 22,
                              ),
                              onPressed: () => controller.cancelBooking(context),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Buttons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 46,
                              child: ElevatedButton(
                                onPressed: () => controller.payBooking(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstant.appColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.payment_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Pay ${formatIndianPrice(controller.totalPayable)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Expanded(
                            //   child: SizedBox(
                            //     height: 46,
                            //     child: OutlinedButton(
                            //       onPressed: () => controller.rescheduleBooking(context),
                            //       style: OutlinedButton.styleFrom(
                            //         side: BorderSide(color: Colors.grey.shade300),
                            //         shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(12),
                            //         ),
                            //       ),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: const [
                            //           Icon(
                            //             Icons.calendar_today_outlined,
                            //             color: ColorConstant.lightBlackColor,
                            //             size: 15,
                            //           ),
                            //           SizedBox(width: 8),
                            //           Text(
                            //             'Reschedule',
                            //             style: TextStyle(
                            //               fontSize: 14,
                            //               fontWeight: FontWeight.bold,
                            //               color: ColorConstant.lightBlackColor,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
