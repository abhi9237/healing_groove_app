import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
export 'booking_reserved_dialog.dart';

class CommonCircularIndicator extends StatelessWidget {
  const CommonCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: ColorConstant.appColor,
      ),
    );
  }
}

void commonSnackBar(BuildContext context,String msg){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children:  [
          Icon(Icons.check_circle_rounded, color: Colors.white),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              msg,
              style: TextStyle(
                fontFamily: 'Afacad',
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: ColorConstant.appColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}



class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double radius;

  const UserAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    final initial = (name != null && name!.trim().isNotEmpty)
        ? name!.trim()[0].toUpperCase()
        : '?';

    Widget letterAvatar() {
      return CircleAvatar(
        radius: radius,
        backgroundColor: ColorConstant.appColor,
        child: Text(
          initial,
          style: TextStyle(
            color: Colors.white,
            fontSize: radius * 0.9,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return letterAvatar();
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: NetworkImage(imageUrl!),
      onBackgroundImageError: (_, __) {},
      child: ClipOval(
        child: Image.network(
          imageUrl!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => letterAvatar(),
        ),
      ),
    );
  }
}