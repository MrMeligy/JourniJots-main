import 'package:flutter/material.dart';
import 'package:journijots/core/utils/widgets/custom_button.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Rectangle Image
          Positioned(
            bottom: -60,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/Rectangle 27_2.png',
              fit: BoxFit.cover,
            ),
          ),

          // Amico Image
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/amico2.png',
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
                const Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Make your own memories',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'With our travel services, you will explore the world with ease and comfort. Discover new destinations, enjoy delicious food.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                // Next Button
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'onboarding3');
                  },
                  child: CustomButton(
                    text: 'Next',
                    backgroundColor: const Color(0xff8CB6DC),
                    borderColor: Colors.white,
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
