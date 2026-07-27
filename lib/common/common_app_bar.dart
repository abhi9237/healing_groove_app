import 'package:flutter/material.dart';
import 'package:healing/core/storage/hive_storage_service.dart';

import '../core/color_constant/color_constant.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  final bool? showBackButton;
  const CommonAppBar({super.key, required this.title, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    final String fullName = HiveStorageService.getUserName() ?? '';
    final String firstName = fullName.trim().isEmpty ? '' : fullName.trim().split(' ').first;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if(showBackButton == true)
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: ColorConstant.lightBlackColor,
                  size: 26,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: 8),
              Text(
                title ?? '',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.appColor,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: ColorConstant.lightBlackColor,
                      size: 28,
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: ColorConstant.appColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
             
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorConstant.appColor, width: 1.5),
                ),
                child: Text(
                  firstName.substring(0,1),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.appColor,
                  ),
                ),
                // const CircleAvatar(
                //   radius: 18,
                //   backgroundColor: ColorConstant.lightGreenColor,
                //   backgroundImage: NetworkImage(
                //     'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=150&auto=format&fit=crop',
                //   ),
                // ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
