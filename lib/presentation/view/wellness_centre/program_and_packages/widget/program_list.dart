import 'package:flutter/material.dart';
import 'package:healing/controller/wellnesscentrecontroller/program_and_packages_controller.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'program_list_item.dart';

class ProgramList extends StatelessWidget {
  final List<DocModel> programs;
  final ProgramAndPackagesController controller;

  const ProgramList({
    super.key,
    required this.programs,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (programs.isEmpty) {
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
                "No packages found",
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
      itemCount: programs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final prog = programs[index];
        return ProgramListItem(
          program: prog,
          isDeleting: controller.deletingProgramId == prog.id,
          onPreviewTap: () => controller.previewProgram(context, prog),
          onEditTap: () => controller.editProgram(context, prog),
          onDeleteTap: () => _showDeleteBottomSheet(context, prog, controller),
        );
      },
    );
  }

  void _showDeleteBottomSheet(
    BuildContext context,
    DocModel program,
    ProgramAndPackagesController controller,
  ) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.red.shade600,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),

              // Title
              const Text(
                'Delete Program?',
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle text
              Text(
                'Are you sure you want to delete "${program.name ?? program.title ?? ''}"? This action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 14.5,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),

              // Buttons Row
              Row(
                children: [
                  // No/Cancel button
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFFE2E8F0),
                            width: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "No, Cancel",
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.lightBlackColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Delete button
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (program.id != null) {
                            controller.deleteProgram(context, program.id!);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade600,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
