// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/bottom_nanv_bar.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/routes/app_routing.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/features/chatbot/peresntation/screens/journi_bot_screen.dart';
import 'package:journijots/features/explore/presentation/screens/city_screen.dart';
import 'package:journijots/features/explore/presentation/screens/explore_screen.dart';
import 'package:journijots/features/home/presentation/screens/home_screen.dart';
import 'package:journijots/features/auth/presentation/screens/login.dart';
import 'package:journijots/features/onboarding/presentation/screens/onboarding1.dart';
import 'package:journijots/features/place/presentation/screens/place_screen.dart';

class JournijotsApp extends StatelessWidget {
  const JournijotsApp({super.key, required this.appRouting});
  final AppRouting appRouting;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: getIt<CacheHelper>().getData(key: "isOnBoardingVisited") ?? false
            ? getIt<CacheHelper>().getData(key: "LoggedIn") ?? false
                ? const BottomNavBarPage()
                : const LoginScreen()
            : const Onboarding1(),
        onGenerateRoute: appRouting.generateRoute,
        theme: ThemeData(
          fontFamily: 'Acme',
        ),
      ),
    );
  }
}
