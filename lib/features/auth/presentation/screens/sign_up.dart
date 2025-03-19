import 'package:flutter/material.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/core/utils/widgets/custom_button.dart';
import 'package:journijots/features/auth/presentation/screens/widgets/custom_textfeild.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: konboarding1textcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.04),

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
              SizedBox(height: screenHeight * 0.02),

              // Background Image (Responsive)
              Image.asset(
                'assets/images/Layer_1.png',
                width: screenWidth * 0.6,
                height: screenHeight * 0.2,
                fit: BoxFit.contain,
              ),

              SizedBox(height: screenHeight * 0.02),

              // White Curved Container
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.03,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kprimarycolor,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    const Text(
                      "Frist Name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.001),
                    const CustomTextField(
                        label: 'First Name', icon: Icons.person),
                    SizedBox(height: screenHeight * 0.01),
                    const Text(
                      "Last Name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.001),
                    const CustomTextField(
                        label: 'Last Name', icon: Icons.person),
                    SizedBox(height: screenHeight * 0.01),
                    const Text(
                      "User Name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.001),
                    const CustomTextField(
                        label: 'Username', icon: Icons.person_outline),
                    SizedBox(height: screenHeight * 0.01),
                    const Text(
                      "Date of Birth",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.001),
                    const CustomTextField(
                        label: 'Date of Birth', icon: Icons.cake),
                    SizedBox(height: screenHeight * 0.01),
                    const Text(
                      "Email",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.001),
                    const CustomTextField(label: 'Email', icon: Icons.email),
                    SizedBox(height: screenHeight * 0.01),
                    const Text(
                      "Password",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.001),
                    const CustomTextField(
                        label: 'Password', icon: Icons.lock, isPassword: true),
                    SizedBox(height: screenHeight * 0.02),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/logIn');
                        },
                        child: const Text(
                          "Already have an account? Login",
                          style: TextStyle(
                              color: ksplashcolor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: screenWidth * 0.5,
                        height: 1,
                        color: ksplashcolor,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.06,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/Interests');
                        },
                        child: CustomButton(
                          text: 'Sign up',
                          backgroundColor: konboarding1textcolor,
                          borderColor: konboardingbuttun,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
