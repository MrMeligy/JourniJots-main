import 'package:flutter/material.dart';
import 'package:journijots/features/splash/presentation/screens/widgets/splash_view_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Offset> _positionanimation;

  @override
  void initState() {
    super.initState();

    //Animation Setup
    animationSetub();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF68B0F8),
      body: SblashViewBody(
          animation: _animation, positionanimation: _positionanimation),
    );
  }

  void animationSetub() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _positionanimation =
        Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
            .animate(_controller);

    // Go To Home Screen after splash
    // Timer(const Duration(seconds: 2), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => const HomeScreen()),
    //   );
    // });
  }
}
