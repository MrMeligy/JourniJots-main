import 'package:flutter/material.dart';
import 'package:journijots/core/routes/routes.dart';
import 'package:journijots/features/home/presentation/screens/home_screen.dart';
import 'package:journijots/features/onboarding/presentation/screens/onboarding1.dart';
import 'package:journijots/features/onboarding/presentation/screens/onboarding2.dart';
import 'package:journijots/features/onboarding/presentation/screens/onboarding3.dart';
import 'package:journijots/features/onboarding/presentation/screens/onboarding_screen.dart';

class AppRouting {
  Route generateRoute(RouteSettings settings) {
    //passed to screen like argument as className
    // ignore: unused_local_variable
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.onBoarding1:
        return MaterialPageRoute(builder: (_) => const Onboarding1());
      case Routes.onBoarding2:
        return MaterialPageRoute(builder: (_) => const Onboarding2());
      case Routes.onBoarding3:
        return MaterialPageRoute(builder: (_) => const Onboarding3());
      // case Routes.logInScreen:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      // case Routes.signUpScreen:
      //   return MaterialPageRoute(builder: (_) => const SignUpScreen());
      // case Routes.interestsScreen:
      //   return MaterialPageRoute(builder: (_) => const InterstsScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      // case Routes.exploreScreen:
      //   return MaterialPageRoute(builder: (_) => const ExploreScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No Route Define For ${settings.name}"),
            ),
          ),
        );
    }
  }
}
