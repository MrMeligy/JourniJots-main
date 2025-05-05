import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/profile/presentation/manager/follow_cubit/follow_cubit.dart';
import 'package:journijots/features/profile/presentation/manager/profile_posts_cubit/profile_posts_cubit.dart';
import 'package:journijots/features/profile/presentation/manager/repose/profile_repo_impl.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/interests_view_body.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/profile_header.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/profile_posts.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/trips_view_body.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.id, this.initialTabIndex = 0});
  final String id;
  final int initialTabIndex; // Optional parameter for initial tab index

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels > _lastOffset && _isVisible) {
      setState(() => _isVisible = false);
    } else if (_scrollController.position.pixels < _lastOffset && !_isVisible) {
      setState(() => _isVisible = true);
    }
    _lastOffset = _scrollController.position.pixels;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProfileCubit(getIt<ProfileRepoImpl>())..getProfile(id: widget.id),
        ),
        BlocProvider(
          create: (context) => FollowCubit(getIt<ProfileRepoImpl>()),
        ),
      ],
      child: DefaultTabController(
        length: 3,
        initialIndex: widget.initialTabIndex, // Set the initial tab index
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
                              ProfileHeader(profileModel: state.profileModel),
                              SizedBox(height: 20.h),
                              const TabBar(
                                labelColor: kprimarycolor,
                                unselectedLabelColor: Colors.grey,
                                indicatorColor: kprimarycolor,
                                tabs: [
                                  Tab(text: 'Posts'),
                                  Tab(text: 'Trips'),
                                  Tab(text: 'Interests'),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    const ProfilePosts(),
                                    TripsViewBody(
                                        scrollController: _scrollController),
                                    InterestsViewBody(
                                        scrollController: _scrollController),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const Skeletonizer(child: SkeletonizeProfileHeader());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SkeletonizeProfileHeader extends StatelessWidget {
  const SkeletonizeProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(600)),
              ),
            ),
            Positioned(
              bottom: -75.h,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 90.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                    ),
                    SizedBox(width: 9.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 100.w,
                                height: 20.h,
                                color: Colors.grey[300],
                              ),
                              SizedBox(width: 4.w),
                              Container(
                                width: 20.w,
                                height: 20.h,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                          Container(
                            width: 150.w,
                            height: 14.h,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
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
