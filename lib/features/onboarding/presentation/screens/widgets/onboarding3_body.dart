import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/helper/extensions.dart';
import 'package:journijots/core/routes/routes.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/onboarding/presentation/screens/widgets/onboarding_button.dart';

class OnBoarding3Body extends StatelessWidget {
  const OnBoarding3Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double hieght = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Positioned(
      top: hieght / 1.5,
      left: width / 18,
      right: width / 18,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(seconds: 1),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Padding(
              padding: EdgeInsets.only(bottom: value * 20),
              child: child,
            ),
          );
        },
        child: Column(
          children: [
            Text(
              'Choose your Destination',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: kprimarycolor,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Text(
              'With our travel services, you will explore the world with ease and comfort. Discover new destinations, enjoy delicious food.',
              style: TextStyle(
                color: kprimarycolor,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: hieght / 25),
            OnBoardingButton(
              text: 'Join Now',
              onTap: () {
                context.pushNamed(Routes.signUpScreen);
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            OnBoardingButton(
              text: 'LogIn',
              onTap: () {
                context.pushNamed(Routes.logInScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
