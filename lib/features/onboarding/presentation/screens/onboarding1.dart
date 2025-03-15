import 'package:flutter/material.dart';
import 'package:journijots/features/onboarding/presentation/screens/widgets/onboarding1_body.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

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
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/Rectangle 27.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Amico Image
              Positioned(
                top: height / 6,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/amico.png',
                  width: double.infinity,
                ),
              ),

              // Text
              const Onboarding1Body(),
            ],
          ),
        ),
      ),
    );
  }
}
