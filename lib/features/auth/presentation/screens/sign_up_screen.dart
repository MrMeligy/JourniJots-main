import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journijots/builders/text_field_builder.dart';
import 'package:journijots/core/helper/extensions.dart';
import 'package:journijots/core/routes/routes.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/core/utils/widgets/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/jj.svg',
                height: 130,
              ),
              const SizedBox(height: 40),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: kprimarycolor,
                ),
              ),
              const SizedBox(height: 30),
              buildTextField('Username', Icons.person, false),
              const SizedBox(height: 20),
              buildTextField('E-mail', Icons.email, false),
              const SizedBox(height: 20),
              buildTextField('Password', Icons.lock, true),
              const SizedBox(height: 15),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "loginPage");
                  },
                  child: const Text(
                    "Already have an account? LOGIN",
                    style: TextStyle(color: kprimarycolor, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  context.pushNamed(Routes.interestsScreen);
                },
                child: CustomButton(
                  text: 'Sign up',
                  backgroundColor: const Color(0xff8CB6DC),
                  borderColor: const Color(0xff8CB6DC),
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
