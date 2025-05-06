import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          borderRadius: BorderRadius.circular(100)),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: picture ?? '',
          fit: BoxFit.cover,
          width: isProfileView ?? false ? 80.w : 50.w,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) =>
              Image.asset("assets/images/avatar.png"),
        ),
      ),
    );
  }
}
