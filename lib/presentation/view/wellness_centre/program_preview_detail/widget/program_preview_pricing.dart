import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/common/doctor_model.dart';
import 'package:healing/presentation/model/common/service_model.dart';

class ProgramPreviewPricing extends StatelessWidget {
  final DocModel program;
  const ProgramPreviewPricing({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final int basePriceVal = program.price ?? program.basePrice ?? program.minPrice ?? 0;
    final List<ServiceModel> services = program.services ?? [];
    final List<DoctorModel> doctors = program.doctors ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          children: [
            Container(
              width: 4,
              height: 18,
              decoration: BoxDecoration(
                color: ColorConstant.appColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Pricing & Inclusions',
              style: TextStyle(
                fontFamily: 'Afacad',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Main Pricing & Inclusions Card Box
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.01),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Program Base Price Row
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Label
                    Row(
                      children: [
                        const Icon(
                          Icons.sell_outlined,
                          color: ColorConstant.appColor,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Program Base Price',
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.appColor.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                    // Price
                    Text(
                      '₹$basePriceVal',
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.appColor,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(color: Color(0xFFF1F5F9), thickness: 1.2, height: 1),

              // Included Services Section
              if (services.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'INCLUDED SERVICES',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  itemCount: services.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final svc = services[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFF1F5F9)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEFF6FF), // light blue circle
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.health_and_safety_outlined,
                              color: Color(0xFF1D4ED8),
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              svc.name ?? '',
                              style: const TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.lightBlackColor,
                              ),
                            ),
                          ),
                          Text(
                            '₹${svc.basePrice ?? 0}',
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
              ],

              // Assigned Doctors Section
              if (doctors.isNotEmpty) ...[
                const Divider(color: Color(0xFFF1F5F9), thickness: 1.2, height: 1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'ASSIGNED DOCTORS',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  itemCount: doctors.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final doc = doctors[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFF1F5F9)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE8F5E9), // light green circle
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.medical_services_outlined,
                              color: ColorConstant.appColor,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doc.name ?? '',
                                  style: const TextStyle(
                                    fontFamily: 'Afacad',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstant.lightBlackColor,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  doc.specialization ?? doc.role ?? 'Ayurveda Physician',
                                  style: TextStyle(
                                    fontFamily: 'Afacad',
                                    fontSize: 11,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '₹${doc.consultationFee ?? 0}',
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
