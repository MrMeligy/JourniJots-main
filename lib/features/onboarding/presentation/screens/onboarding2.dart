import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/features/onboarding/presentation/screens/widgets/onboarding2_body.dart';
import 'package:journijots/features/onboarding/presentation/screens/widgets/tween_animated_amico.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Rectangle Image
              Positioned(
                bottom: -60.h,
                left: 0,
                right: 0,
                child: Hero(
                  tag: 'bgonb',
                  child: Image.asset(
                    'assets/images/Rectangle 27_2.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Amico Image
              Positioned(
                top: height / 6,
                left: 0,
                right: 0,
                child: const TweenAnimatedAmico(
                  imageUrl: 'assets/images/amico2.png',
                ),
              ),
              const Onboarding2Body(),
            ],
          ),
        ),
      ),
    );
  }
}
