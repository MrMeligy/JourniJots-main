import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/home/presentation/screens/widgets/profile_picture.dart';
import 'package:journijots/features/profile/data/profile_model/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onFollowPressed;
  final ProfileModel profileModel;
  const ProfileHeader({
    super.key,
    required this.isFollowing,
    required this.onFollowPressed,
    required this.profileModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildCoverImage(),
        _buildProfileDetails(),
      ],
    );
  }

  Widget _buildCoverImage() {
    return Container(
      height: 150.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/pyramidBackground.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(600),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.h),
        child: const Align(
          alignment: Alignment.topRight,
        ),
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Positioned(
      bottom: -75.h,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildProfilePicture(),
            SizedBox(width: 9.w),
            _buildUserInfo(),
            (profileModel.userId !=
                    int.parse(
                      getIt<CacheHelper>().getData(key: ApiKey.id),
                    ))
                ? _buildFollowButton()
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return ProfilePicture(
      picture: profileModel.profilePicture,
      width: 90.w,
      height: 90.h,
      isProfileView: true,
    );
  }

  Widget _buildUserInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                profileModel.userName!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: const Color.fromARGB(255, 6, 6, 6),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              const Icon(
                Icons.verified,
                color: Colors.blueAccent,
              ),
            ],
          ),
          Text(
            'Expert Traveler',
            style: TextStyle(
              color: const Color.fromARGB(255, 107, 107, 107),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowButton() {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          child: GestureDetector(
            onTap: onFollowPressed,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isFollowing
                    ? const Color.fromARGB(255, 133, 198, 251)
                    : kprimarycolor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                isFollowing ? 'Following' : 'Follow +',
                style: const TextStyle(
                  color: kbodycolor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
