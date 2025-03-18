import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/home_view_body.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/interests_view_body.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/profile_header.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/trips_view_body.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                ProfileHeader(
                  isFollowing: _isFollowing,
                  onFollowPressed: followAction,
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
                      HomeViewBody(
                        scrollController: _scrollController,
                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}
