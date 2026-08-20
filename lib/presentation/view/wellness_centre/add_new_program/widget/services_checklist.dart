import 'package:flutter/material.dart';
import 'package:healing/common/common_widget.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import '../../../../../core/color_constant/color_constant.dart';

class ServicesChecklist extends StatelessWidget {
  final List<DocModel> services;
  final ValueChanged<int> onToggleService;
  final VoidCallback onAddServiceTap;
  final bool isLoading;

  const ServicesChecklist({
    super.key,
    required this.services,
    required this.onToggleService,
    required this.onAddServiceTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Services Included",
              style: TextStyle(
                    
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
            GestureDetector(
              onTap: onAddServiceTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: ColorConstant.appColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "ADD SERVICES",
                      style: TextStyle(
                            
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          "Select services from your centre to include in this program.",
          style: TextStyle(
                
            fontSize: 13,
            color: Colors.grey.shade500,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 16),

        // List of Service Items
        if (isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CommonCircularIndicator(),
            ),
          )
        else if (services.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "No services added",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        else
          Column(
            children: List.generate(services.length, (index) {
              final svc = services[index];
              final String name = svc.name ?? svc.title ?? 'Unnamed Service';
              final int price = svc.basePrice ?? 0;
              final bool isChecked = svc.isActive ?? false;

              return GestureDetector(
              onTap: () => onToggleService(index),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:  const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  children: [
                    // Checkbox
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: isChecked,
                        activeColor: ColorConstant.appColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                        onChanged: (val) => onToggleService(index),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Service Name
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(

                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.lightBlackColor,
                        ),
                      ),
                    ),

                    // Service Price
                    Text(
                      "₹${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                      style: const TextStyle(
                            
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
