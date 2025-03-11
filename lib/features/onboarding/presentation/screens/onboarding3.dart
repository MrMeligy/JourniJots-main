import 'package:flutter/material.dart';
import 'package:journijots/core/utils/widgets/custom_button.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

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

          // Pana Image
          Positioned(
            top: 107,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/pana.png',
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
                    Text(
                      'Choose your Destination',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff8CB6DC),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  'With our travel services, you will explore the world with ease and comfort. Discover new destinations, enjoy delicious food.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff8CB6DC),
                  ),
                ),
                const SizedBox(height: 30),

                // Join Now Button
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'signupPage');
                  },
                  child: CustomButton(
                    text: 'Join Now',
                    backgroundColor: const Color(0xff8CB6DC),
                    borderColor: const Color(0xff8CB6DC),
                    textColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),

                // Log in Button
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'loginPage');
                  },
                  child: CustomButton(
                    text: 'Log in',
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    borderColor: const Color(0xff8CB6DC),
                    textColor: const Color(0xff8CB6DC),
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
