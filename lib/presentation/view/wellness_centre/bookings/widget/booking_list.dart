import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/controller/wellnesscentrecontroller/wellness_booking_controller.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'booking_list_item.dart';

class BookingList extends StatelessWidget {
  final List<DocModel> bookings;
  final WellnessBookingController controller;

  const BookingList({
    super.key,
    required this.bookings,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
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
                "No bookings found",
                style: TextStyle(
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
      itemCount: bookings.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return BookingListItem(
          booking: booking,
          onViewTap: () => context.push(RouteConstant.wellnessBookingDetail, extra: booking),
          onEditTap: () => controller.editBookingStatus(context, booking),
        );
      },
    );
  }
}
