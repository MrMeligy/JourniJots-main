import 'package:flutter/material.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/core/utils/widgets/custom_button.dart';
import 'package:journijots/features/login-signup/presentation/screens/widgets/custom_textfeild.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: konboarding1textcolor,
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.07),

          // App Logo (Title)
          const Text(
            "JourniJots",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "Serif",
            ),
          ),
          SizedBox(height: screenHeight * 0.03),

          // Background Image (Responsive)
          Image.asset(
            'assets/images/Group.png',
            width: screenWidth * 0.7,
            height: screenHeight * 0.25,
            fit: BoxFit.contain,
          ),

          SizedBox(height: screenHeight * 0.03),

          // White Curved Container that takes the remaining space
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(screenWidth * 0.06),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Login Title
                    const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: kprimarycolor,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Email Label
                    const Text(
                      "Email",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.001),

                    // Email Text Field with Icon
                    const CustomTextField(label: 'Username', icon: Icons.email),

                    SizedBox(height: screenHeight * 0.01),

                    // Password Label
                    const Text(
                      "Password",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.001),

                    // Password Text Field with Icon
                    const CustomTextField(label: 'Password', icon: Icons.lock, isPassword: true),

                    SizedBox(height: screenHeight * 0.02),

                    // Sign Up & Forgot Password with Underline
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/SignUp'); 
                              },
                              child: const Text(
                                "Don't have an account? Sign up",
                                style: TextStyle(
                                    color: ksplashcolor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.47,
                              height: 1,
                              color: ksplashcolor,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigate to Forgot Password
                              },
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(
                                    color: ksplashcolor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.27,
                              height: 1,
                              color: ksplashcolor,
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.06,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child: CustomButton(
                          text: 'Log in',
                          backgroundColor: konboarding1textcolor,
                          borderColor: konboardingbuttun,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}