import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/features/explore/presentation/screens/explore_screen.dart';
import 'package:journijots/features/home/presentation/screens/home_screen.dart';
import 'package:journijots/features/profile/presentation/screens/profile_page.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int _selectedIndex = 0;

  // Use PageController to manage page state
  final PageController _pageController = PageController();

  // Pages to navigate between (wrapped with AutomaticKeepAliveClientMixin)
  late final List<Widget> _pages = [
    const KeepAlivePage(child: HomeScreen()),
    const KeepAlivePage(child: ExploreScreen()),
    KeepAlivePage(
      child: ProfilePage(
        id: getIt<CacheHelper>().getData(key: ApiKey.id.toString()),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Use PageController to maintain state
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages, // Prevent swiping
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
              )
            ],
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, Icons.home, 'Home'),
                    _buildNavItem(1, Icons.explore, 'Explore'),
                    _buildNavItem(2, Icons.person, 'Profile'),
                  ],
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  bottom: 0,
                  left: MediaQuery.of(context).size.width / 3 * _selectedIndex +
                      (MediaQuery.of(context).size.width / 6 - 10),
                  child: Container(
                    width: 20,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _selectedIndex == index ? Colors.blue : Colors.grey,
              size: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

// Wrapper to preserve state
class KeepAlivePage extends StatefulWidget {
  final Widget child;

  const KeepAlivePage({super.key, required this.child});

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
