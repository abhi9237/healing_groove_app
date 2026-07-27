import 'package:flutter/material.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import '../../../../../core/color_constant/color_constant.dart';

class UserHomeHeader extends StatelessWidget {
  const UserHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Welcome text
          const Expanded(
            child: Text(
              'Welcome back, Akshay',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: ColorConstant.appColor,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Notification Bell Icon with Badge
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                    color: ColorConstant.lightBlackColor,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
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

          // User Profile Image Avatar
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorConstant.appColor,
                width: 2.0,
              ),
            ),
            child:Text(
            ( HiveStorageService.getUserName() ??'').substring(0,1),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ColorConstant.appColor,
              ),
            )
            // const CircleAvatar(
            //   radius: 22,
            //   backgroundColor: ColorConstant.lightGreenColor,
            //   backgroundImage: NetworkImage(
            //     'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=150&auto=format&fit=crop',
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
