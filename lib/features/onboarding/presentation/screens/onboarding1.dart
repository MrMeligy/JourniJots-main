import 'package:flutter/material.dart';
import 'package:journijots/core/utils/widgets/custom_button.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            top: 153,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/amico.png',
              width: double.infinity,
            ),
          ),

          // Text
          Positioned(
            bottom: 15,
            left: 20,
            right: 20,
            child: Column(
              children: [
                const Text(
                  'Get ready for an unforgettable adventure',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff8CB6DC),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'With our travel services, you will explore the world with ease and comfort. Discover new destinations, enjoy delicious food.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff8CB6DC),
                  ),
                ),
                const SizedBox(height: 30),

                // Next Button
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'onboarding2');
                  },
                  child: CustomButton(
                    text: 'Next',
                    backgroundColor: const Color(0xff8CB6DC),
                    borderColor: const Color(0xff8CB6DC),
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
