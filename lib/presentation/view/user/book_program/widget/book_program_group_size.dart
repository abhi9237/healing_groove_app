import 'package:flutter/material.dart';
import 'package:healing/controller/usercontroller/book_program_controller.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import '../../../../../common/common_methods.dart';

class BookProgramGroupSize extends StatelessWidget {
  final BookProgramController controller;

  const BookProgramGroupSize({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Group Size',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorConstant.lightBlackColor,
          ),
        ),
        const SizedBox(height: 12),

        // Light lavender background card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF2FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // White pill quantity selector: -  1  +
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Minus Button
                    InkWell(
                      onTap: () => controller.decrementGroupSize(),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.remove_rounded,
                          color: controller.groupSize > controller.minGuests
                              ? Colors.grey.shade800
                              : Colors.grey.shade400,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Count
                    Text(
                      '${controller.groupSize}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Plus Button
                    InkWell(
                      onTap: () => controller.incrementGroupSize(),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: ColorConstant.appColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Right Calculation
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${controller.groupSize} x ₹${formatIndianPrice(controller.totalCalculatedPrice, showSymbol: false)} =',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '₹${formatIndianPrice(controller.totalPrice, showSymbol: false)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.appColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
