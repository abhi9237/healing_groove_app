import 'package:flutter/material.dart';
import 'package:healing/controller/wellnesscentrecontroller/services_controller.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'service_card_item.dart';

class ServicesListView extends StatelessWidget {
  final List<DocModel> services;
  final ServicesController controller;

  const ServicesListView({
    super.key,
    required this.services,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 48,
                color: Colors.grey,
              ),
              SizedBox(height: 12),
              Text(
                "No services found",
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final svc = services[index];
        return ServiceCardItem(
          service: svc,
          onEditTap: () => controller.editService(context, svc),
          onDeleteTap: () => controller.deleteService(context, svc),
        );
      },
    );
  }
}
