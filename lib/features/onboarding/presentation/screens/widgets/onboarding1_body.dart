import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/helper/extensions.dart';
import 'package:journijots/core/routes/routes.dart';
import 'package:journijots/core/utils/text_styles.dart';
import 'package:journijots/features/onboarding/presentation/screens/widgets/onboarding_button.dart';

class Onboarding1Body extends StatelessWidget {
  const Onboarding1Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double hieght = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: hieght / 25,
      left: width / 18,
      right: width / 18,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          children: [
            Text(
              'Get ready for an unforgettable adventure',
              style: TextStyles.font32W600Blue,
            ),
            SizedBox(height: 20.h),
            Text(
              'With our travel services, you will explore the world with ease and comfort. Discover new destinations, enjoy delicious food.',
              style: TextStyles.font16Blue,
            ),
            SizedBox(height: hieght / 25),

            // Next Button
            OnBoardingButton(
              text: 'Next',
              onTap: () {
                context.pushNamed(Routes.onBoarding2);
              },
            ),
          ],
        ),
      ),
    );
  }
}
