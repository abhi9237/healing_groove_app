import 'package:flutter/material.dart';
import 'package:healing/common/common_widget.dart';
import '../../../../../core/color_constant/color_constant.dart';

class BookingActionButtons extends StatelessWidget {
  final VoidCallback onUpdateStatusTap;
  final VoidCallback onDownloadTap;
  final bool isLoadingReceipt;

  const BookingActionButtons({
    super.key,
    required this.onUpdateStatusTap,
    required this.onDownloadTap,
    this.isLoadingReceipt = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Update Status Button
        Expanded(
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: onUpdateStatusTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.appColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit_note_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Update Status",
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Download Button

        isLoadingReceipt
            ? CommonCircularIndicator()
            :
        GestureDetector(
          onTap: onDownloadTap,
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
            ),
            child: Icon(
              Icons.download_rounded,
              color: Colors.grey.shade700,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
