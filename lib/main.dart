import 'package:flutter/material.dart';
import 'package:journijots/features/splash/presentation/screens/splash_screen.dart';
import 'package:journijots/features/explore/presentation/screens/explore_screen.dart';
import 'package:journijots/features/interests/presentation/screens/intersts_screen.dart';
import 'package:journijots/features/auth/presentation/screens/login_screen.dart';
import 'package:journijots/core/utils/main_screen/main_screen.dart';
import 'package:journijots/features/onboarding/presentation/screens/onboarding1.dart';
import 'package:journijots/features/onboarding/presentation/screens/onboarding2.dart';
import 'package:journijots/features/onboarding/presentation/screens/onboarding3.dart';
import 'package:journijots/features/auth/presentation/screens/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'onboarding1': (context) => const Onboarding1(),
        'onboarding2': (context) => const Onboarding2(),
        'onboarding3': (context) => const Onboarding3(),
        'signupPage': (context) => const SignUpScreen(),
        'loginPage': (context) => const LoginScreen(),
        'explore': (context) => const ExploreScreen(),
        'mainscreen': (context) => const MainScreen(),
        'interests': (context) => const InterstsScreen(),
      },
      theme: ThemeData(fontFamily: 'Acme'),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
