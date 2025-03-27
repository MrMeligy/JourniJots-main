import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/widgets/image_base.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    this.picture,
  });

  final String? picture;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Base64Image(
        base64String: picture, // Paste your full base64 string
        width: 60.w,
        height: 60.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
