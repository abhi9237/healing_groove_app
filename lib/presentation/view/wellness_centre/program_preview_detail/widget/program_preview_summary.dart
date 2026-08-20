import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/controller/wellnesscentrecontroller/program_preview_detail_controller.dart';

class ProgramPreviewSummary extends StatelessWidget {
  final ProgramPreviewDetailController controller;
  const ProgramPreviewSummary({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC), // very light grey/blue
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Base Program
          _buildSummaryRow(
            label: 'Base Program',
            value: '₹${controller.baseProgramPrice}',
          ),
          const SizedBox(height: 12),
          // Services Total
          _buildSummaryRow(
            label: 'Services Total',
            value: '₹${controller.servicesTotal}',
          ),
          const SizedBox(height: 12),
          // Doctors Total
          _buildSummaryRow(
            label: 'Doctors Total',
            value: '₹${controller.doctorsTotal}',
          ),
          const SizedBox(height: 20),

          // Divider
          const Divider(
            color: Color(0xFFE2E8F0),
            thickness: 1.2,
            height: 1,
          ),
          const SizedBox(height: 20),

          // GRAND TOTAL / Invested Balance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GRAND TOTAL',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Invested\nBalance',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.lightBlackColor,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
              Text(
                '₹${controller.grandTotal}',
                style: const TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.appColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 14,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Afacad',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: ColorConstant.lightBlackColor,
          ),
        ),
      ],
    );
  }
}
