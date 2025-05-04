import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/helper/extensions.dart';
import 'package:journijots/core/routes/routes.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/features/chatbot/peresntation/screens/journi_bot_screen.dart';
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

  final PageController _pageController = PageController();

  late final List<Widget> _pages = [
    const KeepAlivePage(child: HomeScreen()),
    const KeepAlivePage(child: ExploreScreen()),
    const KeepAlivePage(child: JourniBotScreen()),
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
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut, // ممكن تجرب Curves.easeOutCubic مثلاً
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      floatingActionButton: isKeyboardOpen
          ? null
          : SpeedDial(
              backgroundColor: const Color(0xff4183BF),
              icon: Icons.add,
              iconTheme: const IconThemeData(color: Colors.white),
              children: [
                SpeedDialChild(
                  child: const Icon(Icons.edit),
                  shape: const CircleBorder(),
                  label: 'Add Post',
                  labelStyle: const TextStyle(color: Colors.white),
                  backgroundColor: const Color(0xff4183BF),
                  foregroundColor: Colors.white,
                  labelBackgroundColor: const Color(0xff4183BF),
                  onTap: () {
                    context.pushNamed(Routes.addPostScreen);
                  },
                ),
                SpeedDialChild(
                  child: const Icon(Icons.travel_explore),
                  shape: const CircleBorder(),
                  label: 'Add Trip',
                  labelStyle: const TextStyle(color: Colors.white),
                  backgroundColor: const Color(0xff4183BF),
                  foregroundColor: Colors.white,
                  labelBackgroundColor: const Color(0xff4183BF),
                  onTap: () {},
                ),
              ],
            ),
      // FloatingActionButton(
      //     onPressed: () {
      //       // Action when + is pressed
      //     },
      //     shape: const CircleBorder(),
      //     backgroundColor: const Color(0xff4183BF),
      //     elevation: 5,
      //     child: const Icon(Icons.add, size: 30, color: Colors.white),
      //   ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 80.h,
        notchMargin: 8,
        color: const Color(0xff4183BF),
        child: SizedBox(
          height: 70.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(0, Icons.home),
              _buildNavItem(1, Icons.explore),
              const SizedBox(width: 40), // Space for FAB
              _buildNavItem(2, Icons.smart_toy_outlined),
              _buildNavItem(3, Icons.person),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        child: Icon(
          icon,
          size: 28,
          color: isSelected ? Colors.white : Colors.white70,
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
