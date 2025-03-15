import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:journijots/builders/text_field_builder.dart';
import 'package:journijots/core/helper/extensions.dart';
import 'package:journijots/core/routes/routes.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/core/utils/text_styles.dart';
import 'package:journijots/core/utils/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/jj.svg',
                height: 150,
              ),
              const SizedBox(height: 40),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8CB6DC),
                ),
              ),
              const SizedBox(height: 30),
              buildTextField('Username', Icons.person, false),
              const SizedBox(height: 20),
              buildTextField('Password', Icons.lock, true),
              const SizedBox(height: 12),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot password?",
                        style: TextStyles.font16blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  context.pushNamed(Routes.homeScreen);
                },
                child: CustomButton(
                  text: 'Login',
                  backgroundColor: kprimarycolor,
                  borderColor: kprimarycolor,
                  textColor: Colors.white,
                ),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  context.pushNamed(Routes.interestsScreen);
                },
                child: CustomButton(
                  text: 'Sign up',
                  backgroundColor: kprimarycolor,
                  borderColor: kprimarycolor,
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
