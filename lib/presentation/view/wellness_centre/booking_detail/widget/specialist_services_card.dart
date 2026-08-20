import 'package:flutter/material.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import '../../../../../core/color_constant/color_constant.dart';
import '../../../../../presentation/model/common/doc_model.dart';

class SpecialistServicesCard extends StatelessWidget {
  final DocModel booking;

  const SpecialistServicesCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final specialistName = (booking.assignedDoctor != null && booking.assignedDoctor!.isNotEmpty)
        ? booking.assignedDoctor!.first.name ?? 'Not Assigned'
        : (booking.doctors != null && booking.doctors!.isNotEmpty)
            ? booking.doctors!.first.name ?? 'Not Assigned'
            : '—';
    final specialistTitle = (booking.assignedDoctor != null && booking.assignedDoctor!.isNotEmpty)
        ? booking.assignedDoctor!.first.specialization ?? 'Specialist'
        : (booking.doctors != null && booking.doctors!.isNotEmpty)
            ? booking.doctors!.first.specialization ?? 'Specialist'
            : '—';
    const String specialistAvatarUrl = ImageConstant.doctorImg;

    final servicesList = (booking.services != null && booking.services!.isNotEmpty)
        ? booking.services!.map((s) => s.name ?? '').toList()
        : (booking.package?.services != null && booking.package!.services!.isNotEmpty)
            ? booking.package!.services!.map((s) => s.name ?? '').toList()
            : <String>[];
    
    final services = servicesList.isNotEmpty ? servicesList : ['Morning Walk', 'Panchakarma Detox'];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(booking.assignedDoctor != null && booking.assignedDoctor!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ASSIGNED SPECIALIST",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 12),

              // Specialist Card Box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorConstant.appColor, // very light blue tint background
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // Doctor Avatar
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),

                      ),
                      padding: EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          image:  DecorationImage(
                            image: AssetImage(specialistAvatarUrl,),
                            // image: NetworkImage(specialistAvatarUrl),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Name & Specialization
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            specialistName,
                            style: const TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.whiteColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            specialistTitle,
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 12,
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),

          // Assigned Specialist Header


          // Services Included Header
          Text(
            "SERVICES INCLUDED",
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 12),

          // Services Tags Wrap
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(services.length, (index) {
              final String service = services[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9), // Light green background
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFC8E6C9), width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      color: ColorConstant.appColor,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      service,
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.appColor,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
