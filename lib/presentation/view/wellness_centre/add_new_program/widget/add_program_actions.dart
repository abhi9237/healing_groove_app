import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class AddProgramActions extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final bool isLoading;
  final String submitButtonText;

  const AddProgramActions({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    this.isLoading = false,
    this.submitButtonText = 'Add Program',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Cancel Button
        Expanded(
          child: SizedBox(
            height: 52,
            child: OutlinedButton(
              onPressed: isLoading ? null : onCancel,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: ColorConstant.appColor, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(
                        
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Add Program Button
        Expanded(
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: isLoading ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.appColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      submitButtonText,
                      style: const TextStyle(
                              
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
