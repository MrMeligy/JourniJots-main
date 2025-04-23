import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/widgets/image_base.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    this.picture,
    this.width,
    this.height,
    this.isProfileView,
  });

  final String? picture;
  final double? width;
  final double? height;
  final bool? isProfileView;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: isProfileView ?? false ? 4 : 0,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(80)),
      child: ClipOval(
        child: Base64Image(
          base64String: picture, // Paste your full base64 string
          width: width ?? 60.w,
          height: height ?? 60.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
