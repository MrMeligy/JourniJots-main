import 'package:flutter/material.dart';
import 'package:journijots/features/onboarding/presentation/screens/widgets/onboarding3_body.dart';
import 'package:journijots/features/onboarding/presentation/screens/widgets/tween_animated_amico.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              // Rectangle Image
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/Rectangle 27.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Pana Image
              Positioned(
                  top: height / 10,
                  left: 0,
                  right: 0,
                  child: const TweenAnimatedAmico(
                    imageUrl: 'assets/images/pana.png',
                  )),

              // Text
              const OnBoarding3Body(),
            ],
          ),
        ),
      ),
    );
  }
}
