import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/routes/app_routing.dart';
import 'package:journijots/features/home/presentation/screens/home_screen.dart';
import 'package:journijots/features/login-signup/presentation/screens/login.dart';
import 'package:journijots/features/onboarding/presentation/screens/onboarding1.dart';

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
        home: const LoginScreen(),
        onGenerateRoute: appRouting.generateRoute,
        theme: ThemeData(
          fontFamily: 'Acme',
        ),
      ),
    );
  }
}
