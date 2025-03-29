import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/profile/presentation/manager/profile_posts_cubit/profile_posts_cubit.dart';
import 'package:journijots/features/profile/presentation/manager/repose/profile_posts_repo_impl.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/interests_view_body.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/profile_header.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/profile_posts.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/trips_view_body.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.id});
  final String id;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;
  double _lastOffset = 0;
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == 0) {
      if (!_isVisible) {
        setState(() {
          _isVisible = true;
        });
      }
    }
    if (_scrollController.position.pixels > _lastOffset && _isVisible) {
      setState(() {
        _isVisible = false;
      });
    } else if (_scrollController.position.pixels < _lastOffset && !_isVisible) {
      setState(() {
        _isVisible = true;
      });
    }
    _lastOffset = _scrollController.position.pixels;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void followAction() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(getIt<ProfileRepoImpl>())
        ..getProfile(
          id: widget.id,
        ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return (state is ProfileSuccess)
                      ? Column(
                          children: [
                            ProfileHeader(
                              isFollowing: _isFollowing,
                              onFollowPressed: followAction,
                              profileModel: state.profileModel,
                            ),
                            SizedBox(height: 80.h),
                            TabBar(
                              controller: _tabController,
                              labelColor: kprimarycolor,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: kprimarycolor,
                              tabs: const [
                                Tab(text: 'Posts'),
                                Tab(text: 'Trips'),
                                Tab(text: 'Interests'),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  const ProfilePosts(),
                                  TripsViewBody(
                                    scrollController: _scrollController,
                                  ),
                                  InterestsViewBody(
                                    scrollController: _scrollController,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const Skeletonizer(
                          child: SkeletonizeProfileHeader(),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SkeletonizeProfileHeader extends StatelessWidget {
  const SkeletonizeProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Cover Image
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(600)),
              ),
            ),

            // Profile Details
            Positioned(
              bottom: -75.h,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Profile Picture
                    Container(
                      width: 90.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                    ),

                    SizedBox(width: 9.w),

                    // User Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // User Name
                              Container(
                                width: 100.w,
                                height: 20.h,
                                color: Colors.grey[300], // Placeholder
                              ),
                              SizedBox(width: 4.w),
                              // Verified Icon Placeholder
                              Container(
                                width: 20.w,
                                height: 20.h,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                          // User Bio Placeholder
                          Container(
                            width: 150.w,
                            height: 14.h,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),

                    // Follow Button
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      width: 80.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
