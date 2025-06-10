import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/features/actions/presentation/manager/cubits/cubit/add_post_cubit.dart';
import 'package:journijots/features/actions/presentation/manager/repos/create_post_repo_impl.dart';
import 'package:journijots/features/actions/presentation/screens/create_post_page.dart';
import 'package:journijots/features/chatbot/peresntation/screens/journi_bot_screen.dart';
import 'package:journijots/features/explore/presentation/screens/explore_screen.dart';
import 'package:journijots/features/home/presentation/screens/home_screen.dart';
import 'package:journijots/features/profile/presentation/screens/profile_page.dart';
import 'package:journijots/features/trip/presentation/managers/cubits/add_trip_cubit/add_trip_cubit.dart';
import 'package:journijots/features/trip/presentation/managers/repos/add_trip_repo_impl.dart';
import 'package:journijots/features/trip/presentation/screens/add_trip.dart';

class BottomNavBarPage extends StatefulWidget {
  final int? initialPageIndex,
      initialTapIndex; // Optional parameter for initial page index

  const BottomNavBarPage(
      {super.key, this.initialPageIndex, this.initialTapIndex});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  late int _selectedIndex;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex =
        widget.initialPageIndex ?? 0; // Default to 0 if not provided
    _pageController = PageController(initialPage: _selectedIndex);
  }

  late final List<Widget> _pages = [
    const KeepAlivePage(child: HomeScreen()),
    const KeepAlivePage(child: ExploreScreen()),
    const KeepAlivePage(child: JourniBotScreen()),
    KeepAlivePage(
      child: ProfilePage(
        id: getIt<CacheHelper>().getData(key: ApiKey.id.toString()),
        initialTabIndex: widget.initialTapIndex ?? 0,
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
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
        floatingActionButton: isKeyboardOpen
            ? null
            : SpeedDial(
                heroTag: "floatingActionButton",
                backgroundColor: const Color(0xff4183BF),
                icon: Icons.add,
                iconTheme: const IconThemeData(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                children: [
                  SpeedDialChild(
                    child: const Icon(Icons.edit),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    label: 'Add Post',
                    labelStyle: const TextStyle(color: Colors.white),
                    backgroundColor: const Color(0xff4183BF),
                    foregroundColor: Colors.white,
                    labelBackgroundColor: const Color(0xff4183BF),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) =>
                                AddPostCubit(getIt<CreatePostRepoImpl>()),
                            child: const CreatePostPage(),
                          ),
                        ),
                      );
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.travel_explore),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    label: 'Add Trip',
                    labelStyle: const TextStyle(color: Colors.white),
                    backgroundColor: const Color(0xff4183BF),
                    foregroundColor: Colors.white,
                    labelBackgroundColor: const Color(0xff4183BF),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (_) =>
                                AddTripCubit(getIt<AddTripRepoImpl>()),
                            child: const AddTripPage(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
        // Use centerDocked to position FAB in the notch with no separation
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBottomAppBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
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

class CustomBottomAppBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomAppBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, 75.h),
      painter: BottomNavBarPainter(),
      child: SizedBox(
        height: 75.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(0, Icons.home),
            _buildNavItem(1, Icons.explore),
            const SizedBox(width: 80), // Increased space for larger FAB cutout
            _buildNavItem(2, Icons.smart_toy_outlined),
            _buildNavItem(3, Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        child: Icon(
          icon,
          size: 37,
          color: isSelected ? Colors.white : Colors.white70,
        ),
      ),
    );
  }
}

class BottomNavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xff4183BF)
      ..style = PaintingStyle.fill;

    Path path = Path();

    // Start from bottom left
    path.moveTo(0, size.height);

    // Go to top left with rounded corner
    path.lineTo(0, 24);
    path.quadraticBezierTo(0, 0, 24, 0);

    // Go to the start of the larger notch (wider cutout for FAB)
    path.lineTo(size.width * 0.28, 0);

    // Create a bigger curved notch for FAB with smoother transitions
    // Left side of the notch - gradual curve down
    path.quadraticBezierTo(size.width * 0.32, 0, size.width * 0.35, 8);
    path.quadraticBezierTo(size.width * 0.38, 18, size.width * 0.42, 28);

    // Bottom of the notch - deeper curve
    path.quadraticBezierTo(size.width * 0.46, 38, size.width * 0.50, 42);
    path.quadraticBezierTo(size.width * 0.54, 38, size.width * 0.58, 28);

    // Right side of the notch - gradual curve up
    path.quadraticBezierTo(size.width * 0.62, 18, size.width * 0.65, 8);
    path.quadraticBezierTo(size.width * 0.68, 0, size.width * 0.72, 0);

    // Go to top right with rounded corner
    path.lineTo(size.width - 24, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 24);

    // Go to bottom right
    path.lineTo(size.width, size.height);

    // Close the path
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
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
